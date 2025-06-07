
<p align="center">
<img src="./asset/images/button.gif"/>
</p>

<p align="center">
<img src="./asset/icons/white.png" width="100"/>
</p>

<h1 align="center">
Intuiter
</h1>
<p align="center">
<img src="https://img.shields.io/badge/Electron-based-blue?logo=electron&logoColor=white"/>
<img src="https://img.shields.io/github/languages/top/seonglae/intuiter"/>
<img src="https://badges.frapsoft.com/os/mit/mit.svg?v=103"/>
<a href="https://lgtm.com/projects/g/seonglae/intuiter/context:javascript"><img alt="undefined" src="https://img.shields.io/lgtm/grade/javascript/g/seonglae/intuiter.svg?logo=lgtm&logoWidth=18"/>
<p>
</p>

<h3 align="center">
If you Use PC, this program will definitely help you.
</h3>
<h4 align="center">
Windows global version Vim Substitute and++
</h4>


Vim and Emacs are too hard and not intuitive.
So I developed new key map which can be used by not only for developers but also normal users.
- Solved the complexity of existing shortcut applications (Vim, Emacs) with an easier usage.
- Increased universality to work in any software by letting the app run in the background.
- Bound Electron and AutoHotKey by including AHK compiler in the installer which make AHK script run dynamically.
- Added a smooth mouse control on keyboard by calling Windows mouse API DLL.
- Change Windows virtual desktops directly with `Ctrl + Win + number`.

<br/>


# [Document](https://intuiter.vercel.app/) /  [사용법](https://intuiter.vercel.app/ko/)

## Monorepo Structure

This project is organised as a Turborepo with packages under `packages/`.
Major workspaces include:

- `@intuit/ahk` – AutoHotkey sources
- `@intuit/ahk-builder` – CLI to compile AHK to `Intuit.exe`
- `@intuit/renderer` – Frontend UI built with Vite

Check [here](https://intuiter.vercel.app/) / 여기에 [사용법](https://intuiter.vercel.app/ko/) 있음

![image](https://user-images.githubusercontent.com/27716524/129465756-07e5d9bf-0a21-40bf-aaca-978f7c877884.png)



# [Download](https://github.com/seonglae/intuiter/releases/latest/download/Intuiter.exe)
### Or more simply, install by command
```bash
winget install intuiter
```

<br/>

## Project Stats
![Alt](https://repobeats.axiom.co/api/embed/f9927162b6bd945f38bc724c637836e6075443a0.svg "Repobeats analytics image")


# Warning
This Program coulb be considered as game hack


# Made with
- [Daning Button](https://github.com/seonglae/dancing-button)
- Electron
- AHK





# How to Contribute

- **AHK user** can contribute to `/packages/ahk` **Core**
- **TS user** can contribute to `/packages/renderer` **UI**
- [VSCode Version](https://marketplace.visualstudio.com/items?itemName=seonglae.terminal-intuiter)

## AHK Builder

AutoHotkey sources can be rebuilt using the package under
`packages/ahk-builder`. It invokes the bundled `Ahk2Exe.exe` compiler and
produces `Intuit.exe` under `packages/ahk`.

Run the builder with:

```bash
pnpm --filter @intuit/ahk-builder build
```

This makes it easy to reload or extend AHK modules during development.

