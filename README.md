# Vim configuration

Standalone-Vim-Konfiguration ohne externe Plugins, mit Catppuccin-Farben,
modularer Statusline und vertrauten Editor-Keybindings.

**[Vollständige Dokumentation](https://aco-vim.readthedocs.io/en/latest/)** ·
[Arch-Paket](https://aco-vim.readthedocs.io/en/latest/packages/) ·
[Keybindings](https://aco-vim.readthedocs.io/en/latest/keybindings/) ·
[Dotfiles-Handbuch](https://aco-arch-dotfiles.readthedocs.io/en/latest/)

```bash
curl -fsSL https://raw.githubusercontent.com/Akademie-Olympia/aco-arch-dotfiles/main/install.sh | bash -s -- vim
```

Paket: `aco-arch-dotfiles-vim`. Einstieg: `~/.config/vim/vimrc`, verlinkt als `~/.vimrc`.
Standalone-Installation und Bedienung sind im Handbuch beschrieben.
Hier entwickeln und auf `main` pushen; nach erfolgreichem Registry-Build mit
`sudo pacman -Syu` aktualisieren. Lokale Builds: [PACKAGING.md](PACKAGING.md).

[![Package safety](https://github.com/Akademie-Olympia/aco-vim/actions/workflows/package.yml/badge.svg)](https://github.com/Akademie-Olympia/aco-vim/actions/workflows/package.yml)

[MIT-Lizenz](LICENSE).
