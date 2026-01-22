# Do not load autoconfig
config.load_autoconfig(False)

# Blank homepage
c.url.start_pages = ["about:blank"]
c.url.default_page = "about:blank"

# Fonts
c.fonts.default_family = "Fira Code"
c.fonts.default_size = "14pt"
c.fonts.web.size.default = 18

# Session management
c.auto_save.session = True
c.session.lazy_restore = True

# Clipboard access without prompting
c.content.javascript.clipboard = 'access'

# Keybindings
config.bind('<Ctrl-Shift-T>', 'undo')
config.bind('<Ctrl-Alt-T>', 'session-load -c _autosave')
