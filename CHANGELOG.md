# Changelog

## Releases

### Unreleased

- Add dev fonts installation (Fira Code, Roboto…)
- Use latest go version on Debian
- Support syncthing installation for Debian
- Add parallel, jpegoptim and optipng packages
- Ignore `todo.md` file in Git repos
- Ignore some Ruby gem files in Git repos

### v1.2.0 - 2018/05/01

- Fixing bug preventing devlog search
- Preventing devlog alias conflict
- Adding an option to skip restic init process
- Removing restic tap as it is not required anymore
- Allowing custom env vars for backup (_like AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY_)
- Installing Dash.app on macOS
- Ignoring vscode directory for git
- Better stat command on macOS

### v1.1.0 - 2018/02/18

- Updating Devlog to v1.1.0
  - New shell syntax: one entrypoint for all commands, devlog
  - Supporting quick notes
  - Improved devlog post creation
  - Improved devlog serving
- Adding less to git diff in addition to diff-so-fancy
- Adding syncthing for macos
- Adding small ssh-config reader script
- Adding vscode workspace files to gitignore
- Supporting custom devlog directory

### v1.0.0 - 2017/12/03

- Updating dockutil shell behaviour and fixing order command
- Not registering anything and improving skip for apm
- Quicker and idempotent process check for macOS docker
- We're not constraining a variable storage
- All vars are now overridable
  - Available variables are documented in variables.md
- Optimising zipped-binary task:
  - temp dir creation only if required
  - check mode in parent
- macOS restarter are now handlers

### v1.0.0-beta.6 - 2017/11/26

- Fixing solarized handling for vim
- Replacing MacPass by KeepassXC
- Updating caffeinate hash
- Moving roles tags to roles and keeping others on a per-task basis
- Including git dirs in backups
- Showing project name when cloning
- Handling checkmode in docker tasks
- Insuring playbook idempotence by detecting changes
- Fixing linting alerts

### v1.0.0-beta.5 - 2017/10/29

- Adding missing jq binary and installing KeepassXC on darwin
- Checking that Docker daemon is running before pulling Docker images
- Launchbar indexing customization was failing on a fresh install
- Creating launchbar actions directory if it does not exists
- Adding debug msg for docker pull bug on first run
- Allowing playbook to be played on Debian too
- Preventing failure in check mode
- Fixing newline problem in zsh aliases
- Removing invalid `cache_valid_time` for ppa add
- Removing xcode --install check in favor of the one done by brew
- Adding synaptic for Ubuntu
- Adding missing dockutil for macOS
- Fixing fzf blocking install
- Muting 2.4.0 deprecation warnings for now
- Updating vim on both macOS and Ubuntu
- Adding an unmodified ~/.extra file in zsh config
- Fixing Tmux config for Ubuntu

### v1.0.0-beta.4 - 2017/09/24

- Some bugfixes
- Small iTerm2 preferences update
- Manually installing restic, Postman, Spotify, Atom and others on Ubuntu, thus
  guaranteeing symmetry with macOS
- Fixing Gopath in zshrc and introducing Golang and go-get

### v1.0.0-beta.3 - 2017/09/17

- Ubuntu testing and bug fixes
- Launchbar configuration updates and actions installation
- Aria2 configuration dotfile
- Custom destination file support for dotfiles
- Custom bindkey support for zshrc

### v1.0.0-beta.2 - 2017/09/14

- Adding missing become option for apt commands

### v1.0.0-beta.1 - 2017/09/10

- Initial public beta release
- Adding LICENCE file
- Adding CHANGELOG.md
