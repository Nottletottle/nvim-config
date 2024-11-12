return {
	{
		"Galooshi/vim-import-js",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			-- Set up your vim-import-js configuration here
			vim.g.import_js_import_files_max_depth = 5
			vim.g.import_js_import_order = { "react", "node", ".", "../", "../../", "../../../" }
			vim.g.import_js_sort_imports = 1
			vim.g.import_js_es6_import_style = 1
		end,
	},
}
