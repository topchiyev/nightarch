#!/bin/bash

if [[ ! -d $HOME/.config ]]; then
  mkdir -p $HOME/.config
fi

cp -r $ROOT_DIR/config/* $HOME/.config/
