import sublime
import sublime_plugin
from os.path import relpath

class ProjectFileToClipboardCommand(sublime_plugin.TextCommand):
		# sublime.set_clipboard(self.view.file_name())
    def run(self, edit):
        filename = self.view.file_name()
        if len(filename) > 0:
            # Copy shortest relpath for file compared to open folders
            sublime.set_clipboard(
                min(
                    (
                        relpath(filename, folder)
                        for folder in sublime.active_window().folders()
                    ),
                    key=len,
                )
            )
            sublime.status_message("Copied relative path")

    def is_enabled(self):
        return bool(self.view.file_name() and len(self.view.file_name()) > 0)