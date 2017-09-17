# good-start 1.0.0-beta.2

Advanced developer setup for macOS and Ubuntu.

## Disclaimer

**⚠️ This is a beta, meaning that this project is not fully tested yet.**

## Quick start

```shell
# Setup ansible and other requirements
./ansible-install.sh

# Copy the vars template
cp host_vars/localhost/vars.yml.tpl host_vars/localhost/vars.yml

# Edit the vars to match your requirements
vim host_vars/localhost/vars.yml

# (OPTIONNAL) Run in dry-run mode with diff (it will not change anything)
ansible-playbook --check --diff playbook.yml

# Run the playbook
ansible-playbook playbook.yml # without ansible-vault
ansible-playbook playbook.yml --ask-vault-pass # with ansible-vault
ansible-playbook playbook.yml --ask-vault-pass --tags "dotfiles,projects" # just for some tags
```

## Requirements

This playbook requires [ansible](https://github.com/ansible/ansible),
aptitude for Ubuntu or [brew](https://brew.sh/index_fr.html) and
[brew-cask](https://caskroom.github.io/) for macOS.

You may use `./ansible-install.sh` to set everything up or install each package
manually.

## Configuration

All roles configuration files (*clear text or encrypted via `ansible-vault`*)
must be stored in `host_vars/localhost`.

As shown in the quick start, you may use the `host_vars/localhost/vars.yml.tpl`
file to discover the available variables.

You may modify the `playbook.yml` file to disable some roles or use
the `--tags` arg*.

It may be a good idea to backup or version the `host_vars/localhost` directory
in a secure location if you want to reproduce your setup.

Using `ansible-vault` to [encrypt your sensible infos](http://docs.ansible.com/ansible/latest/playbooks_best_practices.html#best-practices-for-variables-and-vaults) may be a good idea on a shared computer or if the directory is
synced on an insecure drive.

## Features

This playbook includes the following roles:

### os-setup role

*Tags: `os-setup`*

> Makes your OS a pleasant environment to work with

- Install binaries and apps (*tags: `apps`*)
- Update OS settings to match the user preferences
  (*Only for macOS | tags: `settings`*)
- Customize the Dock content (*macOS only | tags: `settings`*)
- Oh-My-Zsh setup (*tags: `apps,zsh`*)
- Launchbar configuration updates and actions installation (*tags: `launchbar`*)

### dotfiles role

*Tags: `dotfiles`*

> Customizes your apps for a better productivity.

- Dotfiles generation for:
    - Ansible
    - Direnv
    - Git
    - Screen
    - The Silver Searcher
    - Tmux
    - Vim
    - Zsh
    - Aria2
- SSH key generation (*only if none found*)
- Vim/Neovim packages installation
- Tmux packages installation
- Atom packages installation
- Neovim setup (*tags: `neovim`*)
- Iterm2 setup with custom config and theming (*macOS only | tags: `iterm`*)
- Terminator setup with custom config (*Ubuntu only | tags: `terminator`*)

### docker role

*Tags: `docker`*

> A fully dockerized workflow is just a step ahead.

- Docker installation (*alongside with docker-compose and docker-machine*)
- Docker images pull from Docker Hub

### projects role

*Tags: `projects`*

> Your projets are there too!

- Clone the project (*with an optionnal custom private ssh key*)
- Setup `.env` file if a declared template exists
- Setup direnv .envrc file with:
  - Custom exports
  - docker-machine support (**requires the `dotfiles` role**)
  - docker-compose shortcuts (**requires the `dotfiles` role**)

### backup role

*Tags: `backup`*

> Enables automated restic backups on your computer.

- Install [restic](https://github.com/restic/restic)
- Generate a backup script and an exclusions file
- Initialize a restic repository for $HOME backup
- Schedule the backup with cron

## Licence

MIT Licence. Click [here](LICENCE) to see the full text.
