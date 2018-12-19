#!/bin/bash
set -e

## .bash_profile, .bashrc
curl -o ~/.bash_profile https://raw.githubusercontent.com/evanq13/linux-setup/master/.bash_profile
curl -o ~/.bashrc https://raw.githubusercontent.com/evanq13/linux-setup/master/.bashrc

## Git-Bash
curl -o ~/.git-bash.sh https://raw.githubusercontent.com/evanq123/linux-setup/master/.git-bash.sh
curl -o ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

## Vim configs
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
curl -o ~/.vimrc https://raw.githubusercontent.com/evanq123/linux-setup/master/.vimrc
cd ~/.vim/bundle && \
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
cd ~
