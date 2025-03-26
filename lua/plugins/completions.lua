return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", --only loads when you go into insert mode
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "L3MON4D3/LuaSnip", build = "make install_jsregexp", -- snippet engine
    "saadparwaiz1/cmp_luasnip",  -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets for many different languages
    "hrsh7th/cmp-nvim-lsp"
  },

  config = function()
    local cmp = require("cmp")

    local luasnip = require("luasnip")

    --loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu, menuone, preview, noselect",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      --mappings
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_prev_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- backwards in preview window
        ["<C-f>"] = cmp.mapping.scroll_docs(4), -- forwards in preview window
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- pressing enter to confirm sleection
      }),
      --sources for autocompletion
      sources = cmp.config.sources({ -- order of the sources decides the priority of the recommendations
        { name = "nvim-lsp" },
        { name = "luasnip" }, -- snippets
        -- { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),
    })
  end,

}
