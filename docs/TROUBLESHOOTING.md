# Troubleshooting

When asking for help, attach the log: in the launcher's **Log** page, **Export log…** saves it to
a file and **Copy** puts it on the clipboard. Never attach game files or saves
([LEGAL.md](../LEGAL.md)).

## The launcher rejects the game

The launcher checks the game folder before starting. gvport runs GUNDAM VERSUS (`CUSA08790`) with
the **1.13 update** merged in ([BUILD.md](../BUILD.md#preparing-the-game)). What it says, and what
to do:

| Message | What to do |
|---|---|
| The 1.13 update is needed | Copy everything from the dumped 1.13 update into the game folder, replacing files (`eboot.bin` and `sce_sys` too). |
| eboot.bin is not from 1.13 | Copy `eboot.bin` from the dumped 1.13 update over the old one. |
| This is not GUNDAM VERSUS | Choose the folder of GUNDAM VERSUS, the one with `eboot.bin`. Other games do not run. |
| eboot.bin cannot be read as a decrypted PS4 executable | Dump the game and the update again. |
| The game folder is missing `archives`, `sce_discmap.plt` or `img` | The extraction is incomplete: extract the game and the update again. |

`python3 scripts/game_check.py <game folder>` runs the same check from a terminal.

## The DLC characters are missing

Choose the folder with the add-ons' `.pkg` files as the launcher's **DLC folder**. GUNDAM VERSUS'
add-ons are unlock keys; their data is already in the 1.13 update. The log says how many add-ons
were found at each start.

## Where are my saves?

Saves live in the data directory, and each way of running the port has its own:

- The AppImage: `~/.local/share/gvport/user/savedata/1/CUSA08790/`.
- From the repository (`run.sh`): `user/savedata/1/CUSA08790/` in the repository.

To move a save, close the game, back up both folders, and copy the `savedata` folder over.

## Battles stutter at 4K

Native 4K is heavy for the GPU work the game's effects wait on. For a steady 60 FPS at 4K, choose
**FSR 3** with the **Quality** preset in the launcher: it renders below 4K and upscales.

## DLSS is "not supported by this GPU"

The log says why, on a line starting with `DLSS:`.

- DLSS needs a GeForce RTX (20 series or newer) and NVIDIA's own driver; it does not work with
  NVK.
- From the repository, DLSS needs a build with `DLSS_SDK_ROOT` ([BUILD.md](../BUILD.md#build-options)).
- If the log says `Device creation with DLSS extensions failed`, NVIDIA's CUDA/UVM
  module is missing: the game then uses FSR 3.1. Load it with `sudo modprobe nvidia_uvm` (the
  `nvidia-modprobe` package loads it when needed); with Secure Boot, a module signing key that
  is not enrolled stops it (`Key was rejected by service`).

## Network play does not find the room

- Every game must use the same matching server: **host** on one PC, **join** with its address
  (`<server>:31323`) on the others ([README](../README.md#over-the-network)).
- A firewall on the server must let TCP 31323 and UDP 31324 in; each game uses UDP 3658.
- Both players pick the same **Room type** (1 on 1 for two players).

## A crash

Turn on the launcher's *Save the log and statistics to a file* and attach the log from `logs/`.
To catch a crash with a debugger, see [DEBUGGING.md](DEBUGGING.md).
