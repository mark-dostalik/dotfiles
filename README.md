Credit: https://stegosaurusdormant.com/bare-git-repo/#copying-your-dotfiles-to-another-machine

# Initial setup

1. Create a new bare Git repo to store the history for your dotfiles.
   ```
   git init --bare $HOME/dotfiles
   ```
2. Tell Git that it should use your home directory as the snapshot for this bare Git repo.
   ```
   alias dotfiles='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
   ```
   `--git-dir` tells Git where the history lives and `--work-tree` tells Git where the snapshot lives (the snapshot is called the “working tree” in Git jargon). We create an aliased command here so that you don’t have to specify these options manually every time you want to add a dotfile to your Git repo. If you want to use this command in the future, you should add this line to your `.bashrc`, `.zshrc` or whatever dotfile you use for aliases.
   
3. Tell Git that this repo should not display all untracked files (otherwise git status will include every file in your home directory, which will make it unusable).
   ```
   dotfiles config status.showUntrackedFiles no
   ```
4. Set up a remote repo to sync your dotfiles to
   ```
   dotfiles remote add origin git@github.com:mark-dostalik/dotfiles.git
   ```
5. Whenever you want to add a new dotfile to your Git repo, use your aliased Git command with your special options set.
   ```
   dotfiles add ~/.gitconfig
   dotfiles commit -m "Git dotfiles"
   dotfiles push origin master
   ```

# Copying dotfiles to another machine

1. Clone your repo onto the new machine as a non-bare repository. You need a non-bare repository on the new machine since you’re trying to move the actual dotfiles (that is, the snapshot of your repo) onto the new machine, not just the history.
   ```
   git clone --separate-git-dir=$HOME/dotfiles git@github.com:mark-dostalik/dotfiles.git dotfiles-tmp
   ```
   `--separate-git-dir` tells Git that the history should live in `$HOME/dotfiles` even though the snapshot will live in `dotfiles-tmp` (which is just an arbitrary temporary directory that we’ll delete later once we’ve moved the `dotfiles` into their proper locations).
   
2. Copy the snapshot from your temporary directory to the correct locations on your new machine.
   ```
   rsync --recursive --verbose --exclude '.git' dotfiles-tmp/ $HOME/
   ```
   This command copies every file in `dotfiles-tmp` and its subdirectories into the corresponding locations in your home directory (so `dotfiles-tmp/.gitconfig` will be copied to `~/.gitconfig` and `dotfiles-tmp/.emacs.d/init.el` will be copied to `~/.emacs.d/init.el`, etc.).
   
3. Remove the temporary directory. Now that we’ve copied over the snapshot to the correct locations in your actual home directory, we can delete the old snapshot.
   ```
   rm -rf dotfiles-tmp
   ```
4. At this point, your new machine has the dotfiles in the correct locations in your home directory and is tracking their history in `~/dotfiles`, which is exactly the same state that your original machine was in after Step 1 of the initial setup. To allow your new machine to track changes to the dotfiles, just follow the steps you followed on your original machine, starting with Step 2.
