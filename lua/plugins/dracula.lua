
--tokyonight colorscheme
--[[return {
  "folke/tokyonight.nvim",
  lazy = false,
  name = "tokyonight",
  priority = 1000,
  config = function()
    vim.cmd "colorscheme tokyonight"
  end
}]]--

return {
  "Mofiqul/dracula.nvim",
  lazy = false,
  name = "dracula",
  priority = 1000,
  config = function()
    vim.cmd "colorscheme dracula"
  end
}
