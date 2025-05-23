# Create Sudo User & Disable Root Login Script

This shell script automates the creation of a new Linux user, adds them to the `sudo` group, and disables root login via SSH for improved system security.

## Features

- Interactive prompt for creating a new user
- Password verification
- Adds the user to the `sudo` group
- Disables SSH login for the `root` user
- Automatically restarts the SSH service

## Usage

### 1. Make the script executable

```bash
chmod +x create_sudo_user.sh
```

### 2. Run the script as root

```bash
sudo ./create_sudo_user.sh
```

You will be prompted to enter:
- A new username
- A password (entered twice for confirmation)

The script will:
- Create the user
- Add them to the `sudo` group
- Disable SSH root login
- Restart the SSH service

## Important Notes

- Make sure you have another way to access the server before disabling root login.
- This script is intended for Debian-based systems (e.g., Ubuntu). You may need to modify it for other distributions.

## License

This project is open-source and available under the [MIT License](LICENSE).
