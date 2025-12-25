#!/bin/bash

cd $HOME

sudo pacman -S unzip

curl https://github.com/topchiyev/nightarch/archive/refs/heads/main.zip -o /tmp/nightarch.zip

unzip /tmp/nightarch.zip -d $HOME/nightarch

bash $HOME/nightarch/install.sh
