return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",

  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {"lua", "c", "cpp", "javascript", "racket", "python"},
      highlight = { enable = true },
      indent = { enable = true },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      TSConfig = {},
      modules = {},
    })
  end
}


