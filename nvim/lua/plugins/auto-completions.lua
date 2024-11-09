return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- Add LSP source
			"hrsh7th/cmp-path", -- Add path source
			"hrsh7th/cmp-buffer", -- Add buffer source
		},
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Helper function for tab completion
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			-- Set up custom highlights
			vim.api.nvim_set_hl(0, "CmpNormal", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "CmpItemAbbr", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#0fc3a7" })
			vim.api.nvim_set_hl(0, "CmpFloatBorder", { fg = "#b679d8" })
			vim.api.nvim_set_hl(0, "CmpItemSelected", { bg = "#2e4149" })
			vim.api.nvim_set_hl(0, "CmpPmenu", { bg = "NONE", blend = 10 })

			-- Updated capabilities for HTML/JSX support
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = {
						border = "rounded",
						winhighlight = "Normal:CmpNormal,FloatBorder:CmpFloatBorder,CursorLine:CmpItemSelected,Search:None",
						scrollbar = true,
						side_padding = 1,
					},
					documentation = {
						border = "rounded",
						winhighlight = "Normal:CmpNormal,FloatBorder:CmpFloatBorder,CursorLine:CmpItemSelected,Search:None",
						scrollbar = true,
						side_padding = 1,
					},
				},
				mapping = vim.tbl_extend(
					"force",
					cmp.mapping.preset.insert({
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping.abort(),
						["<CR>"] = cmp.mapping.confirm({ select = true }),
					}),
					{
						["<Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							elseif vim.snippet.active({ direction = 1 }) then
								vim.schedule(function()
									vim.snippet.jump(1)
								end)
							elseif has_words_before() then
								cmp.complete()
							else
								fallback()
							end
						end, { "i", "s" }),
						["<S-Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							elseif vim.snippet.active({ direction = -1 }) then
								vim.schedule(function()
									vim.snippet.jump(-1)
								end)
							else
								fallback()
							end
						end, { "i", "s" }),
					}
				),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" }, -- Add path source for imports
					{ name = "emmet_ls" }, -- Add Emmet source
				}, {
					{ name = "buffer" },
				}),
				-- Customize the appearance of completion items
				formatting = {
					format = function(entry, vim_item)
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							luasnip = "[Snippet]",
							buffer = "[Buffer]",
							path = "[Path]",
							emmet_ls = "[Emmet]",
						})[entry.source.name]
						return vim_item
					end,
				},
			})

			-- Set up file type specific completions
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				callback = function()
					cmp.setup.buffer({
						sources = cmp.config.sources({
							{ name = "nvim_lsp" },
							{ name = "luasnip" },
							{ name = "path" },
							{ name = "emmet_ls" },
						}, {
							{ name = "buffer" },
						}),
					})
				end,
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
}
