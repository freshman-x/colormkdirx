<div align="center">
  <img width="300" alt="colormkdir logo" src="https://user-images.githubusercontent.com/99246880/224245097-6d4617a3-6987-43ad-81af-6b4696e7c9fc.png" />
</div>

[English](./README_en.md) | **中文**

**目录**
- [colormkdir](#colormkdir)
- [演示](#演示)
- [安装](#安装)
- [使用](#使用)
    - [创建颜色列表](#创建颜色列表)
    - [更新颜色列表](#更新颜色列表)
    - [创建带颜色的目录](#创建带颜色的目录)
    - [修改目录颜色](#修改目录颜色)
    - [恢复目录默认图标](#恢复目录默认图标)
    - [Raycast 集成](#raycast-集成)
    - [帮助命令](#帮助命令)

# colormkdir
`colormkdir` 是一个用于 macOS 自定义文件夹颜色的命令行工具。
它可以创建带指定颜色的目录，也可以通过编辑 JSON 文件管理颜色列表。

# 演示
![demo.gif](https://user-images.githubusercontent.com/99246880/224244901-8ff520df-f383-4c35-a185-dba17773eabd.gif)

# 安装
**支持的平台**

* **macOS**

> **注意：** 此 Fork 版本不支持 Homebrew 安装，请使用下面的手动安装方式。

## 手动安装
1. git clone 本仓库。
2. 将 PATH 写入 `~/.zshrc`。
3. 使用 chmod 修改 `colormkdir` 权限。
4. 运行 `source ~/.zshrc`。
5. `pip install pyobjc pillow glob2`

> `colormkdir` 使用你的全局 Python 环境。如果不想在这些库安装到全局环境，请编辑 colormkdir.sh（第 64 行）。

# 使用
## 创建颜色列表
颜色列表由 JSON 文件管理。（如果你使用 Homebrew，文件路径是 `/opt/homebrew/Cellar/colormkdir/0.0.1/libexec/color_list.json`）你需要定义 `颜色名称` 和 `颜色代码`，如下所示。（这是默认定义）
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

## 更新颜色列表
修改颜色列表后，需要运行命令更新颜色列表。
```
colormkdir -u
```

## 创建带颜色的目录
```
colormkdir -m [颜色代码] <目录名称>
```
[颜色代码] 是在颜色列表中定义的 `颜色名称`。如果目录已存在则会报错。

## 修改目录颜色
```
colormkdir -c [颜色代码] <目录名称>
```
[颜色代码] 是在颜色列表中定义的 `颜色名称`。如果目录不存在则会报错。

## 恢复目录默认图标
```
colormkdir -r <目录名称>
```
将已着色的目录恢复为 macOS 默认图标。

## 帮助命令
```
colormkdir -h
```

## Raycast 集成

你可以将 `colormkdir` 与 Raycast 结合使用，获得更高效的工作流程。附带的 AppleScript 脚本（`cdirsX批量改变文件夹颜色V2.applescript`）允许你直接从 Finder 选中的文件夹批量更改颜色。

### Raycast 安装步骤

1. 将 AppleScript 文件拷贝到 Raycast Scripts 目录：
   ```
   ~/Library/Application Support/com.raycast.macos/scripts/
   ```

2. 打开 Raycast 并搜索脚本名称：`cdirsX批量改变文件夹颜色V2`

3. 脚本会出现在 Raycast 中，可以直接使用。

### 工作原理

Raycast 脚本使用 `colormkdir`，支持以下颜色代码：

| 代码 | 颜色 |
|------|------|
| `r` | 红色 |
| `b` | 蓝色 |
| `g` | 绿色 |
| `y` | 黄色 |
| `p` | 紫色 |
| `o` | 橙色 |
| `oo` | 恢复默认 |

### 使用方法

1. 在 Finder 中选中一个或多个文件夹
2. 打开 Raycast 并输入脚本名称
3. 输入颜色代码
4. 脚本将批量更新所有选中的文件夹，使用 `colormkdir -c <颜色> <文件夹>` 或 `colormkdir -r <文件夹>`（恢复默认）

### 配置

如果你的 `colormkdir` 安装在不同位置，请修改 AppleScript 第 56 行的路径：

```applescript
set colormkdirxPath to "《你的本地安装位置》"
```

如果你的 Python 路径不同，请修改第 68 行：

```applescript
do shell script "export PATH=《你的Python环境路径》:$PATH; " & shellCmd
```
