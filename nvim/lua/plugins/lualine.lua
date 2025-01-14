return {
	"nvim-lualine/lualine.nvim",
	config = function()
		-- Paste your custom Lualine setup here
		local lualine = require("lualine")

      -- Color table for highlights
      -- stylua: ignore
      local colors = {
        bg       = '#282a36',
        fg       = '#bbc2cf',
        yellow   = '#f1fa8c',
        cyan     = '#8be9fd',
        darkblue = '#6272a4',
        green    = '#50fa7b',
        orange   = '#FF8800',
        violet   = '#a9a1e1',
        magenta  = '#bd93f9',
        blue     = '#51afef',
        red      = '#ff5555',
      }

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		-- Config
		local config = {
			options = {
				component_separators = "",
				section_separators = "",
				theme = {
					normal = { c = { fg = colors.fg, bg = colors.bg } },
					inactive = { c = { fg = colors.fg, bg = colors.bg } },
				},
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}

		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		ins_left({
			function()
				return "▊"
			end,
			color = { fg = colors.blue },
			padding = { left = 0, right = 1 },
		})

		ins_left({
			function()
				return ""
			end,
			color = function()
				local mode_color = {
					n = colors.red,
					i = colors.green,
					v = colors.blue,
					[""] = colors.blue,
					V = colors.blue,
					c = colors.magenta,
					no = colors.red,
					s = colors.orange,
					S = colors.orange,
					[""] = colors.orange,
					ic = colors.yellow,
					R = colors.violet,
					Rv = colors.violet,
					cv = colors.red,
					ce = colors.red,
					r = colors.cyan,
					rm = colors.cyan,
					["r?"] = colors.cyan,
					["!"] = colors.red,
					t = colors.red,
				}
				return { fg = mode_color[vim.fn.mode()] }
			end,
			padding = { right = 1 },
		})

		ins_left({ "filename", cond = conditions.buffer_not_empty, color = { fg = colors.magenta, gui = "bold" } })
		ins_left({ "location" })
		ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })
		ins_left({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " " },
			diagnostics_color = {
				error = { fg = colors.red },
				warn = { fg = colors.yellow },
				info = { fg = colors.cyan },
			},
		})

		ins_left({
			function()
				return "%="
			end,
		})

		ins_left({
			function()
				local msg = "No Active Lsp"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end,
			icon = " LSP:",
			color = { fg = "#ffffff", gui = "bold" },
		})

		ins_right({
			"o:encoding",
			fmt = string.upper,
			cond = conditions.hide_in_width,
			color = { fg = colors.green, gui = "bold" },
		})
		ins_right({
			function()
				local format = vim.o.fileformat:upper()
				if format == "UNIX" then
					return " " -- Show Tux   if format is UNIX
				else
					return format -- Just show the file format otherwise
				end
			end,
			icons_enabled = false,
			color = { fg = "#000000", bg = colors.yellow, gui = "bold" },
		})
		ins_right({ "branch", icon = "", color = { fg = colors.violet, gui = "bold" } })
		ins_right({
			"diff",
			symbols = { added = " ", modified = "󰝤 ", removed = " " },
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.orange },
				removed = { fg = colors.red },
			},
			cond = conditions.hide_in_width,
		})

		ins_right({
			function()
				return "▊"
			end,
			color = { fg = colors.blue },
			padding = { left = 1 },
		})

		lualine.setup(config)
	end,
}
