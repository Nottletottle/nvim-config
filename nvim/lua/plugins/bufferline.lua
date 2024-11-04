return {
	"akinsho/bufferline.nvim",
	config = function()
		local colors = require("dracula").colors()

		require("bufferline").setup({
			highlights = {
				fill = { bg = colors.selection },
				buffer_selected = { bold = true },
				diagnostic_selected = { bold = true },
				info_selected = { bold = true },
				info_diagnostic_selected = { bold = true },
				warning_selected = { bold = true },
				warning_diagnostic_selected = { bold = true },
				error_selected = { bold = true },
				error_diagnostic_selected = { bold = true },
				separator = { fg = colors.selection, bg = colors.selection }, -- Set slant separator color
				separator_selected = { bg = colors.bg, fg = "#191a21" },
				separator_visible = { bg = colors.bg, fg = "#191a21" },
			},
			options = {
				show_close_icon = false,
				diagnostics = "nvim_lsp",
				max_prefix_length = 8,
				separator_style = "slant",
			},
		})

		vim.keymap.set("n", "gb", "<CMD>BufferLinePick<CR>")
		vim.keymap.set("n", "<leader>ts", "<CMD>BufferLinePickClose<CR>")
		vim.keymap.set("n", "<S-l>", "<CMD>BufferLineCycleNext<CR>")
		vim.keymap.set("n", "<S-h>", "<CMD>BufferLineCyclePrev<CR>")
		vim.keymap.set("n", "]b", "<CMD>BufferLineMoveNext<CR>")
		vim.keymap.set("n", "[b", "<CMD>BufferLineMovePrev<CR>")
		vim.keymap.set("n", "gs", "<CMD>BufferLineSortByDirectory<CR>")
	end,
}
