# My Dotfiles

A clean, dark-themed, and keyboard-centric Linux desktop environment. This repository contains the personal configuration files for my setup, focusing on efficiency, minimalism, and developer productivity.

The core components are **i3-gaps** for window management, **Kitty** as the terminal, and a highly-customized **Neovim** setup for development, all tied together with a consistent and pleasant aesthetic.

![image](https://github.com/user-attachments/assets/f00c965a-7ed6-49c8-982b-18640e94a128)
_(This is a representative image of the desktop environment)_

## Table of Contents

- [Key Features](#key-features)
- [Software & Components](#software--components)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration Structure](#configuration-structure)
- [Keybindings Quick Reference](#keybindings-quick-reference)
- [License](#license)

## Key Features

- **Keyboard First**: The entire workflow is optimized for the keyboard to minimize reliance on the mouse. From window management to application launching, everything has a binding.
- **Minimalist Aesthetics**: A consistent dark theme (`#2a2a2e`) is used across Neovim, Kitty, and the i3bar. Rounded corners (`15px`), subtle transparency, and gaps provide a modern, distraction-free workspace.
- **Fast & Lightweight**: Components are chosen for their performance and low resource usage on a Linux system.
- **Modular & Organized**: Configurations are split into logical files (e.g., i3 keybindings, appearance, apps) for easier management and tweaking.
- **Developer-Focused Neovim**: A powerful Neovim setup managed by `lazy.nvim` with out-of-the-box support for LSP, autocompletion, fuzzy finding, and more.

## Software & Components

| Component           | Application         | Purpose                                                  |
| :------------------ | :------------------ | :------------------------------------------------------- |
| **Window Manager**  | i3-gaps             | Tiling window manager with configurable gaps.            |
| **Terminal**        | Kitty               | Fast, feature-rich, GPU-accelerated terminal.            |
| **Editor**          | Neovim (v0.9+)      | The one true editor, configured in Lua with `lazy.nvim`. |
| **Compositor**      | Picom               | For transparency, shadows, and rounded corners.          |
| **App Launcher**    | dmenu               | Fast and minimal application launcher.                   |
| **Status Bar**      | i3bar with i3status | System information at a glance.                          |
| **Night Light**     | Redshift            | Adjusts screen color temperature.                        |
| **Screenshot Tool** | Flameshot           | Powerful and intuitive screenshot utility.               |
| **Wallpaper**       | Feh                 | Sets the desktop background.                             |
| **Font**            | FiraCode Nerd Font  | Provides essential icons and programming ligatures.      |

## Prerequisites

Before installing, ensure you have the following software installed on your system:

- `git`
- `i3-gaps`
- `kitty`
- `neovim` (v0.9 or newer)
- `picom`
- `dmenu`
- `i3status`
- `feh`
- `flameshot`
- `redshift`
- `FiraCode Nerd Font` (or any other Nerd Font, but you'll need to update the configs)
- (Optional but Recommended) `stow` for easy symlinking.

## Installation

1.  **Install Prerequisites**:
    Install all the software listed above using your distribution's package manager.

2.  **Clone the Repository**:

    ```sh
    git clone https://github.com/rohitsx/dotFiles.git ~/.dotFiles
    ```

3.  **Symlink Configuration Files**:
    It is highly recommended to use `stow` to manage symlinks. Navigate into the cloned directory and run `stow` for each application.

    ```sh
    cd ~/.dotFiles
    stow i3
    stow kitty
    stow nvim
    stow picom
    stow redshift
    ```

    This will create the necessary symlinks in your `~/.config` directory.

4.  **Set up Wallpaper**:
    The i3 config expects the wallpaper at `~/.dotFiles/.wallpaper/wallpaper.jpg`. Make sure you have an image at that location or update the path in `~/.config/i3/config`.

5.  **Launch Neovim**:
    The first time you run `nvim`, `lazy.nvim` will automatically bootstrap itself and install all the configured plugins.

6.  **Reload i3**:
    Log out and log back into your i3 session, or reload it in place with `Control+Shift+r`.

## Configuration Structure

The repository is organized by application for easy navigation.
Use code with caution.
Markdown
.
├── i3/ # i3-gaps window manager config
├── kitty/ # Kitty terminal emulator config
├── nvim/ # Neovim configuration (LSP, plugins, etc.)
├── picom/ # Picom compositor settings (transparency, corners)
├── redshift/ # Redshift night light settings
└── .wallpaper/ # Contains the desktop wallpaper

### Neovim

The Neovim setup is fully configured in Lua and managed by `lazy.nvim`.

- **Plugin Manager**: `lazy.nvim` for declarative, on-demand plugin loading.
- **LSP & Completion**: `nvim-lspconfig` with `mason.nvim` to automatically manage Language Servers. Completion is handled by `nvim-cmp`.
- **Language Servers**: Pre-configured for Python, TypeScript/JS, Lua, HTML, CSS, JSON, Docker, YAML, Svelte, and PHP.
- **Fuzzy Finder**: `telescope.nvim` is heavily used for finding files, grepping, and more.
- **File Explorer**: `oil.nvim` provides a lightweight and fast file browser.
- **UI Enhancements**: `lualine.nvim` for the status bar, `noice.nvim` for a cleaner command/message UI, and `nvim-notify` for notifications.

All Neovim settings are located in `nvim/lua/`.

- `nvim/init.lua`: The main entry point.
- `nvim/lua/config/`: General options, keymaps, and the `lazy.nvim` setup.
- `nvim/lua/plugins/`: Individual plugin specifications.
- `nvim/lua/lsp/`: Configuration for LSP, Treesitter, and Mason.

## Keybindings Quick Reference

### i3 Window Manager

| Keybinding          | Action                               |
| :------------------ | :----------------------------------- |
| `Mod+q`             | Open Terminal (Kitty)                |
| `Mod+c`             | Kill focused window                  |
| `Mod+d`             | Launch `dmenu`                       |
| `Mod+z`             | Launch Google Chrome                 |
| `Print`             | Open `flameshot` GUI for screenshots |
| `Mod+j/k/l/;`       | Focus window (left/down/up/right)    |
| `Mod+Shift+j/k/l/;` | Move focused window                  |
| `Mod+h` / `Mod+v`   | Split horizontally / vertically      |
| `Mod+f`             | Toggle fullscreen                    |
| `Mod+Shift+space`   | Toggle floating window               |
| `Mod+[1-9]`         | Switch to workspace                  |
| `Mod+Shift+[1-9]`   | Move window to workspace             |
| `Control+Shift+r`   | Restart i3 in-place                  |

### Neovim

| Keybinding       | Action                               |
| :--------------- | :----------------------------------- |
| `<leader>w`      | Save file                            |
| `<leader>q`      | Quit Neovim                          |
| `<leader>e`      | Open parent directory (`oil.nvim`)   |
| `<Alt>+p`        | Find files (`telescope`)             |
| `<Alt>+f`        | Find in current buffer (`telescope`) |
| `<leader>f`      | Live grep (`telescope`)              |
| `Ctrl+\``        | Toggle floating terminal             |
| `Alt+x`          | Delete line without yanking          |
| `Ctrl+Backspace` | Delete previous word (Insert Mode)   |

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
