return {
	-- Mason: Package manager for LSP servers, DAP servers, linters, and formatters
	{
		"williamboman/mason.nvim",
		config = function()
			-- Basic mason setup with default configuration
			require("mason").setup()
		end,
	},

	-- Mason-LSPconfig: Bridge between Mason and LSPconfig
	-- Automatically installs LSP servers and helps manage their configurations
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim", -- Depends on Mason for installing servers
			"hrsh7th/cmp-nvim-lsp", -- Adds LSP completion capabilities
		},
		config = function()
			-- Merge default LSP capabilities with nvim-cmp's LSP capabilities
			-- This gives us both basic LSP features and enhanced completion features
			local capabilities = vim.tbl_deep_extend(
				"force", -- Prefer nvim-cmp capabilities on conflict
				vim.lsp.protocol.make_client_capabilities(), -- Default LSP capabilities
				require("cmp_nvim_lsp").default_capabilities() -- nvim-cmp capabilities
			)
			require("mason-lspconfig").setup({
				-- List of LSP servers to automatically install
				-- Add more as needed: "pyright", "tsserver", etc.
				ensure_installed = { "lua_ls" },

				-- Automatically install LSP servers that are not installed
				automatic_installation = true,

				-- Handlers for setting up LSP servers
				handlers = {
					-- Default handler for all LSP servers
					-- This will be called for each installed server that doesn't have a dedicated handler
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities, -- Apply our merged capabilities
						})
					end,
				},
			})
		end,
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	-- LSPconfig: Main LSP client configuration
	-- Handles LSP server setup and configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim", -- Dependency for server installation
			"williamboman/mason-lspconfig.nvim", -- Dependency for server configuration
			"hrsh7th/cmp-nvim-lsp", -- Dependency for LSP completion
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- HTML
			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = { "html" },
			})

			-- Emmet
			lspconfig.emmet_ls.setup({
				capabilities = capabilities,
				filetypes = {
					"html",
					"css",
					"sass",
					"scss",
					"less",
				},
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
			})
			lspconfig.pylsp.setup({
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								ignore = { "W391" },
								maxLineLength = 100,
							},
						},
					},
				},
			})

			-- Keybindings for LSP functionality
			-- These work in normal mode when an LSP server is attached
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover({
					border = "rounded", -- Add border to hover window
					max_width = 80, -- Maximum width of hover window
					max_height = 20, -- Maximum height of hover window
				})
			end, { desc = "LSP Hover" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions Pane" })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show References" })

			-- Configure how diagnostics are displayed
			vim.diagnostic.config({
				virtual_text = true, -- Show diagnostics beside the code
				signs = true, -- Show signs in the sign column
				update_in_insert = false, -- Don't update diagnostics in insert mode
				underline = true, -- Underline text with issues
				severity_sort = true, -- Sort diagnostics by severity
				float = {
					border = "rounded", -- Add border to floating windows
					source = "always", -- Always show source of diagnostics
				},
			})
		end,
	},
}
