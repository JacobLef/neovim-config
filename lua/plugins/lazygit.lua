return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGtFilter",
    "LazyGitFilterCurrentFile",
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  --set keybind for LazyGit with "keys" is recommended in order to load the
  --plugin when the command is run for the first time
  keys = {
    { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" }
  },
}
