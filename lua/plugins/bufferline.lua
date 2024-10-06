return {
  'akinsho/bufferline.nvim',
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',

  config = function()
    require("bufferline").setup({})
  end
}
