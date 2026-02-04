const { spawn } = require('child_process');
const { join } = require('path');
const { existsSync, rmSync } = require('fs');

// AHK package is sibling to ahk-builder
const AHK_DIR = join(__dirname, '..', '..', 'ahk');
const COMPILER = join(AHK_DIR, 'exe', 'ahk', 'Ahk2Exe.exe');
const SCRIPT = join(AHK_DIR, 'runner.ahk');
const OUTPUT = join(AHK_DIR, 'Intuit.exe');
const ICON = join(AHK_DIR, 'img', 'logo.ico');

function build() {
  if (!existsSync(COMPILER)) {
    console.error(`Compiler not found at ${COMPILER}`);
    process.exit(1);
  }

  if (existsSync(OUTPUT)) {
    rmSync(OUTPUT);
  }

  console.log('Compiling AHK...');
  console.log(`  Script: ${SCRIPT}`);
  console.log(`  Output: ${OUTPUT}`);

  const args = ['/in', SCRIPT, '/out', OUTPUT, '/icon', ICON];
  const child = spawn(COMPILER, args, { stdio: 'inherit' });

  child.on('close', (code) => {
    if (code !== 0) {
      console.error('AHK compile failed');
      process.exit(1);
    }
    console.log('AHK compile successful!');
  });
}

build();
