[![install](https://github.com/evanriley/config/actions/workflows/install.yml/badge.svg)](https://github.com/evanriley/config/actions/workflows/install.yml)

Hello there, these are my dotfiles!

- OS - macOS
- Shell - Fish
- Terminal - iTerm2
- Editors - Neovim & Doom Emacs

# Setup

1. Install the dotfiles into a bare repo.

```shell
curl -sL https://evanriley.dev/dotfiles | bash
```

2. Install dependecies and enable services

- macOS: Use Brewfile in /bin

```shell
brew bundle --file ~/bin/Brewfile

# For Apple Silicon
sudo softwareupdate --install-rosetta --agree-to-license
```

3. Install system defaults and user configs.

- macOS - Most settings will be set in this shell script.

```shell
./bin/macos
```

Restart & Enjoy
