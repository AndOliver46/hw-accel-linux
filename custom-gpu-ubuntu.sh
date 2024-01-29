#!/bin/bash

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root using sudo."
    echo "Press Enter to exit..."
    read
    exit 1
fi

# Set the path to the custom.conf file
custom_conf="/etc/gdm3/custom.conf"
# Set the path to the 10-nvidia.conf file
nvidia_conf="/etc/X11/xorg.conf.d/10-nvidia.conf"
# Set the path to the 20-intel.conf file
intel_conf="/etc/X11/xorg.conf.d/20-intel.conf"

# Check if the custom.conf file exists
if [ -f "$custom_conf" ]; then
    # Uncomment the WaylandEnable line and set it to false
    sed -i 's/#WaylandEnable=false/WaylandEnable=false/' "$custom_conf"
    echo "Wayland disabled in $custom_conf"
else
    echo "Error: $custom_conf not found."
fi

# Create 10-nvidia.conf file with specified content
echo -e 'Section "ServerLayout"\n    Identifier "layout"\n    Screen  "ScreenU"\nEndSection\n\nSection "Device"\n    Identifier "nvidia"\n    Driver "nvidia"\nEndSection\n\nSection "Screen"\n    Identifier "ScreenU"\nEndSection' | sudo tee "$nvidia_conf" > /dev/null

echo "Created $nvidia_conf with the specified content."

# Create 20-intel.conf file with specified content
echo -e 'Section "Device"\n    Identifier "intel"\n    Driver "modesetting"\n    BusID "PCI:0:2:0"\n    Option "NoAccel" "True"\n    Option "DRI" "False"\nEndSection' | sudo tee "$intel_conf" > /dev/null

echo "Created $intel_conf with the specified content."

echo "Press Enter to close the terminal..."
read
exit 1

