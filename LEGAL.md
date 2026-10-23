# Legal notice and disclaimer

**gvport contains no part of GUNDAM VERSUS.** It is source code and documentation only. To play
you need your own copy of the game, dumped by you from your own PlayStation 4.

This notice is not legal advice. The laws on making and using a backup of a game you own differ
from country to country. Check what applies where you live.

## What you must provide yourself

- **The game:** a dump of your own GUNDAM VERSUS disc or digital purchase (`CUSA08790`), made
  on your own PS4 with a dumping tool of your choice.
- **Its update** (1.13) and **any DLC you bought**, dumped the same way.
- **The PS4 trophy key**, only if you want trophy names. It is typed into the launcher and stored
  in your own settings (`~/.config/gvport-launcher`), never in this repository.

## What this project never distributes

None of the following is in this repository, its history or its releases, and none will be
accepted in issues or pull requests:

- the game's executable (`eboot.bin`), system modules (`sce_module/*.prx`), data archives,
  sound banks, movies or any other file from the game, its update or its DLC;
- `.pkg` packages, unlock keys or DLC entitlements;
- save data, trophy data or system files from a console;
- console keys, firmware or anything from Sony's system software;
- links to any of the above, or instructions for getting them from anyone other than yourself.

Issues or pull requests that contain, request or link to such material will be closed.

## Files made from your dump stay on your machine

When it runs, gvport makes files from your dump, for example:
- the converted executable and shader caches in `out/`;
- saves, trophies and DLC entitlements in `user/`.

These come from your copy of the game, so **do not share them**. The `.gitignore` keeps them out
of git. A gvport AppImage contains only gvport and its libraries, never game files.

When you report a problem, attach the launcher's log, not game files or saves. Check the log
first: it contains your folder paths, and your user name may be in them.

## Online play

gvport does not connect to PlayStation Network or any Sony service. Its versus modes run through
`gvnet-server`, a small matching server that you run yourself, on one of your PCs or on your LAN.
Don't use gvport to get into official servers.

## Not affiliated

- gvport is an unofficial fan project. It is not made, endorsed or supported by Bandai Namco
  Entertainment, SOTSU, SUNRISE, Sony Interactive Entertainment, AMD or NVIDIA.
- GUNDAM VERSUS © SOTSU · SUNRISE, published by Bandai Namco Entertainment.
- "PlayStation" and "PS4" are trademarks of Sony Interactive Entertainment.
- AMD FidelityFX and FSR are trademarks of Advanced Micro Devices, Inc.
- NVIDIA and DLSS are trademarks of NVIDIA Corporation.
- Every other trademark belongs to its owner.

## No warranty

gvport is free software under the GNU General Public License, version 2 or later
([LICENSE](LICENSE)). It comes **without any warranty**, as the license states. It is
experimental: back up your saves.

Third-party code in this repository keeps its own license (see [CREDITS.md](CREDITS.md)).

## Rights holders

If you hold rights in something you believe is in this repository by mistake, open an issue on
the project's GitHub page and it will be dealt with promptly.
