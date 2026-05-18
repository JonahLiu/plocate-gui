#!/bin/bash
# Build a minimal .deb package for plocate-gui
# Usage: bash packaging/build.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$SCRIPT_DIR"

VERSION="0.2.0"
PACKAGE="plocate-gui"
BUILD_DIR="/tmp/${PACKAGE}-build"
DEB_FILE="${PACKAGE}_${VERSION}_all.deb"

echo "==> Cleaning build dir..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR/DEBIAN"
mkdir -p "$BUILD_DIR/usr/bin"
mkdir -p "$BUILD_DIR/usr/share/applications"
mkdir -p "$BUILD_DIR/usr/share/doc/${PACKAGE}"

mkdir -p "$BUILD_DIR/usr/share/${PACKAGE}"
mkdir -p "$BUILD_DIR/usr/share/icons/hicolor/scalable/apps"

echo "==> Installing files..."
# Main executable
install -m 755 packaging/launcher.sh "$BUILD_DIR/usr/bin/plocate-gui"
# Python source
install -m 644 plocate-gui.py "$BUILD_DIR/usr/share/${PACKAGE}/"
# Desktop entry
install -m 644 resources/plocate-gui.desktop "$BUILD_DIR/usr/share/applications/"
# Application icon
install -m 644 resources/plocate-gui.svg "$BUILD_DIR/usr/share/icons/hicolor/scalable/apps/"
# Documentation
install -m 644 README.md "$BUILD_DIR/usr/share/doc/${PACKAGE}/"
install -m 644 LICENSE "$BUILD_DIR/usr/share/doc/${PACKAGE}/copyright" 2>/dev/null || true

# DEBIAN control
install -m 644 packaging/DEBIAN/control "$BUILD_DIR/DEBIAN/"

echo "==> Building ${DEB_FILE}..."
dpkg-deb --build --root-owner-group "$BUILD_DIR" "$DEB_FILE"

echo "==> Done: ${DEB_FILE}"
ls -lh "$DEB_FILE"
