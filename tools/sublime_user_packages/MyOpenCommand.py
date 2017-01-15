import sublime, sublime_plugin
import os.path, string
import re

class MyOpenCommand(sublime_plugin.WindowCommand):
    def run(self):
        view = self.window.active_view()
        for region in view.sel():
            if region.begin() == region.end():
                word = view.word(region)
            else:
                word = region
            if not word.empty():
                keyword = view.substr(word)
        self.window.run_command("show_overlay", {"overlay": "goto", "show_files": "true", "text": keyword})