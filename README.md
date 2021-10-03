[![install](https://github.com/evanriley/config/actions/workflows/install.yml/badge.svg)](https://github.com/evanriley/config/actions/workflows/install.yml)

Hello there, these are my dotfiles!

- OS - macOS & openSUSE Tumbleweed, WSL(Also openSUSE Tumbleweed)
- Shell - Fish
- Terminal - Kitty, iTerm2, Windows Terminal
- Editors - Neovim & Doom Emacs

# Setup

1. Install the dotfiles into a bare repo.

```shell
curl -sL https://raw.githubusercontent.com/evanriley/config/main/bin/install | bash
```

2. Install dependecies and enable services

- macOS: Use Brewfile in /bin

```shell
brew bundle --file ~/bin/Brewfile

# For Apple Silicon
sudo softwareupdate --install-rosetta --agree-to-license
```

- openSUSE Tumbleweed

```shell
...Coming soon
```

3. Install system defaults and user configs.

- macOS - All in the /bin/macos file

```shell
./bin/macos
```

Restart & Enjoy
