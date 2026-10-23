# Credits

gvport exists because of the Bloodborne port and the people who built it. Almost everything in
this repository started there: the native runtime, the GPU translation, the upscalers and the
launcher. gvport points that work at GUNDAM VERSUS.

**Lineage:** [bloodborne_pc](https://github.com/deadinside28/bloodborne_pc) (bbport, by
deadinside28) → [bloodborne_linux](https://github.com/ayozetr/bloodborne_linux) (ayozetr's Linux
fork) → gzport (the GODZILLA port) → **gvport**.

The git history is kept, so every commit keeps its author.

## The Bloodborne port (bbport)

- **[deadinside28](https://github.com/deadinside28)**, author of
  [bloodborne_pc](https://github.com/deadinside28/bloodborne_pc), the port everything here is
  built on:
  - the loader that runs the game's own x86-64 code natively;
  - the HLE runtime that replaces the PS4 system libraries;
  - the shadPS4-derived Vulkan renderer and its performance work.

  Its original README, with the technical details, is kept as [BBPORT.md](BBPORT.md).
- **[ayozetr](https://github.com/ayozetr)**, author of
  [bloodborne_linux](https://github.com/ayozetr/bloodborne_linux), the Linux fork gvport comes
  from:
  - the GTK launcher and its translations;
  - the FSR 3.1, FSR 4 and FSR 4.1.1 upscalers, and the memory models;
  - trophies, Install from PKG, save import, Add to Steam and the AppImage;
  - bringing in and maintaining everyone's fixes.

## Code in this repository's history

People whose own commits are in this repository:

| Contributor | Contribution |
|---|---|
| [0xCydral](https://github.com/0xCydral) | Gathered and adapted dozens of fixes: crashes in speculative draw preparation, invalid PM4 headers, unreadable shader addresses, FSR 4 depth barriers |
| [Supermedo](https://github.com/Supermedo) | Keeps the game running when video memory is full; SRT walker recovery. Also the Windows port ([Supermedo/bloodborne_pc](https://github.com/Supermedo/bloodborne_pc)), whose online play, DLSS, Add to Steam and icon came to Linux |
| [obrikash](https://github.com/obrikash) | Vulkan starts when optional DLSS extensions fail |
| [devilismyfriend](https://github.com/devilismyfriend) | Texture cache frees video memory in time (LRU cache fix) |
| [artemkaVG](https://github.com/artemkaVG) | Texture cache: color images no longer taken for the stencil buffer |
| [andrecabralgit](https://github.com/andrecabralgit) | Game audio at full level on stereo devices |
| [Mrsuss60](https://github.com/Mrsuss60) | Touchpad from the keyboard; crashes when loading some maps |
| [Jgamrot](https://github.com/Jgamrot) | In-game menu checkboxes and sliders keep their changes |

## Thanked by bloodborne_linux

From the Bloodborne launcher's About → Thanks page, for work brought into the port:

| Contributor | Contribution |
|---|---|
| [yumlevi](https://github.com/yumlevi) | Black character preview, loading-screen image, texture cache memory |
| [GoncaloLobo0](https://github.com/GoncaloLobo0) | Crashes when loading areas |
| [bmy](https://github.com/bmy) | UI missing outside 1080p, motion vectors of large monsters, a memory bug |
| [SrShadowy](https://github.com/SrShadowy) | On-screen keyboard for the character name, shader compilation notice |
| [Wozzardman](https://github.com/Wozzardman) | The game's network libraries for online play, and a server for your own co-op |
| [IFreemz](https://github.com/IFreemz) | The base of DLSS support ([shadPS4-Bloodborne-DLSS-FSR](https://github.com/IFreemz/shadPS4-Bloodborne-DLSS-FSR)) and the FSR 4 model without ghosting trails |
| [FireBurn](https://github.com/FireBurn) | The FSR 3.1 upscaler ([FSR-Vulkan](https://github.com/FireBurn/FSR-Vulkan)) and the FSR 4 v07 assets in Q2RTX |
| [Qiming-Liu](https://github.com/Qiming-Liu) | Simplified Chinese translation |
| [GerasimosKan](https://github.com/GerasimosKan) | English trophy names without a key, trophy unlock sound |
| [Vorshim92](https://github.com/Vorshim92) | Staying signed in to a public shadNet server |
| [parsifal295](https://github.com/parsifal295) | Quitting from the menu with a controller, menus within the screen, touchpad halves on Xbox pads |
| [emurphy04](https://github.com/emurphy04) | Video player crash when it stops |
| [AyrtonSanabio](https://github.com/AyrtonSanabio) | In-game menu language when started without the launcher |
| [Aryxa](https://github.com/Aryxa) | DLSS in the AppImage on NVIDIA |
| [pmwork-personal](https://github.com/pmwork-personal) | Ultrawide monitors without a stretched picture |
| [Jhony-Jhansen](https://github.com/Jhony-Jhansen) | Keyboard movement: round diagonals, last key pressed wins |
| [AndiMajore](https://github.com/AndiMajore) | Crash debugging: the process waits for a debugger (`BB_FAULT_WAIT`) |
| [Awakenchan](https://github.com/Awakenchan) | Video memory on 4 GB cards and crash fixes (flips, swapchain, descriptors, page faults); stick swap and camera inversion; save import and the version picker, from Awaken's BloodBorneButPc |
| [AwesomeObserver](https://github.com/AwesomeObserver) | Large recording command groups; the swapchain after display changes |

**Reports and testing:**
- [willthehuman](https://github.com/willthehuman): detailed reports with logs, and checking fixes.
- [Joomzie](https://github.com/Joomzie): the idea of swapping A and B on Nintendo-style
  controllers.
- [Kaka556Kevin](https://github.com/Kaka556Kevin): tested the video memory fix.
- [nr1971](https://github.com/nr1971): found why the game didn't start on some GPUs, and the
  DualShock 4 camera acceleration.
- [segasonicye](https://github.com/segasonicye): found why it didn't start in the Steam Deck's
  Game Mode.
- [Monochrome0907](https://github.com/Monochrome0907): found which effects hung loading screens
  on NVIDIA.

## Mods and patches (used by the Bloodborne profile)

- **Dommo**: the Xbox and Switch button prompts and the gestures menu in `assets/menu_prompts`,
  from [Bloodborne mod 30 on Nexus Mods](https://www.nexusmods.com/bloodborne/mods/30), reused
  with credit as its permissions allow.
- **Kyo, Lance McDonald, auser1337, illusion, emoose** and other community members: the
  Bloodborne game patches (`patches/Bloodborne.xml` in bbport).
- **MaskZeus**: bbbridge (`bbbridge/`, GPL-3.0-or-later), on the protocol of droogie's bbhost and
  The Hunter's Dream.

## GODZILLA and GUNDAM VERSUS (gzport, gvport)

**Johnnygentoo Studios.** The team:
- **[Johnnygentoo](https://github.com/johnnygentoo)**
- **Claude** (Anthropic), who co-authored the commits

Their work:
- gzport, which added imports by NID, game profiles, the Ngs2 audio renderer, libSceFont and the
  dialogs of an offline console;
- gvport: the GUNDAM VERSUS profile, its effects and beams, native resolutions and upscalers, DLC,
  and LAN play through `gvnet-server`.

## Third-party software

| Component | License | Use |
|---|---|---|
| [shadPS4](https://github.com/shadps4-emu/shadPS4) | GPL-2.0-or-later | Video core and shader recompiler (`gpu/shadps4`, see `gpu/VENDOR.txt`) |
| [sirit](https://github.com/shadps4-emu/sirit), [half](https://half.sourceforge.net/) | BSD-3-Clause, MIT | SPIR-V emitter, half-precision floats |
| [FSR-Vulkan](https://github.com/FireBurn/FSR-Vulkan) by FireBurn, AMD FidelityFX SDK | MIT | FSR 3.1 and the FSR 4 provider |
| FSR 4 v07 assets, built from AMD's source by [Q2RTX](https://github.com/FireBurn/Q2RTX) | MIT | Downloaded by `tools/fetch_fsr4_assets.sh`, not in the repository |
| [dxil-spirv](https://github.com/HansKristian-Work/dxil-spirv) | MIT | Builds FSR 4.1.1 from the player's own AMD DLL |
| [Dear ImGui](https://github.com/ocornut/imgui) | MIT | In-game menu |
| [cpp-httplib](https://github.com/yhirose/cpp-httplib) | MIT | HTTP for online play |
| [LibAtrac9](https://github.com/Thealexbarney/LibAtrac9) by Alex Barney | MIT | ATRAC9 audio |
| [FreeType](https://freetype.org) | FreeType License | libSceFont |
| DejaVu fonts | DejaVu Fonts License | Menu text (`gpu/third_party/fonts`) |
| [KytyPS5](https://github.com/KytyPS5/KytyPS5), [AnyPS5](https://github.com/boykopovar/AnyPS5) | GPL-2.0 | NGS2 parameter IDs and rendering semantics |
| DLSS bridge (`gpu/dlss_bridge`), [NVIDIA DLSS SDK](https://github.com/NVIDIA/DLSS) | MIT; NVIDIA's license | Optional DLSS; NVIDIA's SDK and libraries are not distributed here |
| [ps4-pkg-extractor](https://github.com/paulomanrique/ps4-pkg-extractor) by paulomanrique | Unlicense | Install from PKG (built by `build.sh`) |
| [quick-sharun](https://github.com/pkgforge-dev/Anylinux-AppImages) (pkgforge-dev) | Its own (downloaded when packaging, not in the repository) | AppImage packaging |

gvport as a whole is licensed under the GNU GPL v2 or later ([LICENSE](LICENSE)). See also
[LEGAL.md](LEGAL.md).

If you contributed and are missing here, or something is credited wrongly, please open an issue.
