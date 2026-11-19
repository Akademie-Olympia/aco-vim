# Arch package and automatic updates

```bash
curl -fsSL https://raw.githubusercontent.com/Akademie-Olympia/aco-arch-dotfiles/main/install.sh | bash -s -- vim
```

This installs `aco-arch-dotfiles-vim`, Vim and the activation tool. Existing
configuration and `~/.vimrc` are backed up before editable user copies are linked.
No plugins are downloaded or login shells changed. Do not edit `/usr` defaults.

Update with `sudo pacman -Syu`. The installed timer synchronizes defaults, or use
`aco sync`. Own edits survive; merge `.pacnew` files and reload Vim. Develop in
a separate checkout and push to `main`. The registry checks sources every five
minutes and publishes after passing tests; GitHub can delay scheduled runs.

Removal: `aco-arch-dotfiles-config deactivate vim`, then
`sudo pacman -Rns aco-arch-dotfiles-vim`. Remove a dependent overall metapackage
first. Backups, edited copies and editor state are not deleted.

[Installer, migration and safety](https://aco-arch-dotfiles.readthedocs.io/en/latest/arch-package/) ·
[Verification](https://aco-arch-dotfiles.readthedocs.io/en/latest/verification/).
Standalone setup: {doc}`installation`.
