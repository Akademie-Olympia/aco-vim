# Vim configuration

Standalone Vim configuration without external plugins, with Catppuccin colours, a modular status line and familiar editor key bindings.

**[Full documentation](https://aco-vim.readthedocs.io/en/latest/)** ·
[Arch package](https://aco-vim.readthedocs.io/en/latest/packages/) ·
[Key bindings](https://aco-vim.readthedocs.io/en/latest/keybindings/) ·
[Design & dependencies](https://aco-vim.readthedocs.io/en/latest/design/)

```bash
curl -fsSL https://raw.githubusercontent.com/Akademie-Olympia/aco-arch-dotfiles/main/install.sh | bash -s -- vim
```

Package: `aco-arch-dotfiles-vim`. Entry point: `~/.config/vim/vimrc`, linked as `~/.vimrc`.
Standalone installation and usage are described in the manual.
Develop independently in this repository and push to `main`; after a successful registry build update with `sudo pacman -Syu`. Local builds: [PACKAGING.md](PACKAGING.md).

[![Package safety](https://github.com/Akademie-Olympia/aco-vim/actions/workflows/package.yml/badge.svg)](https://github.com/Akademie-Olympia/aco-vim/actions/workflows/package.yml)

[MIT licence](LICENSE).
