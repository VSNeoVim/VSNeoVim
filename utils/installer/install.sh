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
  echo "    -m, --miniinstall                        minimal installation dependencies"
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
        ;;
      -m | --miniinstall)
        miniinstallation
        cloning_vsneovim
        exit 0
        ;;
      -h | --help)
        usage
        exit 0
        ;;
    esac
    shift
  done
}
function detect_platform() {
  OS="$(uname -s)"
  case "$OS" in
    Linux)
      if [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ]; then
        msg "Detecting platform: installing setup on arch based system."
        RECOMMEND_INSTALL="sudo pacman -S --noconfirm"
      elif [ -f "/etc/fedora-release" ] || [ -f "/etc/redhat-release" ]; then
        msg "Detecting platform: installing setup on redhat based system."
        RECOMMEND_INSTALL="sudo dnf install -y"
      elif [ -f "/etc/gentoo-release" ]; then
        msg "Detecting platform: installing setup on gento system"
        RECOMMEND_INSTALL="emerge install -y"
      else # assume debian based
        msg "Detecting platform: installing setup on debian based system"
        RECOMMEND_INSTALL="sudo apt install -y"
      fi
      ;;
    FreeBSD)
      RECOMMEND_INSTALL="sudo pkg install -y"
      ;;
    NetBSD)
      RECOMMEND_INSTALL="sudo pkgin install"
      ;;
    OpenBSD)
      RECOMMEND_INSTALL="doas pkg_add"
      ;;
    Darwin)
      RECOMMEND_INSTALL="brew install"
      ;;
    *)
      echo "OS :$OS is not currently supported."
      exit 1
      ;;
  esac
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
function __installing_neovim() {
  if confirm "Would you like to install neovim ?"; then
    $RECOMMEND_INSTALL neovim
  fi
  echo ""
}
function __installing_lua() {
  if confirm "Would you like to install lua and luajit ?"; then
    $RECOMMEND_INSTALL luajit
    $RECOMMEND_INSTALL lua || $RECOMMEND_INSTALL lua5.4
  fi
  echo ""
}
function __installing_python() {
  if confirm "Would you like to install neovim's python librarys ?"; then
    python3 -m pip install pynvim
  fi
  echo ""
}
function __installing_node() {
  if confirm "Would you like to install node ?"; then
    $RECOMMEND_INSTALL nodejs npm yarn
  fi
  echo ""
}
function __installing_utils() {
  if confirm "Would you like to install treesitter and lazygit ?"; then
    $RECOMMEND_INSTALL lazygit  tree-sitter
  fi
  echo ""
}
function __installing_ripgrep() {
  if confirm "Would you like to install ripgrep ?"; then
    $RECOMMEND_INSTALL ripgrep
  fi
  echo ""
}
function installation() {
  detect_platform
  __installing_neovim
  __installing_lua
  __installing_python
  __installing_node
  __installing_utils
  __installing_ripgrep
}
function miniinstallation() {
  detect_platform
  __installing_lua
  __installing_python
  __installing_node
  __installing_ripgrep
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
