return
{
  -- A startup screen plugin with a customizable dashboard
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require 'alpha'.setup(require 'alpha.themes.dashboard'.config)

    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣦⡀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠠⠀⡀⠀⣠⡞⢀⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⣴⡇⠠⢠⣾⣿⢃⣾⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀",
      "⠀⠀⠀⣼⡀⣼⣿⣇⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀",
      "⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⡀⠀",
      "⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣴⠁⠀",
      "⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⡀",
      "⡀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣡⣾⡇",
      "⣿⣾⣿⣿⣿⣿⣿⠿⣿⣿⣿⣿⣿⣿⣿⠿⣿⣿⣿⣿⣿⢟⣴⠁",
      "⠘⣿⣿⣿⣿⠫⠀⠀⠈⢿⣿⣿⣿⡟⠁⠀⠀⠙⣿⣿⣟⣾⡏⠀",
      "⣀⠹⣿⣿⣿⠀⠀⠀⠀⠈⢿⣿⡟⠀⠀⠀⠀⠀⣿⣿⣯⡟⡠⠂",
      "⠈⢿⡾⢝⢿⡀⠀⠀⠀⠀⠈⠿⠀⠀⠀⠀⠀⢀⣿⣋⢩⣾⡞⠀",
      "⠀⠀⠱⢣⠋⠇⠿⣦⡀⠀⢀⠀⠀⠀⢀⣴⠾⢠⠓⡄⡜⠉⠀⠀",
      "⠀⠀⠀⠀⠫⢙⡀⠠⣙⠦⣄⠀⣠⠴⢋⠄⠀⢦⡩⠊⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⢧⡀⠀⠀⠈⢠⠀⠈⠀⠀⡈⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠢⠀⠀⠚⠅⠀⡠⠊⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠤⠄⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    }

    dashboard.section.buttons.val = {}
    dashboard.section.footer.val = {
      "ITS OVER 9000!",
    }
  end
}
