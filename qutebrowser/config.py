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

# Enable webpage dark mode
c.colors.webpage.darkmode.enabled = True

# Prefer dark color scheme (important for many sites)
c.colors.webpage.preferred_color_scheme = "dark"

# Keybindings
config.bind('<Ctrl-Shift-T>', 'undo')
config.bind('<Ctrl-Alt-T>', 'session-load -c _autosave')

# Open private (incognito) qutebrowser window
config.bind('P', 'open -p')

c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?q={}",
    "yt": "https://www.youtube.com/results?search_query={}",
}

