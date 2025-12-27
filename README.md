1. Install the following CLI tools.
   - [`bat`](https://github.com/sharkdp/bat)
   - [`carapace`](https://github.com/carapace-sh/carapace-bin)
   - [`eza`](https://github.com/eza-community/eza)
   - [`fd`](https://github.com/sharkdp/fd)
   - [`fzf`](https://github.com/junegunn/fzf)
   - [`ripgrep`](https://github.com/BurntSushi/ripgrep)
   - [`yazi`](https://github.com/sxyazi/yazi)
   - [`zoxide`](https://github.com/ajeetdsouza/zoxide)
2. Clone this repo onto the new machine as a non-bare repository (that includes the snapshot).
   ```
   git clone --recurse-submodules --separate-git-dir=$HOME/.dotfiles git@github.com:mark-dostalik/dotfiles.git dotfiles-tmp
   ```
3. Copy the snapshot from your temporary directory to the correct locations on your new machine.
   ```
   rsync --recursive --links --verbose --exclude '.git' dotfiles-tmp/ $HOME/
   ```
4. Remove the temporary directory.
   ```
   rm -rf dotfiles-tmp
   ```
