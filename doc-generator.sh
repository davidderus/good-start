#!/bin/bash

# Helps generate the variables.md file

set -e

echo "# Variables

What follows is a listing of all the overridable vars of good-start with their default values.
Feel free to override any of them in your host_vars."

echo

for filename in roles/*/defaults/main.yml; do
  rolename=$(echo $filename | cut -d '/' -f 2)

  echo "## \`$rolename\` role – $filename"
  echo

  echo '```yml'
  cat $filename | tail -n +3
  echo '```'

  echo
done
