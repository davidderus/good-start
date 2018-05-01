# Variables

What follows is a listing of all the overridable vars of good-start with their default values.
Feel free to override any of them in your host_vars.

## `backup` role – roles/backup/defaults/main.yml

```yml
# `backup_repository` is a directory or a remote host
# see https://restic.readthedocs.io/en/stable/manual.html#initialize-a-repository
# @note This is a mandatory variable
# backup_repository: $HOME/my-restic-repository

# `backup_password` is the backup password
# @note This is a mandatory variable
# backup_password: "{{ vault_backup_password }}"

# Restic Github repository
restic_repository: 'restic/restic'

# Platform string in the release file name
restic_linux_binary_name: linux_amd64

# Github regex to parse a release
github_release_regex: 'https:\/\/github\.com\/%s\/releases\/download\/[\d\w\.]{5,}\/[\w\.]+_%s\.\w+'

# Regex to get restic release infos
restic_release_regex: "{{ github_release_regex | format((restic_repository | regex_escape), restic_linux_binary_name) }}"

# Path to install restic binary to (Debian)
restic_binary_dest: '/usr/local/bin/restic'

# Where the backup scripts are saved
backup_scripts_directory: ~/restic-backup

# Files or directory to excludes in addition to the defaults
backup_additional_exclusions: []

# Enable cleanup of old backups references (without prune / restic forget)
backup_cleanup: True

# Specify forget options
backup_cleanup_settings:
  keep_daily: 7
  keep_weekly: 4
  keep_monthly: 6

# Prune forgotten files
backup_allow_prune: True

# Sets up a cron to run backup
backup_with_cron: False
backup_cron:
  hour: "12,20"
  minute: "30"

# Handling extra environment variables to export
backup_env_vars: {}

# Init restic
backup_init: True
```

## `docker` role – roles/docker/defaults/main.yml

```yml
# Images are pulled from Docker Hub or any public Docker registry
docker_images_to_pull: []

###################
# Debian specific #
###################

# Docker machine release version
docker_machine_version: v0.12.2

# Docker machine release filename
docker_machine_filename: docker-machine-linux-x86_64

# Release url to download from
docker_machine_url: "https://github.com/docker/machine/releases/download/{{ docker_machine_version }}/{{ docker_machine_filename }}"

# Max time to wait for Docker Daemon
docker_daemon_waiting_time: 30

# Docker hypervisor process name on macOS, used to check if Docker is running
docker_running_process_name: com.docker.hyperkit # Using Docker Hypervisor

# Docker service name on Debian
docker_service_name: docker.service
```

## `dotfiles` role – roles/dotfiles/defaults/main.yml

```yml
# Username to use for the user identity
# @note this is mandatory
# dotfiles_user_name: John Doe

# Email to use for the user identity
# @note this is mandatory
# dotfiles_user_email: john@doe.com

# Enable a developpment log for day-to-day notes
dotfiles_devlog_enabled: True
dotfiles_devlog_directory: '$HOME/Devlog'

# Sets the $EDITOR
dotfiles_default_editor: nvim

# Sets the $PAGER
dotfiles_default_pager: vimpager

# Sets the $GOPATH
dotfiles_go_path: ~/go/

dotfiles_locale: en_US.UTF-8

# Sets the pager used by git
dotfiles_git_pager: "diff-so-fancy | less --tabs=4 -RFX"

# Sets the editor used by git
dotfiles_git_editor: "{{ dotfiles_default_editor }}"

# Lists enabled Oh-my-zsh plugins
dotfiles_zsh_plugins:
  - git
  - ruby
  - git-flow
  - tmux
  - docker
  - docker-compose
  - docker-machine

# List enabled zsh plugins for Darwin
darwin_zsh_plugins:
  - brew
  - brew-cask
  - osx

# List enabled zsh plugins for Debian
debian_zsh_plugins: []

# List the dotfiles to sync
# Format:
#   {name: 'template-name', destination: 'optional-destination'}
#   where 'optional-destination' is a destination different
#     than ~/.template-name (see roles/dotfiles/templates/src for details)
dotfiles_files:
  - { name: 'agignore' }
  - { name: 'aliases' }
  - { name: 'ansible.cfg' }
  - { name: 'exports' }
  - { name: 'functions' }
  - { name: 'gitconfig' }
  - { name: 'gitignore' }
  - { name: 'screenrc' }
  - { name: 'tmux.conf' }
  - { name: 'vimrc' }
  - { name: 'zshrc' }
  - { name: 'direnvrc' }
  - { name: 'aria2.conf', destination: '~/.aria2/aria2.conf' }

# Username to use for git identity
dotfiles_git_name: "{{ dotfiles_user_name }}"

# Email to use for git identity
dotfiles_git_email: "{{ dotfiles_user_email }}"

# Will override any changes to the system dotfiles
dotfiles_sync_force: True

# Directories to build before syncing dotfiles
dotfiles_required_directories:
  - ~/.ansible/group_vars
  - ~/.ansible/host_vars
  - "{{ dotfiles_go_path }}"
  - ~/.vim/autoload
  - ~/.tmux/plugins
  - ~/.aria2
  - ~/.config/nvim
  - ~/.config/terminator
  - "{{ dotfiles_vimplug_destination | dirname }}"

# Files to create  before syncing dotfiles
dotfiles_required_files:
  - { path: '~/.ansible/hosts.ini', mode: '0600' }
  - { path: '~/.ssh/config', mode: '0600' }
  - { path: '~/.extra', mode: '0600' }

# Path to Atom packages
dotfiles_apm_path: ~/.atom/packages

# A list of Atom packages to install
dotfiles_apm_packages:
  - sync-settings # Other packages and settings are pulled by this package

# Will use neovim system-wide instead of vim
dotfiles_with_neovim: True
dotfiles_vimplug_destination: "{{ '~/.local/share/nvim/site/autoload/plug.vim' if dotfiles_with_neovim else '~/.vim/autoload/plug.vim' }}"
dotfiles_vim_executable: "{{ 'nvim' if dotfiles_with_neovim else 'vim' }}"

# Using the Maj key as it mimics Vim (forward|backward)-word shortcut.
# Also because Ctrl is used by macOS and Alt by Tmux
dotfiles_terminal_shortcuts:
  - sequence: ^[[1;2C
    action: forward-word
    comment: Maj + ->
  - sequence: ^[[1;2D
    action: backward-word
    comment: Maj + <-

# Install Atom packages mentioned in dotfiles (apm)
dotfiles_install_atom_packages: True

# Install tmux packages mentioned in dotfiles (tpm)
dotfiles_install_tmux_packages: True

# Install Vim packages mentioned in dotfiles (vim-plug)
dotfiles_install_vim_packages: True

# Iterm settings directory as defined in iTerm2
dotfiles_iterm_settings_directory: ~/.config/iterm2
```

## `os-setup` role – roles/os-setup/defaults/main.yml

```yml
# The default cross-platform list of packages to install
common_packages:
  - bash # Updating default macOS bash
  - ffmpeg # Video and GIFs modifications and conversions
  - python # Updating macOS default python
  - git # No comments needed
  - git-flow # Git extensions to enforce a better branching model
  - tig # Git repos browser
  - ghostscript # Postscript and PDF tools
  - graphicsmagick # Images transformations and conversions
  - pwgen # Password generation from the command line
  - htop # Top replacement
  - tree # To list files and dirs as a tree
  - tmux # Terminal multiplexer
  - nmap # Network scan
  - httpie # HTTP requests made easy
  - direnv # Per directory ENV vars
  - vim # An up-to-date vim version
  - jq # JSON manipulation

# The default cross-platform list of apps to install
common_apps:
  - virtualbox # Virtualisation
  - vagrant # VM per projects
  - firefox # Alternative browser

# An array of Golang packages to get
go_get:
  - github.com/ddollar/forego # Foreman in Go
  - github.com/cortesi/devd/cmd/devd # Local webserver for developers

# Defines the place to store manually downloaded binaries
default_binary_dest: '/usr/local/bin'

##################
# macOS specific #
##################

# Key-values translations to be used elsewhere (for example in the Dock setup)
darwin_i18n:
  calendar: Calendrier

# An array of string of system languages
darwin_languages:
  - fr
  - en

# The system locale
darwin_locale: fr_FR@currency=EUR

# macOS specific packages
brew_packages:
  - md5sha1sum # More checksum tools
  - coreutils # for things like realpath…
  - rclone # Cloud sync à-la rsync
  - caddy # Webserver/Reverse-Proxy/more…
  - fdupes # Duplicates file finder
  - watch # GNU watch command
  - ag # Grep replacement
  - fzf # Command line fuzzy finder
  - diff-so-fancy # Differ
  - ssh-copy-id # Copy ssh keys to remote hosts
  - dockutil # Dock management from the command line
  - syncthing # Secure files sync

# macOS specific apps
brew_cask_apps:
  - google-chrome # Default browser
  - appcleaner # For easy apps cleanup
  - iterm2 # Default terminal emulator
  - atom # Default code editor
  - launchbar # Spotlight replacement
  - keepassxc # Password manager
  - gpg-suite # GPG made easy (+ Mail.app extension)
  - slack # For team communications
  - spotify # Music ease the mind
  - lunchy # Launchctl wrapper
  - spectacle # Window manager
  - ngrok # Secure(?) tunneling
  - postman # HTTP requesting interface
  - fluid # Dedicated Mac app per website
  - typora # Useful markdown editor
  - dash # Docs and snippets

# An array of string of items to remove from the Dock
darwin_removed_dock_items:
  - Launchpad
  - Safari
  - Contacts
  - Notes
  - Reminders
  - Maps
  - Photos
  - Messages
  - FaceTime
  - iTunes
  - iBooks
  - App Store
  - System Preferences

# An array of hashes{name, path, position} of positionned items to add to the dock
darwin_added_dock_items:
  - name: Mail
    path: /Applications/Mail.app
    position: 1
  - name: "{{ darwin_i18n['calendar'] }}"
    path: /Applications/Calendar.app
    position: 2
  - name: iTerm
    path: "/Applications/iTerm.app"
    position: 3
  - name: Google Chrome
    path: "/Applications/Google Chrome.app"
    position: 4
  - name: Spotify
    path: /Applications/Spotify.app
    position: 5
  - name: KeePassXC
    path: /Applications/KeePassXC.app
    position: 6
  - name: Atom
    path: /Applications/Atom.app
    position: 7
  - name: Slack
    path: /Applications/Slack.app
    position: 8

# The Dock icons size
darwin_dock_icons_size: 36.0

# darwin_zipped_binaries will use the first file matching app.binary_name or app.name.
# You can use a wilcard to match a custom filename like 'binary_v*'.
#
# You may also set the `recurse` option to true in order to find the binary
# in a subfolder.
#
# ⚠️  A wrong binary_name or filename may result in a incorrect file being copied
# to `binary_dest`
darwin_zipped_binaries: [] # Default is none. This will be overrided on a per-OS basis

# Launchbar – Plist domain
launchbar_plist_domain: at.obdev.LaunchBar

# Launchbar – Configuration Plist
launchbar_configuration_file: ~/Library/Application Support/LaunchBar/Configuration.plist

# Launchbar – Where to store actions
launchbar_actions_directory: ~/Library/Application Support/LaunchBar/Actions

# Launchbar – What actions to GET and install
launchbar_actions:
  - filename: 'Spotify - Play:Pause.lbaction'
    url: https://github.com/mlinzner/LaunchBarActions/blob/master/actions/Control%20Spotify/packages/Spotify%20-%20Play:Pause.lbaction?raw=true
    checksum: 'sha256:a08d1bb667c6cec1089ac7dfd853c2a376e3d5269a8ad5e380cafe85526cb141'
  - filename: 'Spotify - Next Song.lbaction'
    url: https://github.com/mlinzner/LaunchBarActions/blob/master/actions/Control%20Spotify/packages/Spotify%20-%20Next%20Song.lbaction?raw=true
    checksum: 'sha256:e6e2ee949eafed06ea93baf58cdc36af8e84258fb01f6562b15f706cc1bd8c1a'
  - filename: 'Spotify - Previous Song.lbaction'
    url: https://github.com/mlinzner/LaunchBarActions/blob/master/actions/Control%20Spotify/packages/Spotify%20-%20Previous%20Song.lbaction?raw=true
    checksum: 'sha256:f4f3698b1bda0d40e893d00afb972248b20fa143a02cce91213325f068703d62'
  - filename: 'Caffeinate.lbaction'
    url: https://s3.amazonaws.com/renaghan/lbdist/Caffeinate.lbaction
    checksum: 'sha256:0c71985eb6189fd021851718417064dcbe9ba14e9762194894583aeea95b3224'

###################
# Debian specific #
###################

# APT-specific packages
aptitude_packages:
  - silversearcher-ag
  - gnupg2
  - zsh
  - python-setuptools
  - fdupes # Duplicates file finder
  - unzip

# APT-specific apps
aptitude_apps:
  - default-jre
  - chromium-browser
  - keepassx
  - terminator
  - synaptic

# A list of custom install task to load for Debian
# Each one of these apps as a dedicated yml file with tasks to install it
debian_custom_apps:
  - atom
  - diff-so-fancy
  - fzf
  - postman
  - spotify

# debian_zipped_binaries will use the first file matching app.binary_name or app.name.
# You can use a wilcard to match a custom filename like 'binary_v*'.
#
# You may also set the `recurse` option to true in order to find the binary
# in a subfolder.
#
# ⚠️  A wrong binary_name or filename may result in a incorrect file being copied
# to `binary_dest`
debian_zipped_binaries:
  - name: rclone
    url: https://downloads.rclone.org/rclone-current-linux-amd64.zip
    recurse: true
  - name: caddy
    url: https://caddyserver.com/download/linux/amd64?license=personal
  - name: ngrok
    url: https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
```

## `projects` role – roles/projects/defaults/main.yml

```yml
# Projects root is the directory where project will be cloned
projects_root: ~/src

# SSH keys to use to clone some projects
# Example:
# projects_ssh_keys:
#    my-key: ~/.ssh/id_mykey
projects_ssh_keys: {}

# A list of projects to clone
# Example:
# projects_list:
#   - repo: 'https://github.com/ansible/hello-world.git'
#     name: 'ansible'
#     parent_directory: 'Python'
#     with_direnv: True
#     docker_machine_name: ansible # use docker-machine ansible
#     docker_compose_app: ansible # export DKC_SERVICE=ansible
#     direnv_exports:
#       DEFAULT_BRANCH: devel
#   - repo: 'https://github.com/codeunion/dotenv-example'
#     name: 'fake'
#     setup_env: True # copy
#     env_file: env.example
#     ssh_key: my-key
projects_list: []

# The default env template file used by your projects (instead of setting a env_file per project)
projects_default_env_tpl: env.tpl
```

