--formatting
return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				--javascript = { "prettier" },
				lua = { "stylua" },
				python = { "black", "isort" },
				c = { "clang-format" },
				cpp = { "clang-format" },
        racket = { "raco" },
			},

			format_on_Save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 50,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>gf", function()
			conform.format({
				lasp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
