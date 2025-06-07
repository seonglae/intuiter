import { spawn } from 'child_process';
import { join } from 'path';
import { existsSync, rmSync } from 'fs';

const AHK_DIR = join(__dirname, '..', 'ahk');
const COMPILER = join(AHK_DIR, 'exe', 'ahk', 'Ahk2Exe.exe');
const SCRIPT = join(AHK_DIR, 'runner.ahk');
const OUTPUT = join(AHK_DIR, 'Intuit.exe');
const ICON = join(AHK_DIR, 'img', 'logo.ico');

export function build() {
  if (!existsSync(COMPILER)) {
    throw new Error(`Compiler not found at ${COMPILER}`);
  }

  if (existsSync(OUTPUT)) rmSync(OUTPUT);

  const args = ['/in', SCRIPT, '/out', OUTPUT, '/icon', ICON];
  const child = spawn(COMPILER, args, { stdio: 'inherit' });
  child.on('close', (code) => {
    if (code !== 0) throw new Error('AHK compile failed');
  });
}

if (require.main === module) build();
