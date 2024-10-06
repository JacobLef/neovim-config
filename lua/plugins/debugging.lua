return { --add configurations to dap for python and c/cpp
  {
  "mfussenegger/nvim-dap",

	dependencies = {
		"rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
	},

	config = function()
    --for conciseness
		local dap = require("dap")
    local dapui = require("dapui")

    --key maps
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<leader>dc", dap.continue, {})
	end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap-python"
    },
    config = function()
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end

  },
}
