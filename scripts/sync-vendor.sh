#!/usr/bin/env bash
# Keep the read-only Paperclip clone in vendor/paperclip on the pinned release tag.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
tag="v$(tr -d '[:space:]' < "$root/paperclip.version")"
dir="$root/vendor/paperclip"

if [ ! -d "$dir/.git" ]; then
  git clone https://github.com/paperclipai/paperclip.git "$dir"
fi
if [ -n "$(git -C "$dir" status --porcelain)" ]; then
  echo "vendor/paperclip has local changes; it is read-only, discard them first" >&2
  exit 1
fi
git -C "$dir" fetch --tags --quiet origin
git -C "$dir" -c advice.detachedHead=false checkout --quiet "$tag"
echo "vendor/paperclip at $tag ($(git -C "$dir" rev-parse --short HEAD))"
