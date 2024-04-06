#!/bin/bash

# Set environment variables to disable hardware acceleration in Wayland for the current session
export EGL_PLATFORM=null
export CLUTTER_BACKEND=wayland

echo "Hardware acceleration in Wayland has been disabled for the current session."
