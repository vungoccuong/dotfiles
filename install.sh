#!/bin/bash

# Utils
function is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type $1 >/dev/null 2>&1 || { local return_=0;  }
  # return
  echo "$return_"
}

function install_macos {
  if [[ $OSTYPE != darwin* ]]; then
    return
  fi
  echo "MacOS detected"
  xcode-select --install

  if [ "$(is_installed brew)" == "0" ]; then
    echo "Installing Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  if [ $TERM_PROGRAM != "iTerm.app" ]; then
    echo "Installing iTerm2"
    brew tap caskroom/cask
    brew cask install iterm2
  fi

  if [ "$(is_installed zsh)" == "0" ]; then
    echo "Installing zsh"
    brew install zsh zsh-completions
  fi

  if [ "$(is_installed ag)" == "0" ]; then
    echo "Installing The silver searcher"
    brew install the_silver_searcher
  fi

  if [ "$(is_installed fzf)" == "0" ]; then
    echo "Installing fzf"
    brew install fzf
  fi

  if [ "$(is_installed tmux)" == "0" ]; then
    echo "Installing tmux"
    brew install tmux
    echo "Installing reattach-to-user-namespace"
    brew install reattach-to-user-namespace
    echo "Installing tmux-plugin-manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi

  if [ "$(is_installed git)" == "0" ]; then
    echo "Installing Git"
    brew install git
  fi

  if [ "$(is_installed node)" == "0" ]; then
    echo "Installing Node"
    brew install node
  fi

  if [ "$(is_installed nvim)" == "0" ]; then
    echo "Install neovim"
    brew install neovim
    if [ "$(is_installed pip3)" == "1" ]; then
      pip3 install neovim --upgrade
    fi
  fi

  if [ "$(is_installed  fd)" == "0"  ]; then
    echo "Install fd"
    brew install fd
  fi
  echo "install import js"
  npm i -g import-js
}

function install_debian {
  if [[ $OSTYPE != linux* ]]; then
    return
  fi

  if [ "$(is_installed zsh)" == "0" ]; then
    echo "Installing zsh"
    sudo apt install zsh zsh-completions
  fi

  if [ "$(is_installed ag)" == "0" ]; then
    echo "Installing The silver searcher"
    sudo apt install silversearcher-ag
  fi

  if [ "$(is_installed fzf)" == "0" ]; then
    echo "Installing fzf"
    sudo apt install fzf
  fi

  if [ "$(is_installed tmux)" == "0" ]; then
    echo "Installing tmux"
    sudo apt install tmux
    echo "Installing tmux-plugin-manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi


  if [ "$(is_installed nvim)" == "0" ]; then
    echo "Install neovim"
    sudo apt install neovim
    if [ "$(is_installed pip3)" == "1" ]; then
      pip3 install neovim --upgrade
    fi
  fi

  if [ "$(is_installed  fd)" == "0"  ]; then
    echo "Install fd"
    sudo apt install fd-find
  fi

  if [ "$(is_installed npm)" == "0" ]; then
    echo "install import js"
    npm i -g import-js
  fi
}

function install_arch {
  if [[ $OSTYPE != linux* ]]; then
    return
  fi

  if [ "$(is_installed zsh)" == "0" ]; then
    echo "Installing zsh"
    sudo pacman -S zsh zsh-completions
  fi

  if [ "$(is_installed ag)" == "0" ]; then
    echo "Installing The silver searcher"
    sudo pacman -S the_silver_searcher
  fi

  if [ "$(is_installed fzf)" == "0" ]; then
    echo "Installing fzf"
    sudo pacman -S fzf
  fi

  if [ "$(is_installed tmux)" == "0" ]; then
    echo "Installing tmux"
    sudo pacman -S tmux
    echo "Installing tmux-plugin-manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi


  if [ "$(is_installed nvim)" == "0" ]; then
    echo "Install neovim"
    sudo pacman -S neovim
    if [ "$(is_installed pip3)" == "1" ]; then
      pip3 install neovim --upgrade
    fi
  fi

  if [ "$(is_installed  fd)" == "0"  ]; then
    echo "Install fd"
    sudo pacman -S fd
  fi

  if [ "$(is_installed npm)" == "0" ]; then
    echo "install import js"
    npm i -g import-js
  fi
}
function oh_my_zsh_install {
  if [ ! -d "~/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi

  if [ ! -d "$ZSH/custom/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions"
    git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH/custom/plugins/zsh-autosuggestions
  fi
  if [ ! -d "$ZSH/custom/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  fi
  if [ ! -d "$(pwd)/zsh" ]; then
      git clone https://github.com/dracula/zsh.git
      ln -s $(pwd)/zsh/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme
  fi
}

function backup {
  echo "Backing up dotfiles"
  local current_date=$(date +%s)
  local backup_dir=dotfiles_$current_date

  mkdir ~/$backup_dir

  mv ~/.zshrc ~/$backup_dir/.zshrc
  mv ~/.tmux.conf ~/$backup_dir/.tmux.conf
  mv ~/.vim ~/$backup_dir/.vim
  mv ~/.vimrc ~/$backup_dir/.vimrc
  mv ~/.vimrc.bundles ~/$backup_dir/.vimrc.bundles
}

function link_dotfiles {
  echo "Linking dotfiles"
  ln -s $(pwd)/alacritty  ~/.config/
  ln -s $(pwd)/zshrc ~/.zshrc
  ln -s $(pwd)/tmux.conf ~/.tmux.conf
  ln -s $(pwd)/vim ~/.vim
  ln -s $(pwd)/vimrc ~/.vimrc
  ln -s $(pwd)/vimrc.bundles ~/.vimrc.bundles
  ln -s $(pwd)/ideavimrc ~/.ideavimrc
  ln -s $(pwd)/bin/tmux-session /usr/local/bin
  ln -s ~/.vim/bundle/gruvbox/colors/gruvbox.vim ~/.vim/colors/



  curl -L https://raw.githubusercontent.com/sbugzu/gruvbox-zsh/master/gruvbox.zsh-theme > ~/.oh-my-zsh/custom/themes/gruvbox.zsh-theme

  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  rm -rf $HOME/.config/nvim/init.vim
  rm -rf $HOME/.config/nvim
  mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
  ln -s $(pwd)/vim $XDG_CONFIG_HOME/nvim
  ln -s $(pwd)/vimrc $XDG_CONFIG_HOME/nvim/init.vim
}

while test $# -gt 0; do 
  case "$1" in
    --help)
      echo "Help"
      exit
      ;;
    --macos)
      install_macos
      backup
      link_dotfiles
      zsh
      source ~/.zshrc
      exit
      ;;
    --debian)
      install_debian
      backup
      link_dotfiles
      zsh
      source ~/.zshrc
      exit
      ;;
    --arch)
      install_arch
      backup
      link_dotfiles
      zsh
      source ~/.zshrc
      exit
      ;;
    --backup)
      backup
      exit
      ;;
    --oh_my_zsh)
      oh_my_zsh_install
      exit
      ;;
    --dotfiles)
      link_dotfiles
      exit
      ;;
  esac

  shift
done
