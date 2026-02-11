### Introduction
Aberration is a work-in-progress mod for Portal 2. 
TODO: Expand

### Installation
Aberration asset files are stored in the `aberration` folder of this repository. To install, you have two options:
- Use the copy-util script (Windows 10/11 exclusive).
- Manually copy the contents of the `aberration` folder into your Portal 2 installation

Using the copy-util script is recommended. Read [the script's docs](https://github.com/DIYLabsED/aberration#copy-util) for instructions.

To copy manually, follow the following steps:

- Clone this repo onto your machine.
  - To clone with Git, run `git clone https://github.com/DIYLabsED/aberration.git`.
  - To clone with GitHub's CLI, run `gh repo clone DIYLabsED/aberration`.
  - You can also download the repo as a `.zip` archive by clicking `Code`, then `Download ZIP` on this GitHub page.
- Locate your Portal 2 installation. 
  - Right-click Portal 2 in Steam, click `Manage`, then `Browse Local Files`. This should open a folder called `Portal 2` in your file manager.
  - Inside this folder, open the `portal2` folder. The game loads assets from here.
- Copy assets
  - Copy the contents of the `aberration` folder in this repository into the `portal2` folder. No files should conflict, unless you are reinstalling Aberration.

### copy-util
`copy-util.ps1` is a utility script in the root of this repository. This script automates copying files into and out of this repo.

#### Flags:

| Flag | Description | Default | Notes |
| ---- | --------- | ------- | ---- |
| `modDirPath` | String containing path to mod files which will be copied into game. | `aberration/` | Path can be relative or absolute. |
| `sourceDirPath` | String containing path to directory where `VMF` and `BSP` files which will be copied to. | `src/` | Path can be relative or absolute. |
| `gamePath` | String containing path to directory where Source game is installed. | `src/` | This directory is opened when clicking `Browse Local Files` in Steam |
| `steamPath` | String containing path to Steam executable | `src/` | Path needs to include Steam executable. Not used if `runGame` is not set |
| `copyVMFIntoRepo` | If set, `copy-util` copies the VMF file provided to `mapName` into `sourceDirPath/mapsrc` | Not flagged. | Cannot be used at the same time as `mountMod`. Needs a map to be passed into `mapName` |
| `copyBSPIntoRepo` | If set, `copy-util` copies the BSP file provided to `mapName` into `modDirPath/maps` | Not flagged. | Cannot be used at the same time as `mountMod`. Needs a map to be passed into `mapName` |
| `mapName` | String containing name of map to be copied. Used by `copyVMFIntoRepo` and `copyBSPIntoRepo` | No default. | Do not add extension (`.vmf`, `.bsp`) to map name. This flag does nothing if `copyVMFIntoRepo` or `copyBSPIntoRepo` is not set. |
| `runGame` | If set, `copy-util` attempts to launch the game through Steam | Not flagged. | If no other parameters are passed, `copy-util` attempts to launch the game. |
| `gameArgs` | String containing arguments to be provided to the game. | No defaults. | Use `" "` around arguments. See [this VDC article](https://developer.valvesoftware.com/wiki/Command_line_options) for a list of possible arguments. |
| `gameID` | Game ID passed to Steam executable | `620` | Set to Portal 2's Steam game ID by default. |

### Credits

#### Tools used
- **[Inkscape](https://inkscape.org/)**: Graphics design
- **[Hammer++](https://ficool2.github.io/HammerPlusPlus-Website/)**: Level design

#### External assets
- Circuit breaker with glowing bulb *(instance)*: Made by `@electrodynamite12`
- Refracting glass *(material)*: Made by `@lenship2`
- Improved light strips *(model)*: Made by `@gapeholnicorn`
- BTS-style character decals *(material)*: Made by `@lenship2`
- PMaM lab monitor *(skin)*: Made by `@hazel_rose_webs`
- PMaM posters and stuffie *(material, model)*: Made by `@nuclearshill`, `@therealprogressbar95`, and `@.polydot`

Custom assets sourced from the `#custom-assets` forum in the [Portal Mapping and Modding Discord server](https://discord.com/invite/pmam).