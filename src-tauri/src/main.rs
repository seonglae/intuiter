// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use std::process::Command;
use std::path::PathBuf;
use tauri::Manager;

// ============= Windows (AHK) =============
#[cfg(target_os = "windows")]
fn get_ahk_path(app_handle: &tauri::AppHandle) -> PathBuf {
    let resource_dir = app_handle
        .path()
        .resource_dir()
        .expect("Failed to get resource directory");
    resource_dir.join("ahk").join("Intuit.exe")
}

#[cfg(target_os = "windows")]
#[tauri::command]
async fn spawn_input(app_handle: tauri::AppHandle) -> Result<String, String> {
    let ahk_path = get_ahk_path(&app_handle);

    if !ahk_path.exists() {
        return Err(format!("AHK executable not found at: {:?}", ahk_path));
    }

    let working_dir = ahk_path.parent().unwrap_or(&ahk_path);

    match Command::new(&ahk_path)
        .current_dir(working_dir)
        .spawn()
    {
        Ok(child) => {
            println!("AHK process spawned with PID: {}", child.id());
            Ok(format!("AHK started with PID: {}", child.id()))
        }
        Err(e) => {
            eprintln!("Failed to spawn AHK: {}", e);
            Err(format!("Failed to spawn AHK: {}", e))
        }
    }
}

#[cfg(target_os = "windows")]
#[tauri::command]
async fn kill_input() -> Result<String, String> {
    match Command::new("taskkill")
        .args(["/IM", "Intuit.exe", "/F"])
        .output()
    {
        Ok(output) => {
            if output.status.success() {
                Ok("AHK process killed".to_string())
            } else {
                let stderr = String::from_utf8_lossy(&output.stderr);
                Err(format!("Failed to kill AHK: {}", stderr))
            }
        }
        Err(e) => Err(format!("Failed to execute taskkill: {}", e)),
    }
}

#[cfg(target_os = "windows")]
#[tauri::command]
async fn check_input_status() -> Result<bool, String> {
    match Command::new("tasklist")
        .args(["/FI", "IMAGENAME eq Intuit.exe", "/NH"])
        .output()
    {
        Ok(output) => {
            let stdout = String::from_utf8_lossy(&output.stdout);
            Ok(stdout.contains("Intuit.exe"))
        }
        Err(e) => Err(format!("Failed to check status: {}", e)),
    }
}

// ============= macOS (Hammerspoon) =============
#[cfg(target_os = "macos")]
fn get_hammerspoon_dir() -> PathBuf {
    dirs::home_dir()
        .expect("Failed to get home directory")
        .join(".hammerspoon")
}

#[cfg(target_os = "macos")]
fn find_hammerspoon_app() -> Option<PathBuf> {
    let locations = [
        "/Applications/Hammerspoon.app",
        "/opt/homebrew/Caskroom/hammerspoon",
    ];

    // Check common locations
    for loc in locations {
        let path = std::path::Path::new(loc);
        if path.exists() {
            return Some(path.to_path_buf());
        }
    }

    // Check user's Applications folder
    if let Some(home) = dirs::home_dir() {
        let user_app = home.join("Applications/Hammerspoon.app");
        if user_app.exists() {
            return Some(user_app);
        }
    }

    // Check if `hs` CLI is available in PATH
    if let Ok(output) = Command::new("which").arg("hs").output() {
        if output.status.success() {
            return Some(PathBuf::from("/usr/local/bin/hs"));
        }
    }

    None
}

#[cfg(target_os = "macos")]
#[tauri::command]
async fn spawn_input(app_handle: tauri::AppHandle) -> Result<String, String> {
    // Get source and destination paths
    let resource_dir = app_handle
        .path()
        .resource_dir()
        .expect("Failed to get resource directory");
    let source_dir = resource_dir.join("mac-input").join("hammerspoon");
    let dest_dir = get_hammerspoon_dir();

    // Create destination directory
    if let Err(e) = std::fs::create_dir_all(&dest_dir) {
        return Err(format!("Failed to create .hammerspoon directory: {}", e));
    }

    // Copy Lua configuration files
    let files = ["init.lua", "config.lua", "mouse.lua", "text.lua"];
    for file in files {
        let src = source_dir.join(file);
        let dst = dest_dir.join(file);
        if src.exists() {
            if let Err(e) = std::fs::copy(&src, &dst) {
                eprintln!("Failed to copy {}: {}", file, e);
            }
        }
    }

    // Try to start Hammerspoon
    match Command::new("open").args(["-a", "Hammerspoon"]).spawn() {
        Ok(_) => {
            // Try to reload config via CLI (may not be available)
            std::thread::sleep(std::time::Duration::from_millis(500));
            let _ = Command::new("hs").args(["-c", "hs.reload()"]).output();
            Ok("Hammerspoon config loaded".to_string())
        }
        Err(_) => {
            // Hammerspoon not found, but config is still copied
            Ok("Config copied to ~/.hammerspoon - install Hammerspoon to activate".to_string())
        }
    }
}

#[cfg(target_os = "macos")]
#[tauri::command]
async fn kill_input() -> Result<String, String> {
    match Command::new("pkill")
        .args(["-x", "Hammerspoon"])
        .output()
    {
        Ok(_) => Ok("Hammerspoon stopped".to_string()),
        Err(e) => Err(format!("Failed to stop Hammerspoon: {}", e)),
    }
}

#[cfg(target_os = "macos")]
#[tauri::command]
async fn check_input_status() -> Result<bool, String> {
    match Command::new("pgrep")
        .args(["-x", "Hammerspoon"])
        .output()
    {
        Ok(output) => Ok(output.status.success()),
        Err(e) => Err(format!("Failed to check status: {}", e)),
    }
}

// ============= Linux (placeholder) =============
#[cfg(target_os = "linux")]
#[tauri::command]
async fn spawn_input(_app_handle: tauri::AppHandle) -> Result<String, String> {
    Err("Linux input control not yet implemented".to_string())
}

#[cfg(target_os = "linux")]
#[tauri::command]
async fn kill_input() -> Result<String, String> {
    Err("Linux input control not yet implemented".to_string())
}

#[cfg(target_os = "linux")]
#[tauri::command]
async fn check_input_status() -> Result<bool, String> {
    Ok(false)
}

// ============= Common =============
#[tauri::command]
async fn restart_input(app_handle: tauri::AppHandle) -> Result<String, String> {
    let _ = kill_input().await;
    tokio::time::sleep(tokio::time::Duration::from_millis(500)).await;
    spawn_input(app_handle).await
}

#[tauri::command]
fn get_platform() -> String {
    #[cfg(target_os = "windows")]
    return "windows".to_string();
    #[cfg(target_os = "macos")]
    return "macos".to_string();
    #[cfg(target_os = "linux")]
    return "linux".to_string();
}

fn main() {
    tauri::Builder::default()
        .plugin(tauri_plugin_shell::init())
        .plugin(tauri_plugin_process::init())
        .invoke_handler(tauri::generate_handler![
            spawn_input,
            kill_input,
            restart_input,
            check_input_status,
            get_platform
        ])
        .setup(|_app| {
            Ok(())
        })
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
