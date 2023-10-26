# EditorConfig Gedit Plugin

This is an [EditorConfig][] plugin for [gedit][].

## Downloading Gedit Plugin

[Click here to download the latest version](https://github.com/editorconfig/editorconfig-gedit/archive/v0.5.3.zip)

Older versions of the EditorConfig Gedit plugin can be downloaded as an archive
file from the [tags][] page.

The plugin can also be downloaded using via Git as follows:

    git clone git://github.com/editorconfig/editorconfig-gedit.git

## Installation

First, make sure the core [EditorConfig Python Core library][] is installed on your
machine.

Next, install the plugin compatible with your version of Gedit by executing the
`install.sh` script.  The `install.sh` script should install the appropriate
plugin for your Gedit version.  If this does not work, the instructions below
can be used to install the plugin manually.

After installing the plugin, it must be enabled in Gedit.  To enable the plugin
navigate to *Edit* -> *Preferences* -> *Plugins* and check the EditorConfig
plugin.

### Manual installation

To install the gedit 3 plugin manually, execute the following copy command:

    cp -Lr editorconfig.plugin editorconfig_gedit3.py editorconfig_plugin ~/.local/share/gedit/plugins/

To install the gedit 2 plugin manually, execute the following copy command:

    cp -Lr editorconfig.gedit-plugin editorconfig_gedit2.py editorconfig_plugin ~/.gnome2/gedit/plugins/

You might need to change "python3" in the file editorconfig.plugin to "python"
if gedit complains the loader.

## Supported properties

The EditorConfig Gedit plugin fully supports the following EditorConfig
[properties][]:

* indent_style
* trim_trailing_whitespace
* end_of_line (only in Gedit <= 3.14)
* max_line_length
* root (only used by EditorConfig core)

There is partial support for the following properties:

* indent_size
* tab_width

With the Gedit plugin the `tab_width` cannot be set to a different value than
`indent_size`.  When `indent_style` is "tab", tabs will be used for indentation
and `tab_width` will be used for indentation size to maintain the correct width
of tab characters.  When `indent_style` is set to "space", the `tab_width`
property is ignored and tabs are always set to the width of `indent_size`.

## Note for Developers

The directory `editorconfig-core-py` is a subtree. Update it using

    git subtree pull --prefix editorconfig-core-py https://github.com/editorconfig/editorconfig-core-py master

[EditorConfig]: http://editorconfig.org
[EditorConfig Python Core library]: https://github.com/editorconfig/editorconfig-core-py
[gedit]: http://projects.gnome.org/gedit
[properties]: http://editorconfig.org/#supported-properties
[tags]: https://github.com/editorconfig/editorconfig-gedit/tags
[latest]: https://github.com/editorconfig/editorconfig-gedit/archive/v0.5.1.tar.gz
