// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use std::process::Command;
use std::path::PathBuf;
use tauri::Manager;

/// Get the path to the AHK executable
fn get_ahk_path(app_handle: &tauri::AppHandle) -> PathBuf {
    let resource_dir = app_handle
        .path()
        .resource_dir()
        .expect("Failed to get resource directory");
    resource_dir.join("ahk").join("Intuit.exe")
}

/// Spawn the AHK process - critical functionality for Intuiter
#[tauri::command]
async fn spawn_ahk(app_handle: tauri::AppHandle) -> Result<String, String> {
    let ahk_path = get_ahk_path(&app_handle);

    if !ahk_path.exists() {
        return Err(format!("AHK executable not found at: {:?}", ahk_path));
    }

    // Get the parent directory for working directory
    let working_dir = ahk_path.parent().unwrap_or(&ahk_path);

    // Spawn the AHK process
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

/// Kill the AHK process
#[tauri::command]
async fn kill_ahk() -> Result<String, String> {
    #[cfg(target_os = "windows")]
    {
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

    #[cfg(not(target_os = "windows"))]
    {
        Err("AHK is only supported on Windows".to_string())
    }
}

/// Restart the AHK process
#[tauri::command]
async fn restart_ahk(app_handle: tauri::AppHandle) -> Result<String, String> {
    // First kill existing process
    let _ = kill_ahk().await;

    // Small delay to ensure process is terminated
    tokio::time::sleep(tokio::time::Duration::from_millis(500)).await;

    // Spawn new process
    spawn_ahk(app_handle).await
}

/// Check if AHK is running
#[tauri::command]
async fn check_ahk_status() -> Result<bool, String> {
    #[cfg(target_os = "windows")]
    {
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

    #[cfg(not(target_os = "windows"))]
    {
        Ok(false)
    }
}

fn main() {
    tauri::Builder::default()
        .plugin(tauri_plugin_shell::init())
        .invoke_handler(tauri::generate_handler![
            spawn_ahk,
            kill_ahk,
            restart_ahk,
            check_ahk_status
        ])
        .setup(|app| {
            // Auto-start AHK on Windows
            #[cfg(target_os = "windows")]
            {
                let app_handle = app.handle().clone();
                tauri::async_runtime::spawn(async move {
                    if let Err(e) = spawn_ahk(app_handle).await {
                        eprintln!("Failed to auto-start AHK: {}", e);
                    }
                });
            }
            Ok(())
        })
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
