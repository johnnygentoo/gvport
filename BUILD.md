# Building gvport

gvport builds from source on Linux x86-64. A build is two parts:
- `out/bb-probe`, the native runtime that runs the game's own code;
- `out/gpu/libbbgpu.so`, the Vulkan GPU library (shadPS4's video core, extended).

`bash build.sh` builds both.

You also need your own dump of the game: see [Preparing the game](#preparing-the-game) and
[LEGAL.md](LEGAL.md). No game files are in this repository.

## Requirements

- **System:** Linux on x86-64.
- **GPU:** Vulkan 1.3. Use AMD or Intel with Mesa (RADV, ANV), or NVIDIA with NVIDIA's driver.
- **Tested:** AMD Radeon RX 7800 XT and RX 580 with Mesa, and an NVIDIA RTX 3050.
- **Build tools:** GCC (or Clang), CMake, Ninja, pkg-config, Python 3 and git.
- **Libraries:** Vulkan headers and loader, SDL3, FreeType, FFmpeg, Boost, fmt, magic_enum,
  robin-map, xxHash, Vulkan Memory Allocator, glslang, SPIRV-Headers, xbyak, Zydis, miniz.
- **Online play** (`gpu/bbnet`): protobuf, nlohmann-json, OpenSSL, zlib, miniupnpc.
- **Launcher:** PyGObject, GTK 4, libadwaita, Pillow and the DejaVu fonts.
- **Optional:**
  - `cargo` builds the launcher's *Install from PKG* tool.
  - libcurl builds the Bloodborne-only co-op bridge.
  - `spirv-cross` on your `PATH` is used for the FSR 4 shaders.

### Arch Linux (and CachyOS, Manjaro, EndeavourOS)

```bash
sudo pacman -S --needed base-devel git cmake ninja python python-gobject gtk4 libadwaita sdl3 \
    vulkan-headers vulkan-icd-loader glslang spirv-headers spirv-cross ffmpeg boost fmt \
    robin-map xxhash zydis miniz protobuf nlohmann-json openssl miniupnpc python-pillow \
    ttf-dejavu freetype2 noto-fonts noto-fonts-cjk
paru -S magic_enum vulkan-memory-allocator xbyak    # from the AUR (or yay)
```

### Gentoo

```bash
emerge --ask --noreplace dev-build/cmake app-alternatives/ninja dev-util/pkgconf dev-vcs/git \
    dev-util/vulkan-headers media-libs/vulkan-loader media-libs/libsdl3 media-libs/freetype \
    media-video/ffmpeg dev-libs/boost dev-libs/libfmt dev-cpp/magic_enum dev-cpp/robin-map \
    dev-libs/xxhash dev-util/glslang dev-util/spirv-headers dev-libs/xbyak dev-libs/zydis \
    dev-libs/miniz dev-libs/protobuf dev-cpp/nlohmann_json dev-libs/openssl net-libs/miniupnpc \
    dev-python/pygobject gui-libs/gtk gui-libs/libadwaita dev-python/pillow media-fonts/dejavu
# Vulkan Memory Allocator is in the GURU overlay:
eselect repository enable guru && emaint sync -r guru
emerge --ask media-libs/VulkanMemoryAllocator
```

`spirv-cross` is not in Gentoo's main tree. Without it, FSR 4 still works; only an optional
shader step is skipped.

### Nix / NixOS

Nothing to install: `bash build.sh` and `bash run.sh` enter `shell.nix` by themselves when
dependencies are missing.

### Other distributions

Install the packages above under your distribution's names. `build.sh` checks for pkg-config with
`vulkan`, `sdl3` and `freetype2`, plus `cmake` and `ninja`, and says what is missing.

## Build

```bash
git clone --recursive https://github.com/johnnygentoo/gvport.git
cd gvport
bash build.sh
```

`--recursive` fetches the three submodules: FSR-Vulkan, Dear ImGui and LibAtrac9. If you cloned
without it, `build.sh` fetches them itself. It also applies gvport's patches to FSR-Vulkan
(`gpu/patches/fsr-vulkan`).

What it builds, all under `out/`:

| File | What |
|---|---|
| `out/bb-probe` | The runtime; the launcher and `run.sh` start it |
| `out/gpu/libbbgpu.so` | The GPU library |
| `out/gpu/gvnet-server` | The LAN matching server, when protobuf was found |
| `out/bb-gpu-capabilities` | GPU and gamepad check used by the launcher |
| `out/pkgextract/` | *Install from PKG*, when `cargo` is installed |

A full build takes a few minutes. If the GPU library fails to build, the build stops and shows the
end of `out/gpu-build.log`.

### Build options

Environment variables for `build.sh`:

| Variable | Default | Effect |
|---|---|---|
| `BB_LTO` | `ON` | Link-time optimization. `BB_LTO=OFF` builds faster, for development |
| `BB_PGO` | `use` if `pgo/` has a profile, else `off` | Profile-guided optimization: `generate` builds an instrumented library that records a profile into `pgo/` while you play; `use` builds with it |
| `DLSS_SDK_ROOT` | unset | Path to a checkout of [NVIDIA's DLSS SDK](https://github.com/NVIDIA/DLSS): builds the DLSS bridge. Without it, DLSS is listed as unavailable |
| `CC` | `cc` | The C compiler |

Release builds use the defaults (LTO on).

### FSR 4 (optional)

FSR 3.1 and TAA need nothing more. FSR 4 (INT8 model v07, MIT-licensed, built from AMD's source)
is downloaded separately:

```bash
bash tools/fetch_fsr4_assets.sh      # into fsr4_shaders/, about 30 MB
```

FSR 4.1.1 is built from your own copy of AMD's DLL: use the launcher's *FSR 4.1.1 from your own
AMD DLL* button. Neither is ever committed.

## Preparing the game

1. Dump GUNDAM VERSUS (`CUSA08790`, version 1.00) and its **1.13 update** from your own PS4.
   The game folder holds `eboot.bin`, `sce_sys/`, `sce_module/` and the game's data.
2. Merge the update into a third folder. On one filesystem, hardlinks avoid copying about 45 GB:

   ```bash
   cp -al CUSA08790 CUSA08790-full
   cp -al --remove-destination CUSA08790-patch/. CUSA08790-full/
   python3 scripts/game_check.py CUSA08790-full     # checks the executable and the version
   ```

3. **DLC** (optional): put the `.pkg` files of the add-ons you own in one folder and choose it
   as the launcher's *DLC folder*. GUNDAM VERSUS' add-ons are small unlock keys whose data is
   already in the update. `scripts/dlc.py` turns them into entitlements in `user/addcont/` at
   each launch.

Folders named `CUSA*` and `*-DLCs-*` are ignored by git, so a dump inside the checkout is never
committed. Keeping dumps outside the checkout is still safer.

## Run

```bash
bash launcher/bb-launcher.sh           # the launcher
bash launcher/install-desktop.sh       # adds "GUNDAM VERSUS" to your application menu
```

In the launcher, choose the game folder (the one with `eboot.bin`) and press **Play**.

Without the launcher:

```bash
BB_GAME_DIR=/path/to/CUSA08790-full bash run.sh
```

Where things are kept:
- **Launcher settings:** `~/.config/gvport-launcher`.
- **From a checkout:** saves, trophies and the shader cache go to `user/`; the in-game menu's
  settings go to `bbport.ini`.
- **From the AppImage:** both go to `~/.local/share/gvport`.

`user/` and `bbport.ini` are ignored by git.

## AppImage

```bash
bash build.sh && bash packaging/appimage-sharun.sh
# -> dist/GUNDAM-VERSUS-gvport-x86_64.AppImage
```

The AppImage carries gvport, its libraries, the launcher and, if fetched, the FSR 4 v07 assets. It
never contains game files, saves or anything made from a dump. Before publishing one, run
`tools/check-release.sh dist/*.AppImage`.

## LAN server only

A PC that only hosts online matches (a home server, no GPU or game) can build the matching server
alone. It needs g++ and protobuf:

```bash
bash tools/gvnet-server/build.sh       # -> tools/gvnet-server/out/gvnet-server
```

`tools/gvnet-server/gvserver` starts and stops it (`toggle`, `start`, `stop`, `status`, `log`). It
listens on TCP 31323 and UDP 31324. The players' launchers then use *Over the network: join* with
`<server>:31323`. See the README's *Over the network* section.

## Tests

```bash
bash build.sh --test                         # runtime, pad, content and online tests (C)
python3 -m unittest discover -s tests        # launcher, scripts and packaging tests
ninja -C out/gpu game-camera-test scene-resolution-test settings-test motion-history-test \
    && out/gpu/game-camera-test              # GPU library tests (several targets)
```

The tests need no game files.

## Troubleshooting

- [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md): problems at start and while playing.
- [docs/DEBUGGING.md](docs/DEBUGGING.md): debugging switches and logs.
- To report a problem: turn on the launcher's *Save the log and statistics to a file* and attach
  the log from `logs/`. Never attach game files or saves ([LEGAL.md](LEGAL.md)).
