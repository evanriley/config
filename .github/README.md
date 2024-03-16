# Setup

1. Install the dotfiles into a bare repo.

```shell
curl -SL https://ecr.lol/macdots |  bash
```

2. Install dependecies and enable services

```shell
# For Apple Silicon
sudo softwareupdate --install-rosetta --agree-to-license

brew bundle --file ~/bin/Brewfile

```

3. Install system defaults and user configs.

```shell
./bin/macos
```

Restart & Enjoy
