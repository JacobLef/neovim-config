return { --try to fix later down the line with the if statemnts in the keymap section
	{
		"williamboman/mason.nvim",
		config = function()
	  require("mason").setup({
		  registries = {
			  "github:mason-org/mason-registry@2023-05-15-next-towel",
		  },
	  })
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"mypy", -- python linter
					"flake8", -- python linter
					"cpplint", -- c and cpp linter
					"clang-format", -- c and cpp formatter
					"stylua", -- lua formatter
					"isort", -- python formatter
					"black", -- python formatter (having issues)
          "debugpy",-- python debugger
          "rustfmt" -- rust formatter
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true
    },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright", "clangd", "rust_analyzer"},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- so we can have lsp recommendations in our autocompletions
			{ "antosha417/nvim-lsp-file-operations", config = true }, -- allows you to rename files through nvim tree or neo tree and update any affected import statements
			{ "folke/neodev.nvim", opts = {} },

		},
		config = function()
			--import lspconfig plugin
			local lspconfig = require("lspconfig")

			--import cmp-nvim-lsp plugin

			local keymap = vim.keymap

			vim.api.nvim_create_autocmd("LspAttach", { --don't really know why the if statements work but they do
				group = vim.api.nvim_create_augroup("UserLspConfig",  { clear = true}),
				callback = function(ev)
          local bufnr = ev.buf

					local opts = { buffer = bufnr, noremap = true, silent = true }
					--keymaps
					opts.desc = "Show LSP references"
					keymap.set("n", "<leader>gR", "<cmd>Telescope lsp_references<CR>", opts)

          if vim.lsp.buf.declarations then
					  opts.desc = "Go to declaration"
					  keymap.set("n", "<leader>go", vim.lsp.buf.declarations, opts) --not working needs to be fixed
          end

					opts.desc = "Show LSP definitions"
					keymap.set("n", "<leader>gO", "<cmd>Telescope lsp_type_definition<CR>", opts)

					opts.desc = "Show LSP implementations"
					keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", opts)

					opts.desc = "Show LSP type definition"
					keymap.set("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

          if vim.lsp.buf.code_action then
					  opts.desc = "See avaiable code actions"
					  keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          end

          if vim.lsp.buf.rename then
					  opts.desc = "Smart rename"
					  keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          end

					opts.desc = "Show buffer diagnostics" -- show file diagnostics
					keymap.set("n", "<leader>gD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

		      if vim.diagnostic.open_float then
			      opts.desc = "Show line diagnostics"
			      keymap.set("n", "<leader>gd", vim.diagnostic.open_float, opts)
		      end

		      if vim.diagnostic.goto_prev then
			      opts.desc = "Go to previous diagnostic"
			      keymap.set("n", "<leader>pd", vim.diagnostic.goto_prev, opts)
		      end

		      if vim.diagnostic.goto_next then
			      opts.desc = "Go to next diagnostic"
			      keymap.set("n", "<leader>nd", vim.diagnostic.goto_next, opts)
		      end

		      if vim.lsp.buf.hover then
			      opts.desc = "Show documenation for what is under cursor"
			      keymap.set("n", "K", vim.lsp.buf.hover, opts)
		      end

					opts.desc = "Restart LSP"
					keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
				end,
			})
			--used to enable autocompletion (assign to every lsp server config)
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
	--configure python server with plugin
	lspconfig["pyright"].setup({
		capabilities = capabilities,
		filetypes = { "python" },
		setings = {
			python = {
				analysis = {
					diagnosticMode = "workspace",
					useLibraryCodeForTypes = true,
					typeCheckingMode = "off",
				},
			},
		},
	})
			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				settings = { -- custom settings for lua
					Lua = {
						--make the language server recongnie "vim" global
						diangostics = {
							globals = { "vim" },
						},
						workspace = {
							-- make language server aware of runtime files
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			})

			lspconfig["clangd"].setup({
				capabilities = capabilities,
        filetypes = { "c", "cpp" },
        settings = {
          clangd = {
            completeUnimported = true,
            usePlaceholders = true,
            anaylses = {
              unusedparams = true,
            }
          }
        }
			})

      lspconfig["rust_analyzer"].setup({
				capabilities = capabilities,
        filetypes = { "rs" }
			})

		end,
	},
}
