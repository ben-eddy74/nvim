return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    "j-hui/fidget.nvim",
  },
  config = function()
    require("fidget").setup({})
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls' }
    })

    local lsp = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lspkind = require('lspkind')

    -- PowerShell
    --
    lsp.powershell_es.setup {
      bundle_path = 'c:/Software/Dev/PowerShellEditorServices/',
      capabilities = lsp_capabilities,
      settings = { powershell = { codeFormatting = { Preset = 'Allman' } } }
    }
    -- Lua
    --
    lsp.lua_ls.setup {
      capabilities = lsp_capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    }

    --Prettyfy with icons
    --
    lspkind.init{}

    -- Snippets
    --
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Autocomplete
    --

    local cmp = require('cmp')
    local luasnip = require('luasnip')

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end
      },
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = {
        { name = 'nvim_lsp', keyword_length = 1 },
        { name = 'luasnip',  keyword_length = 1 },
        { name = 'buffer', keyword_length = 2 },
        { name = 'path', keyword_length = 3 }
      },
      window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered()
      },
      formatting = {
        format = lspkind.cmp_format(),
      },
    })

    vim.keymap.set({ "i", "s" }, "<C-k>", function ()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<C-j>", function ()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true })

  end -- end config
}
