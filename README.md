1. Generate an SSH key on the new machine and upload it to GitHub

   ```
   ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_personal_github -C "Comment"
   ```

2. Fill in your `~/.ssh/config`

   ```
   Host github.com
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/id_ed25519_personal_github
   ```

3. Clone this repo

   ```
   git clone --recurse-submodules --separate-git-dir=$HOME/.dotfiles git@github.com:mark-dostalik/dotfiles.git dotfiles-tmp
   ```

4. Copy the snapshot from the temporary directory to the correct locations

   ```
   rsync --recursive --links --verbose --exclude '.git' dotfiles-tmp/ $HOME/
   ```

5. Remove the temporary directory

   ```
   rm -rf dotfiles-tmp
   ```

6. Install [Homebrew](https://brew.sh/) and then run

   ```
   brew bundle --file=~/.config/brew/Brewfile
   ```

7. Apply macOS configuration

   ```
   bash ~/.config/macos/defaults.sh
   ```
