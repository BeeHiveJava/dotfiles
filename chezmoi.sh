#!/bin/sh

echo "Starting dotfiles installation..."

if [ ! "$(command -v chezmoi)" ]; then
  echo "chezmoi not found, installing..."
  bin_dir="/tmp"
  chezmoi="$bin_dir/chezmoi"
  if [ "$(command -v curl)" ]; then
    echo "Using curl to download chezmoi installer..."
    if ! sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$bin_dir"; then
      echo "Error: Failed to install chezmoi using curl" >&2
      echo "Check your internet connection and try again" >&2
      exit 1
    fi
    echo "chezmoi installed successfully to $bin_dir"
  elif [ "$(command -v wget)" ]; then
    echo "Using wget to download chezmoi installer..."
    if ! sh -c "$(wget -qO- https://git.io/chezmoi)" -- -b "$bin_dir"; then
      echo "Error: Failed to install chezmoi using wget" >&2
      echo "Check your internet connection and try again" >&2
      exit 1
    fi
    echo "chezmoi installed successfully to $bin_dir"
  else
    echo "Error: To install chezmoi, you must have curl or wget installed." >&2
    echo "Please install curl or wget and try again." >&2
    exit 1
  fi
else
  echo "chezmoi found in PATH, using existing installation"
  chezmoi=chezmoi
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
echo "Source directory: $script_dir"
echo "Initializing chezmoi with source directory and applying configuration..."

# exec: replace current process with chezmoi init
if ! exec "$chezmoi" init --apply --source="$script_dir"; then
  echo "Error: chezmoi init failed" >&2
  echo "Check the source directory and chezmoi configuration" >&2
  exit 1
fi
