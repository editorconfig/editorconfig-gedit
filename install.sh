#!/bin/sh

geditversion=$(gedit --version | sed -n 's/gedit.*\s\([0-9]\).*/\1/p')
installfiles="editorconfig_plugin/"

if [ "$geditversion" -eq "3" ] ; then
    localinstalldir=~/.local/share/gedit/plugins
    rootinstalldir=/usr/lib/gedit/plugins
    installfiles="$installfiles editorconfig_gedit3.py editorconfig.plugin"
else
    localinstalldir=~/.gnome2/gedit/plugins
    rootinstalldir=/usr/lib/gedit-2/plugins
    installfiles="$installfiles editorconfig_gedit2.py editorconfig.gedit-plugin"
fi

if [ "$(id -u)" -ne "0" ] ; then
    installdir=$localinstalldir
else
    installdir=$rootinstalldir
fi

echo "Copying $installfiles to $installdir..."
mkdir -p $installdir &&
cp -rfL $installfiles $installdir &&
echo "Done."
echo ""
echo "Installing EditorConfig Python Core..."
cd editorconfig-core-py
if [ "$(id -u)" -ne "0" ] ; then
    python setup.py install --user
else
    python setup.py install
fi
