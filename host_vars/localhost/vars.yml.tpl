---

# This file is an example of some required and existing variables

dotfiles_user_name: John Doe
dotfiles_user_email: john@doe.com

docker_images_to_pull:
  - alpine

# `backup_repository` is a directory or a remote host, see https://restic.readthedocs.io/en/stable/manual.html#initialize-a-repository
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