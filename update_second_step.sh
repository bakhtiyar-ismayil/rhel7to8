
#!/bin/bash

# Function to check the exit status of the last executed command
check_status() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed."
        exit 1
    fi
}

# Show the subscription-manager release version
echo "Showing current subscription-manager release..."
subscription-manager release --show

# Download file from Github 
wget https://github.com/bakhtiyar-ismayil/rhel7to8/blob/main/leapp-data-22.tar.gz

# Extract leapp data
echo "Extracting leapp data from leapp-data-22.tar.gz..."
tar -xzf leapp-data-22.tar.gz -C /etc/leapp/files
check_status "Leapp Data Extraction"

# Modify the repomap.json file to change RHUI from Google to AWS
echo "Modifying repomap.json to change RHUI from Google to AWS..."
grep '"rhui":' /etc/leapp/files/repomap.json  | sort -u
sed -i 's/"rhui": "google"/"rhui": "aws"/g' /etc/leapp/files/repomap.json
check_status "RHUI Update"

# Remove deprecated drivers
echo "Removing floppy and pata_acpi kernel modules..."
modprobe -r floppy
modprobe -r pata_acpi
check_status "Driver Removal"

# Verify if drivers are removed
echo "Checking if drivers are still loaded..."
lsmod | grep -E 'floppy|pata_acpi'

# Modify the leapp answer file to auto-confirm
echo "Setting confirm = True in leapp answer file..."
sed -i 's/^#confirm = False/confirm = True/' /var/log/leapp/answerfile
check_status "Leapp Answer File Update"

# Run leapp pre-upgrade and upgrade
echo "Running leapp preupgrade..."
leapp preupgrade --target=8.4
check_status "Leapp Preupgrade"

echo "Running leapp upgrade..."
leapp upgrade --target=8.4
check_status "Leapp Upgrade"

# Reboot after the upgrade
echo "Rebooting the system after upgrade..."
reboot

