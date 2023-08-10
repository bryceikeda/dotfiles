#!/bin/bash
set -e

# Check if a command exists
command_exists() {
  command -v "$@" >/dev/null 2>&1
}

# Check if the user can use sudo
user_can_sudo() {
  command_exists sudo && sudo -n -v >/dev/null 2>&1
}

# Install fzf using sudo if available
install_fzf() {
  if ! command_exists fzf; then
    local run_command
    if user_can_sudo; then
      run_command="sudo apt-get"
    else
      run_command="command apt-get"
    fi
    $run_command install --no-install-recommends -y fzf
  fi
}

# Install Git using sudo if available
install_git() {
  if ! command_exists git; then
    local run_command
    if user_can_sudo; then
      run_command="sudo apt-get"
    else
      run_command="command apt-get"
    fi
    $run_command update
    $run_command install --no-install-recommends -y git
  fi
}

# Install yadm
install_yadm() {
  if ! command_exists yadm; then
    mkdir -p "$HOME/.local/bin" && export PATH=$PATH:"$HOME/.local/bin/"
    curl -fLo "$HOME/.local/bin/yadm" https://github.com/TheLocehiliosan/yadm/raw/master/yadm
    chmod a+x "$HOME/.local/bin/yadm"
  fi
}

# Main function
main() {
  # Parse arguments
  while [ $# -gt 0 ]; do
    case $1 in
      --full) export INSTALL_FULL=yes ;;
    esac
    shift
  done

  install_git
  install_fzf
  install_yadm

  # Clone or bootstrap dotfiles
  if ! yadm clone --bootstrap -b main https://github.com/bryceikeda/dotfiles.git 2>/dev/null; then
    yadm bootstrap
  fi
}

# Call the main function
main "$@"
