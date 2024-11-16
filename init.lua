-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")

--changes the path of python for tesnroflow
vim.g.python3_host_prog = "/Users/jacoblefkowitz/Projects/Python/venv/lib/python3.12/site-packages/"

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])



--none-ls stuff
--[[
return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.cpplint,
        null_ls.builtins.formatting.clang_format,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>f", vim.lsp.buf.format, {})
  end,
}]]--



