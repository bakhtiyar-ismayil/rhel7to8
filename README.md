
# RHEL 7 to 8 Upgrade Scripts

This repository contains two bash scripts designed to facilitate the upgrade process from Red Hat Enterprise Linux (RHEL) 7 to RHEL 8. The upgrade process is divided into two stages: actions until the first reboot and actions after the reboot.

## Scripts

1. **`rhel_upgrade_step1.sh`**: This script performs actions leading up to the first reboot.
2. **`rhel_upgrade_step2.sh`**: This script performs actions after the system reboots.

## Prerequisites

- Ensure you have a backup of your important data.
- Have root or sudo access to the system.
- Ensure that your system is registered with the Red Hat subscription-manager.

## Usage

### Step 1: Run the First Script

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/bakhtiyar-ismayil/rhel7to8.git
   cd rhel7to8
   ```

2. Make the first script executable:

   ```bash
   chmod +x rhel_upgrade_step1.sh
   ```

3. Run the first script:

   ```bash
   sudo ./rhel_upgrade_step1.sh
   ```

   This script will:
   - Check the subscription-manager status.
   - Unset any release locks.
   - Install the `leapp-upgrade` tool.
   - Update the system.
   - Reboot the system.

### Step 2: Run the Second Script

1. After the system has rebooted, log in again.

2. Make the second script executable:

   ```bash
   chmod +x rhel_upgrade_step2.sh
   ```

3. Run the second script:

   ```bash
   sudo ./rhel_upgrade_step2.sh
   ```

   This script will:
   - Show the current subscription-manager release.
   - Extract the leapp data.
   - Modify the `repomap.json` file.
   - Remove deprecated drivers.
   - Update the leapp answer file for auto-confirmation.
   - Run the pre-upgrade and upgrade commands.
   - Reboot the system after the upgrade.

## Important Notes

- Ensure you monitor the output of both scripts for any errors.
- Review the Red Hat documentation on upgrading for additional information and considerations.

