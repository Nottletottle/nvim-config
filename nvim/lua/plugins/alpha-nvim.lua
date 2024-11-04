return {
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			vim.api.nvim_command("highlight AlphaDracHeader guifg=#ff4d01") --Orange for hydra
			vim.api.nvim_command("highlight AlphaDracButtons guifg=#50FA7B") -- Green
			vim.api.nvim_command("highlight AlphaDracShortcut guifg=#FF79C6") -- Pink
			vim.api.nvim_command("highlight AlphaDracFooter guifg=#8BE9FD") -- Cyan

			-- Set header with smaller ASCII art and adjusted spacing
			dashboard.section.header.val = {
				"                                   ",
				"                                   ",
				"                                   ",
				"   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
				"    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
				"          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
				"           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
				"          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
				"   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
				"  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
				" ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
				" ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
				"      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
				"       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
				"                                     ",
			}

			-- Header styling
			dashboard.section.header.opts = {
				position = "center",
				hl = "AlphaDracHeader",
			}

			-- Set menu buttons with glyphs and colors
			local buttons = {
				dashboard.button("e", "󰈔  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "󰈞  Find file", ":Telescope find_files<CR>"),
				dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
				dashboard.button(
					"c",
					"  Configs",
					":lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })<CR>"
				),
				dashboard.button("q", "🗙  Quit", ":qa<CR>"),
			}

			dashboard.section.buttons.val = buttons
			for _, button in ipairs(buttons) do
				button.opts.hl = "AlphaDracButtons"
				button.opts.hl_shortcut = "AlphaDracShortcut"
			end

			dashboard.section.footer.val = {
				"    da mi basia mille, deinde centum    ",
				" dein mille altera, dein secunda centum ",
				"deinde usque altera mille, deinde centum",
			}

			-- Footer styling
			dashboard.section.footer.opts = {
				position = "center",
				hl = "AlphaDracFooter",
			}

			-- Adjust layout with padding
			dashboard.config.layout = {
				{ type = "padding", val = 1 },
				dashboard.section.header,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
				{ type = "padding", val = 3 },
				dashboard.section.footer,
			}

			-- Send config to alpha
			alpha.setup(dashboard.opts)

			-- Disable folding on the alpha buffer
			vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
		end,
	},
}
