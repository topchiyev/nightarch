#!/bin/bash

if [[ ! -d $HOME/.local/share/applications ]]; then
  mkdir -p $HOME/.local/share/applications
fi

cp -r $ROOT_DIR/applications/* $HOME/.local/share/applications/
