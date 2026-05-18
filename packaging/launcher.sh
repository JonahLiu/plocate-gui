#!/bin/bash
# Launcher for plocate-gui
# This script wraps the Python module with proper environment setup.
exec /usr/bin/python3 /usr/share/plocate-gui/plocate-gui.py "$@"
