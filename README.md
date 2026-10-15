<p align="center"><img src="port/packaging/icon/infamous-icon-1024.png" width="140" alt=""></p>

<h1 align="center">inFAMOUS First Light — native PC port</h1>

<p align="center">
  <a href="#français"><b>Français plus bas</b></a> ·
  <a href="https://github.com/GamaxyF/ifl_pc/releases/latest">Download</a> ·
  <a href="docs/FIRST_LIGHT_FILES.md">Required game files</a>
</p>

**inFAMOUS First Light** (PS4, CUSA00575, base 1.00 + update 1.04) running on PC without a CPU emulator: the game's own code runs natively on the processor, the PS4 system is reimplemented and the GPU is translated to Vulkan.

This is a fork of **[HayatoG/iss_pc](https://github.com/HayatoG/iss_pc)**, the inFAMOUS Second Son PC port (based on its release `v2026.10.15-515dd40`). First Light is a standalone expansion built on the same Sucker Punch engine, so almost all of that port carries over; this fork adds what First Light needs on top of it.

> **No game files come with this project.** To play, you need your own copy, dumped from your own PS4. See [docs/FIRST_LIGHT_FILES.md](docs/FIRST_LIGHT_FILES.md).

## Status

| Area | State |
|---|---|
| Boot, menus, gameplay, saves | ✅ Works (tested on Windows 10, RTX 3060 Ti, i5-10400F, from a source build) |
| Audio, controller, mouse | ✅ Same as the Second Son port |
| Performance | 🔧 About 25-60 FPS depending on the scene; the GPU command translation on the CPU is the limit |
| Image | 🔧 Some flickering left; the defaults below remove most of it |
| Windows release package | 🧪 Built automatically, not yet tested in game |
| Linux | 🧪 Builds; not yet tested in game |

## What this fork changes

- **System functions First Light imports** that Second Son does not: the "A" variants of the PSN leaderboard / user storage calls (`src/runtime_firstlight.c`, offline answers) and the `sce::Json` parser and accessors (`src/runtime_gr2_json.c`).
- **Launcher**: First Light by default (`ISS_GAME=secondson` for Second Son), its own settings file, a French interface, automatic game language.
- **Flickering**: texture cache sized from the card's own memory (`TLG_GC_BUDGET_MB=card`, no more black flashes from evicted textures), GPU results read without a frame of delay, full-screen passes never skipped while a shader compiles (BP07), occlusion queries answered "visible".
- **Shader fixes** from [shadPS4-Infamous-FixBuild](https://github.com/rayhlancaner-png/shadPS4-Infamous-FixBuild): SDWA compare destinations, samplers forced to unnormalized coordinates.
- **Windows**: crash reports with the full call stack, 1 ms timer resolution, VSync off by default (Mailbox).

## Playing

1. Download `firstlight-windows-x86_64.zip` from [Releases](https://github.com/GamaxyF/ifl_pc/releases) and extract it.
2. Build the game folder from your dump: base game 1.00, then update 1.04 copied over it ([details](docs/FIRST_LIGHT_FILES.md)).
3. Open `inFAMOUS First Light.exe`, pick the game folder, click **Play**.

In game: **F10** FPS counter, **Insert** (or R3 + L2) port menu. More in [port/packaging/README-player.md](port/packaging/README-player.md).

## Building from source (Windows)

1. Install [MSYS2](https://www.msys2.org/) and, in its CLANG64 shell, the packages listed in [.github/workflows/build.yml](.github/workflows/build.yml) (`mingw-w64-clang-x86_64-toolchain`, `cmake`, `ninja`, `vulkan-*`, `sdl3`, `ffmpeg`, `spirv-*`...).
2. Install Python 3.8+ for Windows and `pip install iced-x86`.
3. `git clone --recursive https://github.com/GamaxyF/ifl_pc`, then in the CLANG64 shell: `cd ifl_pc/port && bash build.sh` (`TLG_LTO=ON` for a faster build of the GPU library).
4. Double-click `launcher_firstlight.bat` (launcher window) or `run_firstlight.bat` (starts the game directly; asks for the game folder once).

## Credits

- **[HayatoG](https://github.com/HayatoG)** — the inFAMOUS Second Son PC port this fork is built on, and its native PS4 core (from the God of War III, Bloodborne, The Last Guardian and Gravity Rush 2 ports). Original README: [docs/README-second-son.md](docs/README-second-son.md).
- **[shadPS4](https://github.com/shadps4-emu/shadPS4)** — the GPU core (`port/gpu/shadps4/`) and its function name tables.
- **[shadPS4-Infamous-FixBuild](https://github.com/rayhlancaner-png/shadPS4-Infamous-FixBuild)** — inFAMOUS fixes, several of them already in the base port.
- First Light adaptation: **GamaxyF**.

License: **GNU GPL v2 or later** ([port/LICENSE](port/LICENSE)); third-party components keep their own licenses. inFAMOUS is a trademark of Sony Interactive Entertainment; this project is not affiliated with Sony or Sucker Punch.

---

## Français

**inFAMOUS First Light** (PS4, CUSA00575, jeu de base 1.00 + mise à jour 1.04) sur PC, sans émulateur de processeur : le code du jeu tourne nativement, le système de la PS4 est réimplémenté et le GPU est traduit en Vulkan. C'est un fork de **[HayatoG/iss_pc](https://github.com/HayatoG/iss_pc)**, le port PC d'inFAMOUS Second Son : First Light utilise le même moteur.

> **Aucun fichier du jeu n'est fourni.** Il te faut ta propre copie, dumpée depuis ta PS4 : voir [docs/FIRST_LIGHT_FILES.md](docs/FIRST_LIGHT_FILES.md).

**État :** le jeu démarre, se joue et sauvegarde (testé sous Windows 10, RTX 3060 Ti, i5-10400F). Il reste un peu de scintillement, et les FPS varient d'environ 25 à 60 selon la scène.

**Pour jouer :**
1. Télécharge `firstlight-windows-x86_64.zip` dans les [Releases](https://github.com/GamaxyF/ifl_pc/releases) et extrais-le.
2. Prépare le dossier du jeu : jeu de base 1.00, puis la mise à jour 1.04 copiée par-dessus.
3. Ouvre `inFAMOUS First Light.exe`, choisis le dossier du jeu et clique sur **Jouer**. L'interface est en français si ton Windows l'est.

**Réglages par défaut pour First Light** (modifiables dans le lanceur) : budget de textures automatique selon ta carte, VSync désactivée (Mailbox), et trois réglages contre le scintillement des bâtiments.

**Crédits :** HayatoG (port de Second Son), shadPS4, shadPS4-Infamous-FixBuild ; adaptation à First Light : GamaxyF. Licence GPL v2 ou ultérieure.
