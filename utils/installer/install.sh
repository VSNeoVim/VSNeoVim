#!/usr/bin/bash

declare VSN_BRANCH="${VSN_BRANCH:-"master"}"
declare -r VSN_REMOTE="${VSN_REMOTE:-VSNeoVim/VSNeoVim.git}"

declare -r INSTALL_PREFIX="${INSTALL_PREFIX:-"$HOME/.local"}"

declare -r XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
declare -r XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"
declare -r XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"

declare -r VSN_RUNTIME_DIR="${VSN_RUNTIME_DIR:-"$XDG_DATA_HOME/vsneovim"}"
declare -r VSN_CONFIG_DIR="${VSN_CONFIG_DIR_CONFIG_DIR:-"$XDG_CONFIG_HOME/vsn"}"
declare -r VSN_CACHE_DIR="${VSN_CACHE_DIR:-"$XDG_CACHE_HOME/vsn"}"

function msg() {
  local text="$1"
  local div_width="80"
  printf "%${div_width}s\n" ' ' | tr ' ' -
  printf "%s\n" "$text"
}
function usage() {
  echo "Usage: install.sh [<options>]"
  echo ""
  echo "Options:"
  echo "    -d, --dependencies                       dependencies"
  echo "    -i, --install                            installing all dependencies"
}
function dependencies() {
  echo "Visual Studio NeoVim All dependencie:"
  echo ""
  echo "  neovim      "
  echo "  lua         "
  echo "  luajit      "
  echo "  python      "
  echo "  npm         "
  echo "  node        "
  echo "  yarn        "
  echo "  python-pip  "
  echo "  lazygit     "
  echo "  tree-sitter "
  echo "  ripgrep     "
  echo ""
}
function parse_arguments() {
  while [ "$#" -gt 0 ]; do
    case "$1" in
      -d | --dependencies)
        dependencies   
        exit 0
        ;;
      -i | --install)
        installation
        cloning_vsneovim
        install_binary
        ;;
      -h | --help)
        usage
        exit 0
        ;;
    esac
    shift
  done
}
function confirm() {
  local question="$1"
  while true; do
    msg "$question"
    read -p "[y]es or [n]o (default: yes) : " -r answer
    case "$answer" in
      y | Y | yes | YES | Yes | "")
        return 0
        ;;
      n | N | no | NO | No)
        return 1
        ;;
      *)
        msg "Please answer [y]es or [n]o."
        ;;
    esac
  done
}
function detect_platform() {
  OS="$(uname -s)"
  case "$OS" in
    Linux)
      if [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ]; then
        msg "Detecting platform: installing setup on arch based system."
        if confirm "Would you like to install neovim ?"; then
          sudo pacman -S --noconfirm neovim
        fi
        if confirm "Would you like to install lua and luajit ?"; then
          sudo pacman -S --noconfirm luajit
          sudo pacman -S --noconfirm lua
        fi
        if confirm "Would you like to install neovim's python librarys ?"; then
          python3 -m pip install pynvim
        fi
        if confirm "Would you like to install node ?"; then
          sudo pacman -S --noconfirm nodejs npm yarn
        fi
        if confirm "Would you like to install treesitter and lazygit ?"; then
          sudo pacman -S --noconfirm lazygit tree-sitter
        fi
        if confirm "Would you like to install ripgrep ?"; then
          sudo pacman -S --noconfirm ripgrep
        fi
      elif [ -f "/etc/fedora-release" ] || [ -f "/etc/redhat-release" ]; then
        msg "Detecting platform: installing setup on redhat based system."
        if confirm "Would you like to install neovim ?"; then
          sudo dnf -y install neovim
        fi
        if confirm "Would you like to install lua and luajit ?"; then
          sudo dnf -y install luajit
          sudo dnf -y install lua
        fi
        if confirm "Would you like to install neovim's python librarys ?"; then
          python3 -m pip install pynvim
        fi
        if confirm "Would you like to install node ?"; then
          sudo dnf -y install nodejs npm yarn
        fi
        if confirm "Would you like to install ripgrep ?"; then
          sudo dnf -y install ripgrep
        fi
      elif [ -f "/etc/SuSE-release" ]; then
        msg "Detecting platform: installing setup on gento system"
        if confirm "Would you like to install neovim ?"; then
          sudo zypper install neovim
        fi
        if confirm "Would you like to install lua and luajit ?"; then
          sudo zypper install luajit
          sudo zypper install lua
        fi
        if confirm "Would you like to install neovim's python librarys ?"; then
          python3 -m pip install pynvim
        fi
        if confirm "Would you like to install node ?"; then
          sudo zypper install nodejs npm yarn
        fi
        if confirm "Would you like to install ripgrep ?"; then
          sudo dnf -y install ripgrep
        fi
      else # assume debian based
        msg "Detecting platform: installing setup on debian based system"
        if confirm "Would you like to install neovim ?"; then
          sudo apt -y install neovim
        fi
        if confirm "Would you like to install lua and luajit ?"; then
          sudo apt -y install luajit
          sudo apt -y install lua
        fi
        if confirm "Would you like to install neovim's python librarys ?"; then
          python3 -m pip install pynvim
        fi
        if confirm "Would you like to install node ?"; then
          sudo apt -y install nodejs npm yarn
        fi
        if confirm "Would you like to install ripgrep ?"; then
          sudo dnf -y install ripgrep
        fi
      fi
      ;;
    FreeBSD)
      msg "Detecting platform: installing setup on FreeBSD system"
      if confirm "Would you like to install neovim ?"; then
        sudo pkg install neovim
      fi
      if confirm "Would you like to install lua and luajit ?"; then
        sudo pkg install luajit
        sudo pkg install lua
      fi
      if confirm "Would you like to install neovim's python librarys ?"; then
        python3 -m pip install pynvim
      fi
      if confirm "Would you like to install node ?"; then
        sudo pkg install nodejs npm yarn
      fi
      if confirm "Would you like to install ripgrep ?"; then
        sudo pkg install ripgrep
      fi
      ;;
    NetBSD)
      msg "Detecting platform: installing setup on NetBSD system"
      if confirm "Would you like to install neovim ?"; then
        sudo pkgin install neovim
      fi
      if confirm "Would you like to install lua and luajit ?"; then
        sudo pkgin install luajit
        sudo pkgin install lua
      fi
      if confirm "Would you like to install neovim's python librarys ?"; then
        python3 -m pip install pynvim
      fi
      if confirm "Would you like to install node ?"; then
        sudo pkgin install nodejs npm yarn
      fi
      if confirm "Would you like to install ripgrep ?"; then
        sudo pkgin install ripgrep
      fi
      ;;
    OpenBSD)
      msg "Detecting platform: installing setup on OpenBSD system"
      if confirm "Would you like to install neovim ?"; then
        doas pkg_add neovim
      fi
      if confirm "Would you like to install lua and luajit ?"; then
        doas pkg_add luajit
        doas pkg_add lua
      fi
      if confirm "Would you like to install neovim's python librarys ?"; then
        python3 -m pip install pynvim
      fi
      if confirm "Would you like to install node ?"; then
        doas pkg_add nodejs npm yarn
      fi
      if confirm "Would you like to install ripgrep ?"; then
        doas pkg_add ripgrep
      fi
      ;;
    Darwin)
      RECOMMEND_INSTALL="brew install"
      msg "Detecting platform: installing setup on OpenBSD system"
      if confirm "Would you like to install neovim ?"; then
        brew install neovim
      fi
      if confirm "Would you like to install lua and luajit ?"; then
        brew install luajit
        brew install lua
      fi
      if confirm "Would you like to install neovim's python librarys ?"; then
        python3 -m pip install pynvim
      fi
      if confirm "Would you like to install node ?"; then
        brew install nodejs npm yarn
      fi
      if confirm "Would you like to install ripgrep ?"; then
        brew install ripgrep
      fi
      if confirm "Would you like to install treesitter and lazygit ?"; then
        brew install lazygit tree-sitter
      fi
      ;;
    *)
      echo "OS :$OS is not currently supported."
      exit 1
      ;;
  esac
}
function installation() {
  detect_platform
}
function cloning_vsneovim() {
  msg "cloning VSNeoVim ..."
  git clone --branch "$VSN_BRANCH" "https://github.com/${VSN_REMOTE}" "$VSN_RUNTIME_DIR"
  echo "done cloning !"
}
function install_binary() {
  msg "installing binary script ..."
  mkdir $INSTALL_PREFIX/bin/
  curl -s https://raw.githubusercontent.com/vsneovim/vsneovim/main/utils/bin/vsn.template >> $INSTALL_PREFIX/bin/vsn
  chmod +x $INSTALL_PREFIX/bin/vsn
}
function logo(){
  cat <<'EOF'
    
                            ########               ########                           
                          ############           ############                         
                         ##############         ##############                        
                        ################ ##### ################                       
                        #######################################                       
                        ################       ################                       
                         ##############         ##############                        
                          ############           ############                         
                            ########               ########                           
                          ###                             ###                         
                         ###                               ###                        
                         ###                               ###                        
                         ###                               ###                        
                         ###                               ###                        
                          ####                            ####                        
                           ####                          ####                         
       db    db .d8888.   d8b   db d88888b  .d88b.  db    db d888888b .88b  d88.      
       88    88 88'  YP   888o  88 88'     .8P  Y8. 88    88   `88'   88'YbdP`88      
       Y8    8P `8bo.     88V8o 88 88ooooo 88    88 Y8    8P    88    88  88  88      
       `8b  d8'   `Y8b.   88 V8o88 88~~~~~ 88    88 `8b  d8'    88    88  88  88      
        `8bd8'  db   8D   88  V888 88.     `8b  d8'  `8bd8'    .88.   88  88  88      
          YP    `8888Y'   VP   V8P Y88888P  `Y88P'     YP    Y888888P YP  YP  YP      
EOF
}
function main() {
  clear
  parse_arguments "$@"
  logo
  installation
  install_binary
  cloning_vsneovim
}
main "$@"
