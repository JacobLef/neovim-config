--linting
return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			-- javascript = { "eslint_d" }
			python = { "mypy", "flake8" },
			c = { "cpplint" },
			cpp = { "cpplint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint() --lint program will try to execute linting for the current buffer
			end,
		})

		vim.keymap.set("n", "<leader>f", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}

