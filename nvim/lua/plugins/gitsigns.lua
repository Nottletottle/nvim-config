return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "╋" },
				change = { text = "┃" },
				delete = { text = "✀" },
				topdelete = { text = "‾" },
				changedelete = { text = "🝛" },
				untracked = { text = "❖" },
			},
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
			},
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)
			-- Optional keymaps for navigation
			vim.keymap.set("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					require("gitsigns").next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Jump to next hunk" })

			vim.keymap.set("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					require("gitsigns").prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Jump to previous hunk" })

			-- Additional useful keymaps
			vim.keymap.set("n", "<leader>hs", require("gitsigns").stage_hunk, { desc = "Stage hunk" })
			vim.keymap.set("n", "<leader>hr", require("gitsigns").reset_hunk, { desc = "Reset hunk" })
			vim.keymap.set("n", "<leader>hS", require("gitsigns").stage_buffer, { desc = "Stage buffer" })
			vim.keymap.set("n", "<leader>hu", require("gitsigns").undo_stage_hunk, { desc = "Undo stage hunk" })
			vim.keymap.set("n", "<leader>hR", require("gitsigns").reset_buffer, { desc = "Reset buffer" })
			vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk, { desc = "Preview hunk" })
			vim.keymap.set("n", "<leader>hb", function()
				require("gitsigns").blame_line({ full = true })
			end, { desc = "Blame line" })
			vim.keymap.set(
				"n",
				"<leader>tb",
				require("gitsigns").toggle_current_line_blame,
				{ desc = "Toggle line blame" }
			)
			vim.keymap.set("n", "<leader>hd", require("gitsigns").diffthis, { desc = "Diff against index" })
			vim.keymap.set("n", "<leader>td", require("gitsigns").toggle_deleted, { desc = "Toggle deleted" })
		end,
	},
}
