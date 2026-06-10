# Dotfiles

## Base setup

1. Install the following CLI tools.
   - [`bat`](https://github.com/sharkdp/bat)
   - [`carapace`](https://github.com/carapace-sh/carapace-bin)
   - [`eza`](https://github.com/eza-community/eza)
   - [`fd`](https://github.com/sharkdp/fd)
   - [`fzf`](https://github.com/junegunn/fzf)
   - [`gh`](https://cli.github.com/)
   - [`ripgrep`](https://github.com/BurntSushi/ripgrep)
   - [`yazi`](https://github.com/sxyazi/yazi)
   - [`zoxide`](https://github.com/ajeetdsouza/zoxide)
2. Clone this repo onto the new machine.

   ```
   git clone --recurse-submodules --separate-git-dir=$HOME/.dotfiles git@github.com:mark-dostalik/dotfiles.git dotfiles-tmp
   ```

3. Copy the snapshot from the temporary directory to the correct locations.

   ```
   rsync --recursive --links --verbose --exclude '.git' dotfiles-tmp/ $HOME/
   ```

4. Remove the temporary directory.

   ```
   rm -rf dotfiles-tmp
   ```

## Touch ID for `sudo`

To enable Touch ID for `sudo` on macOS run

```
brew install pam-reattach
```

Then, add the following line to the top of the `/etc/pam.d/sudo` file (needs to be edited with `sudo` permissions):

```
auth       optional       /opt/homebrew/lib/pam/pam_reattach.so
```

## iTerm2 configuration

1. Specify the preferences directory.

   ```
   defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.config/iterm2/settings"
   ```

2. Tell iTerm2 to use the custom preferences in the directory.

   ```
   defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
   ```

3. Save preferences automatically.

   ```
   defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2
   ```

## Neovim setup

Install neovim

```
brew install neovim
```

and make sure all [requirements](https://www.lazyvim.org/#%EF%B8%8F-requirements) for LazyVim are satisfied.
