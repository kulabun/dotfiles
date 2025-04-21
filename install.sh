#!/usr/bin/env bash
if [[ -n "$CODESPACES" || -n "$DEVPOD" ]]
then
  . ./scripts/codespaces_install.sh
else
  . ./scripts/macos_install.sh
fi
