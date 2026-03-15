c = get_config()

c.TerminalInteractiveShell.shortcuts = [
    {
        "command": "IPython:auto_suggest.accept",
        "match_keys": ["c-space"],
    },
    {
        "command": "IPython:shortcuts.previous_history_or_previous_completion",
        "match_keys": ["c-k"],
    },
    {
        "command": "IPython:shortcuts.next_history_or_next_completion",
        "match_keys": ["c-j"],
    },
]

# vi mode
c.TerminalInteractiveShell.editing_mode = "vi"
c.TerminalInteractiveShell.emacs_bindings_in_vi_insert_mode = False

# yank to clipboard (may be required for remote sessions)
# from prompt_toolkit.clipboard.pyperclip import PyperclipClipboard
# c.TerminalInteractiveShell.clipboard_provider = PyperclipClipboard()

c.TerminalInteractiveShell.confirm_exit = False

# automatic reloading of imported modules
c.InteractiveShellApp.exec_lines = ["%autoreload 2"]
c.InteractiveShellApp.extensions = ["autoreload"]
