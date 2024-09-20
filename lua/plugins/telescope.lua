return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require('telescope.builtin')
    local actions = require("telescope.actions")

    require('telescope').setup({

      defaults = {
        mappings = {
          i = {
            ["<C-s>"] = actions.select_vertical
          }
        },
        layout_config = {
          width = 0.95,
          preview_width = 0.65
        }
      }
    })

    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', function()
      builtin.grep_string({ search = vim.fn.input('Grep > ') });
    end)
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>tr', ':Neotree<CR>', {})
    vim.keymap.set('n', '<leader>ty', ':Neotree buffers<CR>', {})
  end
}
