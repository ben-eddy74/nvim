return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    local cat = require('catppuccin')
    cat.flavour = 'frappe'
  end
}
