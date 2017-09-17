---

# This file is an example of some required and existing variables

###########
# OSSetup #
###########

# Other available vars:
# - common_packages | The default cross-platform list of packages to install
# - common_apps | The default cross-platform list of apps to install

# Other available vars - macOS specific:
# - osx_i18n | key-values translations to be used elsewhere (for example in the Dock setup)
# - osx_languages | An array of string of system languages
# - osx_locale | The system locale (default: fr_FR@currency=EUR)
# - brew_packages | macOS specific packages
# - brew_cask_apps | macOS specific apps
# - removed_dock_items | An array of string of items to remove from the Dock
# - added_dock_items | An array of hashes{name, path, position} of positionned items to add to the dock
# - dock_icons_size | The Dock icons size

# Other available vars - Ubuntu specific:
# - aptitude_packages | APT-specific packages
# - aptitude_apps | APT-specific apps

############
# Dotfiles #
############

dotfiles_user_name: John Doe
dotfiles_user_email: john@doe.com

# Other available vars:
# - dotfiles_devlog_enabled | Enable a developpment log for day-to-day notes
# - dotfiles_default_editor | Sets the $EDITOR
# - dotfiles_default_pager | Sets the $PAGER
# - dotfiles_go_path | Sets the $GOPATH
# - dotfiles_git_pager | Sets the pager used by git
# - dotfiles_git_editor | Sets the editor used by git
# - dotfiles_zsh_plugins | Lists enabled Oh-my-zsh plugins
# - dotfiles_files | List the dotfiles to sync as
    {name: 'template-name', destination: 'optional-destination'}
    where 'optional-destination' is a destination different
    than ~/.template-name (see roles/dotfiles/templates/src for details)
# - dotfiles_sync_force | Disabled by default. Will override any changes to the system dotfiles
# - dotfiles_apm_packages | A list of Atom packages to install
# - dotfiles_with_neovim | Enabled by default. Will use neovim system-wide instead of vim
# - dotfiles_iterm_settings_directory | Stores the iTerm configuration in a syncable directory
# - dotfiles_zsh_additional_plugins | Other Oh-my-zsh plugins, to be merged with dotfiles_zsh_plugins

##########
# Docker #
##########

# Images are pulled from Docker Hub or any public Docker registry
docker_images_to_pull:
  - alpine

##########
# Backup #
##########

# `backup_repository` is a directory or a remote host
# see https://restic.readthedocs.io/en/stable/manual.html#initialize-a-repository
backup_repository: my-restic-repository

backup_password: "{{ vault_backup_password }}" # Using an ansible-vault file saved as in host_vars/localhost/vault

backup_cleanup: True # allow olds backups cleanup based on `backup_cleanup_settings`
backup_cleanup_settings:
  keep_daily: 7
  keep_weekly: 4
  keep_monthly: 6
backup_allow_prune: True

backup_with_cron: True
backup_cron:
  hour: "22"
  minute: "30"

backup_additional_exclusions:
  - $HOME/go

# Other available vars:
# - backup_scripts_directory | Where the backup scripts are saved

############
# Projects #
############

projects_root: ~/projects

projects_ssh_keys:
  key1: ~/.ssh/my-private-key

projects_list:
  - repo: 'https://github.com/ansible/ansible.git'
    name: 'ansible'
    ssh_key: 'key1'
    parent_directory: 'Python'
    with_direnv: True
    docker_machine_name: ansible # use docker-machine ansible
    docker_compose_app: ansible # export DKC_SERVICE=ansible
    direnv_exports:
      DEFAULT_BRANCH: devel
  - repo: 'https://github.com/fake/fake.git'
    name: 'fake'
    setup_env: True # copy
    env_file: env.tpl

# Other available vars:
# - projects_default_env_tpl | The default env template file used by your projects (instead of setting a env_file per project)
