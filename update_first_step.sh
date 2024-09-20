
#!/bin/bash

# Function to check the exit status of the last executed command
check_status() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed."
        exit 1
    fi
}

# Check the subscription-manager status
echo "Checking subscription-manager status..."
subscription-manager status
check_status "Subscription Manager Status Check"

# Unset any release lock
echo "Unsetting subscription-manager release..."
subscription-manager release --unset
check_status "Release Unset"

# Download file from Github

# Install leapp upgrade and update system
echo "Installing leapp-upgrade and updating the system..."
yum install leapp-upgrade -y
check_status "Leapp Installation"

yum update -y
check_status "System Update"

# Reboot the system to apply updates
echo "Rebooting the system..."
reboot

