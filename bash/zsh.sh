#/bin/bash
sudo apt install fonts-powerline zsh git curl -y;

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
git clone https://github.com/powerline/fonts.git && ./fonts/install.sh && sed -i "s/robbyrussell/agnoster/g" ~/.zshrc;
echo -e "setopt EXTENDED_HISTORY\nsetopt HIST_EXPIRE_DUPS_FIRST\nsetopt HIST_IGNORE_DUPS\nsetopt HIST_IGNORE_ALL_DUPS\nsetopt HIST_IGNORE_SPACE\nsetopt HIST_FIND_NO_DUPS\nsetopt HIST_SAVE_NO_DUPS\nsetopt HIST_BEEP\n" >> ~/.zshrc;

# Switch to shell... (Permanently)
# chsh -s /bin/bash
# chsh -s /bin/zsh

# Switch to shell... (Temporarily)
# exec bash
# exec zsh