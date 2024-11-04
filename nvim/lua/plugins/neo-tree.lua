return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			window = {
				width = 30,
				position = "left",
				mappings = {
					["H"] = "toggle_hidden", -- Toggle hidden files with capital H
				},
			},
			filesystem = {
				filtered_items = {
					visible = false, -- This ensures you can see all items
					hide_dotfiles = true,
					hide_gitignored = true,
				},
			},
			default_component_configs = {
				git_status = {
					symbols = {
						added = "✚",
						deleted = "✖",
						modified = "",
						renamed = "󰁕",
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
				},
			},
		})
		vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>")
	end,
}
