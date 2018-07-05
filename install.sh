#!/bin/sh

majorversion=$(gedit --version | sed -n 's/gedit.*\s\([0-9]\).*/\1/p')
minorversion=$(gedit --version | sed -n 's/gedit.*\s[0-9]\.\([0-9]*\).*/\1/p')
installfiles="editorconfig_plugin/"
editorconfigcore="editorconfig-core-py/"

localinstalldir=~/.local/share/gedit/plugins
rootinstalldir=/usr/lib/gedit/plugins
installfiles="$installfiles $editorconfigcore editorconfig_gedit3.py editorconfig.plugin"

if [ "$majorversion" -lt "3" ] ; then
    localinstalldir=~/.gnome2/gedit/plugins
    rootinstalldir=/usr/lib/gedit-2/plugins
    installfiles="$installfiles $editorconfigcore editorconfig_gedit2.py editorconfig.gedit-plugin"
fi

installdir=$localinstalldir

if [ "$(id -u)" -eq "0" ] ; then
    installdir=$rootinstalldir
fi

echo "Copying $installfiles to $installdir..."
mkdir -p $installdir &&
cp -rfL $installfiles $installdir &&
echo "Done."

if [ "$majorversion" -eq "3" -a "$minorversion" -lt "8" ] ; then
    echo "Patching $installdir/editorconfig.plugin for Python 2 support..."
    sed -i 's/python3/python/' "$installdir/editorconfig.plugin" &&
    echo "Done."
fi
