<div align="center">
  <img width="300" alt="colormkdir logo" src="https://user-images.githubusercontent.com/99246880/224245097-6d4617a3-6987-43ad-81af-6b4696e7c9fc.png" />
</div>

**Table of Contents**
- [colormkdir](#colormkdir)
- [Demo](#demo)
- [Installation](#Installation)
    - [Use Homebrew](#use_homebrew)
    - [Manual Installation](#manual_installation)
- [Usage](#usage)
    - [Create color list](#create_color_list)
    - [Update color list](#update_color_list)
    - [Make directory in specified color](#make_directory_in_specified_color)
    - [Change directory color as specified color](#change_directory_color_as_specified_color)
    - [Reset directory to default icon](#reset_directory_to_default_icon)
    - [Raycast Integration](#raycast_integration)
    - [Help command](#help_command)

# colormkdir
`colormkdir` is a CLI for macOS to customize folder color. 
It can make directory in specified color. Also, it can manage color list by editing json file.

# Demo
![demo.gif](https://user-images.githubusercontent.com/99246880/224244901-8ff520df-f383-4c35-a185-dba17773eabd.gif)

# Installation
**Supported platforms**

* **macOS**

## Use Homebrew

```
brew install mimomimoto/tap/colormkdir
```
`colormkdir` use python3 and you need to install some libraries.

```
pip install pyobjc pillow glob2
```
## Manual Installation
1. git clone this repository.
2. Write PATH to `~/.zshrc`.
3. Change `colormkdir` permission by using chmod.
4. run `source ~/.zshrc`.
5. `pip install pyobjc pillow glob2 `

> `colormkdir` use your global python environment. If you don't want to install these libraries in your global environment, you should edit colormkdir.sh (line 64).

# Usage
## Create color list
Color list is managed by JSON file. (If you use Homebrew, the file path is '/opt/homebrew/Cellar/colormkdir/0.0.1/libexec/color_list.json' in my case) You need to decide `color name` and `color code` as shown below. (It is a default definition)
```
{
    "r":"#ff0000",
    "b":"#1e90ff",
    "g":"#3cb371",
    "y":"#ffff00",
    "p":"#9400d3",
    "o":"#ff7f50"
}
```

## Update color list
After change color list, you need to run command for updating color list. 
```
colormkdir -u
```

## Make directory in specified color
```
colormkdir -m [value] <directory name>
```
[value] is `color name` defined in color list. If directory name is already exsisted, it will be error.

## Change directory color as specified color
```
colormkdir -c [value] <directory name>
```
[value] is `color name` defined in color list. If directory name is not exsisted, it will be error.

## Reset directory to default icon
```
colormkdir -r <directory name>
```
Resets a previously colored directory back to its default macOS icon.

## Help command
```
colormkdir -h
```

## Raycast Integration

You can use `colormkdir` with Raycast for a faster workflow. The included AppleScript (`cdirsX批量改变文件夹颜色V2.applescript`) allows you to batch change folder colors directly from Finder selection.

### Installation for Raycast

1. Copy the AppleScript file to your Raycast Scripts directory:
   ```
   ~/Library/Application Support/com.raycast.macos/scripts/
   ```

2. Open Raycast and search for the script by name: `cdirsX批量改变文件夹颜色V2`

3. The script will appear in Raycast and is ready to use.

### How It Works

The Raycast script uses `colormkdir` with the following color codes:

| Code | Color |
|------|-------|
| `r` | Red |
| `b` | Blue |
| `g` | Green |
| `y` | Yellow |
| `p` | Purple |
| `o` | Orange |
| `oo` | Reset to default |

### Usage

1. Select one or more folders in Finder
2. Open Raycast and type the script name
3. Enter a color code when prompted
4. The script will batch update all selected folders using `colormkdir -c <color> <folder>` or `colormkdir -r <folder>` for reset

### Configuration

If your `colormkdir` is installed in a different location, edit line 56 of the AppleScript to update the path:

```applescript
set colormkdirxPath to "《你的本地安装位置》"
```

Also update line 68 if your Python path differs:

```applescript
do shell script "export PATH=《你的Python环境路径》:$PATH; " & shellCmd
```

