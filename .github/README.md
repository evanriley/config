[![install](https://github.com/evanriley/config/actions/workflows/install.yml/badge.svg)](https://github.com/evanriley/config/actions/workflows/install.yml)

Hello there, these are my dotfiles!

- OS - macOS/Arch Linx
- Shell - Fish
- Terminal - iTerm2/Kitty/st
- Editors - neovim

# Setup

1. Install the dotfiles into a bare repo.

- If on macOS run:
```shell
curl -sL https://evanriley.dev/macdots | bash
```

- If on (Arch) Linux run:
```shell
curl -sL https://evanriley.dev/archdots | bash
```

2. Install dependecies and enable services

- macOS: macOS will use the Brewfile to download everything we want.
```shell
brew bundle --file ~/bin/Brewfile

# For Apple Silicon
sudo softwareupdate --install-rosetta --agree-to-license
```

- Linux: uhh, just yay -S everything you can think of, a script will come soon enough.

3. Install system defaults and user configs.

- macOS: Most settings will be set in this shell script.

```shell
./bin/macos
```

- Linux: Everything just kind reads what it needs from the mess they created in $HOME and .config
  if I can think of anything to script I'll make one eventually.

Restart & Enjoy
