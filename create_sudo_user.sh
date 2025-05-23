#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root"
  exit 1
fi

# Prompt for username
read -p "Enter new username: " username

# Check if the user already exists
if id "$username" &>/dev/null; then
  echo "❌ User '$username' already exists."
  exit 1
fi

# Prompt for password (silent input)
read -s -p "Enter password for $username: " password
echo
read -s -p "Confirm password: " password2
echo

# Check if passwords match
if [ "$password" != "$password2" ]; then
  echo "❌ Passwords do not match."
  exit 1
fi

# Create user and set password
useradd -m "$username" -s /bin/bash
echo "$username:$password" | chpasswd

# Add user to sudo group
usermod -aG sudo "$username"
echo "✅ User '$username' created and added to sudo group."

# Disable root login via SSH
sshd_config="/etc/ssh/sshd_config"
if grep -q "^PermitRootLogin" "$sshd_config"; then
  sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' "$sshd_config"
else
  echo "PermitRootLogin no" >> "$sshd_config"
fi

# Restart SSH service
if systemctl is-active --quiet ssh; then
  systemctl restart ssh
elif systemctl is-active --quiet sshd; then
  systemctl restart sshd
else
  echo "⚠️ Could not detect SSH service to restart. Please restart SSH manually."
fi

echo "🔒 Root login has been disabled via SSH."
