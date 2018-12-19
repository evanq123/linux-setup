#!/bin/bash
set -e

## Git-Bash
curl -o ~/.git-bash.sh https://raw.githubusercontent.com/evanq123/linux-setup/master/.git-bash.sh
curl -o ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

# Add newline at the end of the '.bash_profile' if it doesn't exist
sed -i '' '$a\' ~/.bash_profile

echo "source ~/.git-bash.sh" >> ~/.bash_profile

## Vim configs
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
curl -o ~/.vimrc https://raw.githubusercontent.com/evanq123/linux-setup/master/.vimrc
cd ~/.vim/bundle && \
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
cd ~
