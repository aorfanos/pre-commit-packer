#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

if [ -z "$(command -v packer)" ]; then
  echo "packer is required"
  exit 1
fi

error=0

for file in "$@"; do
  if ! packer fmt -check "$file"; then
    error=1
    echo
    echo "Failed path: $file"
    echo "================================"
    echo "Apply format: $file"
    if ! packer fmt "$file"; then
      error=1
      echo "Apply format failed: $file"
    else
      error=0
      echo "Apply format ok: $file"
    fi
  fi
done

if [[ $error -ne 0 ]]; then
  exit 1
fi
