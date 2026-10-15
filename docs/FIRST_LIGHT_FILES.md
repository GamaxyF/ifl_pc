## Required game files

Everything comes from **your own** PS4 (GoldHEN + Itemzflow). None of it is in the download. Use **inFAMOUS First Light CUSA00575 (US), base game 1.00 with update 1.04**, merged into one folder: the base game, then the update copied on top of it.

| File | From | Purpose |
|---|---|---|
| `eboot.bin` | update 1.04 | the game code (must be the 1.04 one) |
| `sce_module/libc.prx`, `sce_module/libSceFios2.prx` | update 1.04 | the game's own libraries |
| `sce_sys/` (`param.sfo`, `icon0.png`, `pic1.png`...) | base game + update | metadata and the launcher art (the update's `param.sfo` says 01.04) |
| `art/`, `playgo.pgm`, `sce_discmap.plt`, `sce_discmap_patch.plt` | base + update | game content, file map and install info |

**From the console firmware:** nothing.

**How to build the folder:**
1. In Itemzflow, dump the game (`CUSA00575`) and its update (`CUSA00575-patch`) to an exFAT USB drive. The dump must be decrypted (Itemzflow / GoldHEN do it).
2. On the PC, copy the base game folder, then copy the update's contents **over it**, replacing the files. (Or `scripts/make_game_view.py <base> <update> <out>`, which uses links and no extra space; on Windows symbolic links need Developer Mode or an administrator prompt.)
3. In the launcher, pick that folder (the one with `eboot.bin`).

Other regions or versions of First Light are untested; the launcher warns when the `eboot.bin` is not the US 1.04 one.

## Fichiers du jeu nécessaires

Tout vient de **ta propre** PS4 (GoldHEN + Itemzflow). Rien de cela n'est dans le téléchargement. Utilise **inFAMOUS First Light CUSA00575 (US), jeu de base 1.00 avec la mise à jour 1.04**, réunis dans un seul dossier : le jeu de base, puis la mise à jour copiée par-dessus.

1. Dans Itemzflow, fais le dump du jeu (`CUSA00575`) et de sa mise à jour (`CUSA00575-patch`) sur une clé USB exFAT (dump déchiffré).
2. Sur le PC, copie le dossier du jeu de base, puis copie le contenu de la mise à jour **par-dessus** en remplaçant les fichiers.
3. Dans le lanceur, choisis ce dossier (celui qui contient `eboot.bin`).
