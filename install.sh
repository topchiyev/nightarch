#!/bin/bash

chmod +x install/*.sh

bash install/install-yay.sh
bash install/install-pacman-packages.sh
bash install/install-aur-packages.sh
