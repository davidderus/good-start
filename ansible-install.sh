#!/bin/bash

set -e

macDisclaimer="- Install XCode
- Install Brew
- Tap Brew Cask
- Install the latest Ansible version"

linuxDisclaimer="- Install software-properties-common
- Add the Ansible official ppa
- Install the latest Ansible version"

displayDisclaimer() {
  echo "
========================
= ansible installation =
========================

The following script will install basic requirements
for the dev-setup playbook for $1.

The following actions will be taken:
"

  if [[ "$install_type" == "macOS" ]]; then
    echo "$macDisclaimer"
  else
    echo "$linuxDisclaimer"
  fi

  echo
  echo "–––"
  echo
}

command_exists() {
  type "$1" &> /dev/null;
}

abort() {
  echo "⚠️  $1"
  exit 1
}

checkMacRequirements() {
  if ! command_exists ruby ; then
    abort "Ruby is missing, can't continue."
  fi
}

macSetup() {
  xcode-select -p  &> /dev/null;

  if [[ "$?" == "0" ]]; then
    echo "-> Xcode installation is okay"
  else
    echo "-> Xcode installation validation"
    xcode-select --install
  fi

  if command_exists brew ; then
    echo "-> Brew installation is already done"
  else
    echo "-> Brew installation"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo "-> Tapping brew cask"
  brew tap caskroom/cask

  echo "-> Updating brew"
  brew update

  echo "-> Installing ansible"
  brew install ansible
}

linuxSetup() {
  # Do nothing
  sudo apt-get install -y software-properties-common
  sudo apt-add-repository -y ppa:ansible/ansible
  sudo apt-get update
  sudo apt-get install -y ansible
}

if [[ "$OSTYPE" == "darwin"* ]]; then
  install_type="macOS"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  install_type="Linux"
else
  abort "Unknow OS, aborting!"
fi

displayDisclaimer $install_type

if [[ "$install_type" == "macOS" ]]; then
  checkMacRequirements
  macSetup
else
  linuxSetup
fi
