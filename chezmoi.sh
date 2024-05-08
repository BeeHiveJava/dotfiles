#!/bin/sh

set -eu

if [ ! "$(command -v chezmoi)" ]; then
  bin_dir="$HOME/.local/bin"
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$bin_dir"
  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -qO- https://git.io/chezmoi)" -- -b "$bin_dir"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
fi

script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
set -- init --apply --source="${script_dir}"

echo "Running 'chezmoi $*'" >&2
exec "chezmoi" "$@"
