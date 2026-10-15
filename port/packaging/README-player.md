# inFAMOUS First Light — PC port

Fork by GamaxyF of [HayatoG/iss_pc](https://github.com/HayatoG/iss_pc) (the inFAMOUS Second Son PC port), adapted to inFAMOUS First Light. Code: [github.com/GamaxyF/ifl_pc](https://github.com/GamaxyF/ifl_pc).

**No game files are included.** You need your own copy of inFAMOUS First Light for PS4. / **Aucun fichier du jeu n'est inclus.** Il te faut ta propre copie d'inFAMOUS First Light sur PS4.

In development: the game boots, plays and saves; there is still some flickering and the frame rate depends on the scene (about 25-60 FPS on an RTX 3060 Ti). / En développement : le jeu démarre, se joue et sauvegarde ; il reste un peu de scintillement et les FPS varient selon la scène.

---

## English

### Game files

Use **inFAMOUS First Light CUSA00575 (US), base game 1.00 with update 1.04**, dumped (decrypted) from your PS4 with GoldHEN + Itemzflow, and merged into one folder: copy the base game, then copy the update **over it**, replacing the files. Nothing from the console firmware is needed.

**PC:** Windows 10 (1903+)/11 64-bit or Linux x86-64 (glibc 2.39+), a Vulkan 1.3 graphics card (6 GB of VRAM recommended). The game code runs natively: on Intel CPUs the AMD-only SSE4A instructions are emulated at start.

### How to play

1. Extract the package to any folder (on Windows, out of the .zip).
2. Open **inFAMOUS First Light** (`inFAMOUS First Light.exe` on Windows). If Windows says it protected your PC, click *More info*, then *Run anyway*: the program is not digitally signed.
3. Under **Game folder**, pick the folder that holds `eboot.bin`, then click **Play**. The first start prepares the game (about 30 s) and compiles shaders (some stutter at first).

`Play inFAMOUS First Light.exe` starts the game with the saved settings, without the launcher window (shortcuts, Steam). On Linux, `./install_desktop.sh` adds the game to the applications menu.

### First Light defaults

The launcher starts with settings measured on this game; all of them can be changed in the main window or in **Experimental fixes…**:
- texture cache budget **0 = automatic**: sized from your card's memory (a budget too low makes textures flash black);
- **VSync off** (Mailbox present mode: no tearing, no drop to 30 FPS);
- against flickering buildings: GPU results read without a frame of delay, full-screen passes never skipped while a shader compiles (BP07), occlusion queries answered "visible" (mode 2);
- game language: automatic (your system language).

### In game
- **F10**: FPS counter · **Insert** (or R3 + L2): port menu
- PS4/PS5, Xbox and 8BitDo controllers through SDL3, by USB or Bluetooth.
- **Motion sensor / touchpad** without a DualShock/DualSense: one tap on **L3+R3** toggles sensor mode; **View/Select** is the touchpad click (hold it to absorb), **View/Select + right stick** swipes. Mouse: camera, left = R2, right = L2; **Esc** releases it.

### Problems
- Send `out/last_run.log` in an [issue](https://github.com/GamaxyF/ifl_pc/issues). A crash writes the place and the call stack in it; a frozen screen writes a `FREEZE:` block after 10 s.
- Settings: `%APPDATA%\infamous-firstlight-launcher\settings.json` (Windows), `~/.config/infamous-firstlight-launcher/` (Linux). Saves and shader cache: the `user/` folder of the package.

---

## Français

### Fichiers du jeu

Utilise **inFAMOUS First Light CUSA00575 (US), jeu de base 1.00 avec la mise à jour 1.04**, dumpé (déchiffré) depuis ta PS4 avec GoldHEN + Itemzflow, et réuni dans un seul dossier : copie le jeu de base, puis copie la mise à jour **par-dessus** en remplaçant les fichiers. Aucun fichier du firmware de la console n'est nécessaire.

**PC :** Windows 10 (1903+)/11 64 bits ou Linux x86-64 (glibc 2.39+), carte graphique Vulkan 1.3 (6 Go de VRAM recommandés).

### Comment jouer

1. Extrais le paquet dans un dossier (sous Windows, en dehors du .zip).
2. Ouvre **inFAMOUS First Light** (`inFAMOUS First Light.exe`). Si Windows affiche « Windows a protégé votre ordinateur », clique sur *Informations complémentaires* puis *Exécuter quand même* : le programme n'est pas signé.
3. Dans **Dossier du jeu**, choisis le dossier qui contient `eboot.bin`, puis clique sur **Jouer**. Le premier lancement prépare le jeu (environ 30 s) et compile les shaders (quelques saccades au début).

L'interface du lanceur est en français si ton système l'est (sinon : *Langue de l'interface*).

### En jeu
- **F10** : compteur de FPS · **Insert** (ou R3 + L2) : menu du port
- Manettes PS4/PS5, Xbox et 8BitDo (SDL3), en USB ou Bluetooth.
- **Capteur de mouvement / pavé tactile** sans DualShock/DualSense : **L3+R3** active le mode capteur ; **View/Select** = clic du pavé tactile (maintenir pour absorber), **View/Select + stick droit** = glisser. Souris : caméra, gauche = R2, droit = L2 ; **Échap** la libère.

### Problèmes
Envoie `out/last_run.log` dans une [issue](https://github.com/GamaxyF/ifl_pc/issues) : un plantage y écrit l'endroit et la pile d'appels.
