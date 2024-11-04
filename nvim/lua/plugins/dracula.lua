return {
	"Mofiqul/dracula.nvim",
	name = "dracula",
	opts = {
		transparent_bg = true,
	},
	priority = 1000,
	config = function(_, opts)
		require("dracula").setup(opts)
		vim.cmd.colorscheme("dracula")
	end,
}
