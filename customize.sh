#!/usr/bin/env bash
# shellcheck disable=SC2054

set -e

# Source and target files
SOURCE_FILE="$1"
TARGET_FILE="${SOURCE_FILE/genericcloud/$2}"

declare -A packages
packages=(
    [qemu]=qemu-guest-agent
    [locales]=qemu-guest-agent,locales-all
    [extras]=qemu-guest-agent,locales-all,htop
)

# Install packages
sudo virt-customize -a "$SOURCE_FILE" \
    --install "${packages[$2]}" \
    --run-command "apt-get clean"

# Export ARTIFACT_NAME variable to github workflow
echo "ARTIFACT_NAME=$TARGET_FILE" >> "$GITHUB_ENV"
