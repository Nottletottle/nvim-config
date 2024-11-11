return {
	"3rd/image.nvim",
	config = function()
		require("image").setup({
			backend = "kitty", -- or "ueberzug"
			integrations = {
				markdown = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_image_at_cursor = true,
					filetypes = { "markdown", "vimwiki" }, -- Supported file types
				},
				neorg = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_image_at_cursor = true,
					filetypes = { "norg" },
				},
			},
			max_width = nil,
			max_height = nil,
			max_width_window_percentage = nil,
			max_height_window_percentage = 50,
			window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
			editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
			tmux_show_only_in_active_window = false, -- auto show/hide images in tmux window
			hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
		})
	end,
	-- Make sure you have the required dependencies
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	-- Optional: Limit plugin to specific filetypes
	ft = {
		"markdown",
		"vimwiki",
		"norg",
	},
}