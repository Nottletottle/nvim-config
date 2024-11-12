vim.opt.tabstop = 2 -- number of visual spaces per TAB
vim.opt.softtabstop = 2 -- number of spacesin tab when editing
vim.opt.shiftwidth = 2 -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of python

-- UI config
vim.opt.number = true -- show absolute number
vim.opt.relativenumber = true -- add numbers to each line on the left side
vim.opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
vim.opt.scrolloff = 19 -- always keep cursor in the middle
vim.cmd([[
  highlight TelescopeNormal guibg=NONE ctermbg=NONE
  highlight TelescopePrompt guibg=NONE ctermbg=NONE
  highlight TelescopeResults guibg=NONE ctermbg=NONE
  highlight TelescopePreview guibg=NONE ctermbg=NONE
  highlight NormalFloat guibg=NONE ctermbg=NONE
  highlight FloatBorder guifg=#50fa7b
]])

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
-- Searching
vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = false -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered
vim.opt.numberwidth = 1 -- Set number column width
vim.opt.signcolumn = "yes:1" -- Make sign column 1 characters wide

vim.opt.clipboard:remove("unnamedplus")
-- Key mappings
vim.keymap.set({ "n", "v" }, "yk", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "ykk", '"+yy', { desc = "Yank line to system clipboard" })
vim.keymap.set({ "n", "v" }, "dk", '"+d', { desc = "Delete to system clipboard" })
vim.keymap.set("n", "pk", '"+p', { desc = "Put from system clipboard after" })
vim.keymap.set("n", "Pk", '"+P', { desc = "Put from system clipboard before" })
vim.api.nvim_set_keymap("n", "<leader>ir", "<C-w>>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>il", "<C-w><", { noremap = true, silent = true })
