#!/bin/bash

if [[ ! -d $HOME/.local/share/bin ]]; then
  mkdir -p $HOME/.local/share/bin
fi

cp -r $ROOT_DIR/bin/* $HOME/.local/share/bin/

chmod +x $HOME/.local/share/bin/*.sh
