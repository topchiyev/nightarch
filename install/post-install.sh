#!/bin/bash
set -euo pipefail

echo '--- Started post-install tasks ---'
trap 'status=$?; if [ $status -eq 0 ]; then
        echo "--- Finished post-install tasks ---"
      else
        echo "--- Failed post-install tasks ---"
      fi' EXIT

# If NetworkManager was removed, enable the built‑in systemd networking stack
if ! pacman -Qi networkmanager >/dev/null 2>&1; then
  # Optional: create a generic DHCP config for wired interfaces if none exist
  if [ ! -f /etc/systemd/network/20-wired.network ]; then
    sudo mkdir -p /etc/systemd/network
    sudo tee /etc/systemd/network/20-wired.network >/dev/null <<'EOF'
[Match]
Name=en* eth*

[Network]
DHCP=yes
EOF
  fi

  # Bring up systemd-networkd and systemd-resolved immediately and on boot
  sudo systemctl enable --now systemd-networkd
  sudo systemctl enable --now systemd-resolved
fi
if [ ! -f "/etc/systemd/system/getty@tty1.service.d/autologin.conf" ]; then
  sudo mkdir -p "/etc/systemd/system/getty@tty1.service.d"
  sudo tee /etc/systemd/system/getty@tty1.service.d/autologin.conf >/dev/null <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --noreset --noclear --autologin $USER %I \$TERM
EOF

fi
