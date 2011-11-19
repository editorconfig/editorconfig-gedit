from subprocess import Popen, PIPE, STDOUT
from gi.repository import GObject, Gedit

class EditorConfigPlugin(GObject.Object, Gedit.WindowActivatable):
    NUMERIC_PROPERTIES = ('indent_size', 'tab_width')
    __gtype_name__ = "EditorConfig"
    window = GObject.property(type=Gedit.Window)

    def do_activate(self):
        handler_id = self.window.connect('active_tab_state_changed',
                self.set_config)
        self.window.set_data('EditorConfigPluginHandlerId', handler_id)

    def set_config(self, window):
        """Get EditorConfig properties for file and change settings"""

        tab = window.get_active_tab()
        props = self.get_properties(tab.get_document())
        self.process_properties(props)
        self.set_indentation(tab.get_view(),
                             props.get('indent_style'),
                             props.get('indent_size'),
                             props.get('tab_width'))

    def get_properties(self, document):
        """Call EditorConfig core to and return properties dict for document"""

        if document:
            file_uri = document.get_uri_for_display()
            if file_uri:
                args = ['editorconfig', file_uri]
                proc = Popen(args, stdout=PIPE, stderr=STDOUT)
                lines = proc.communicate()[0].split('\n')
                return dict([p.split('=', 1) for p in lines if p.count('=')])
        return {}

    def process_properties(self, properties):
        """Process property values and remove invalid properties"""

        # Convert any numeric properties to numbers and remove invalid values
        for prop in self.NUMERIC_PROPERTIES:
            if prop in properties:
                try:
                    properties[prop] = int(properties[prop])
                except ValueError:
                    del properties[prop]

    def set_indentation(self, view, indent_style, indent_size, tab_width):
        """Set indentation style for given view based on given properties"""

        if indent_style == 'space':
            view.set_insert_spaces_instead_of_tabs(True)
            if indent_size:
                view.set_tab_width(indent_size)
        elif indent_style == 'tab':
            view.set_insert_spaces_instead_of_tabs(False)
            if tab_width:
                view.set_tab_width(tab_width)

    def do_deactivate(self):
        handler_id = self.window.get_data('EditorConfigPluginHandlerId')
        self.window.disconnect(handler_id)
        self.window.set_data('EditorConfigPluginHandlerId', None)