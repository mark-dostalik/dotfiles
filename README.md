1. Clone this repo onto the new machine

   ```
   git clone --recurse-submodules --separate-git-dir=$HOME/.dotfiles git@github.com:mark-dostalik/dotfiles.git dotfiles-tmp
   ```

2. Copy the snapshot from the temporary directory to the correct locations

   ```
   rsync --recursive --links --verbose --exclude '.git' dotfiles-tmp/ $HOME/
   ```

3. Remove the temporary directory

   ```
   rm -rf dotfiles-tmp
   ```

4. Install [Homebrew](https://brew.sh/) and then run

   ```
   brew bundle --file=~/.config/brew/Brewfile
   ```

5. Apply macOS configuration

   ```
   bash ~/.config/macos/defaults.sh
   ```
