return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  config = true -- ys (what you want to surround string with)
                -- ds (what you want to delete from surroudning the string)
                -- cs (what you want to change around the string) (new surroduning character)
}
