return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "nord",
		},
	},
	{
		"shaunsingh/nord.nvim",
		event = "VeryLazy",
	},
	{
		"is0n/jaq-nvim",
		keys = {
			{ "<leader>r", "<cmd>Jaq<cr>", desc = "Quickrun (jaq-nvim)" },
		},
		opts = function()
			require("jaq-nvim").setup({
				cmds = {
					internal = {},
					external = {
						python = "python %",
						cpp = "g++ % && ./a.out",
						tex = "docker run -u $(id -u):$(id -g) --rm -v ${PWD}:/workdir ghcr.io/being24/latex-docker latexmk ./main.tex",
					},
				},
				behavior = {
					-- Default type
					default = "quickfix",
					-- Start in insert mode
					startinsert = false,
					-- Use `wincmd p` on startup
					wincmd = false,
					-- Auto-save files
					autosave = false,
				},
				ui = {
					quickfix = {
						position = "bot",
						size = 10,
					},
				},
			})
		end,
	},
	{
		"mickael-menu/zk-nvim",
		keys = {
			{
				"<leader>zn",
				function()
					require("zk.commands").get("ZkNew")({})
				end,
				desc = "Create notes (zk)",
			},
			{
				"<leader>zf",
				function()
					require("zk.commands").get("ZkNotes")({ sort = { "modified" } })
				end,
				desc = "Open notes (zk)",
			},
			{
				"<leader>zt",
				function()
					require("zk.commands").get("ZkTags")({})
				end,
				desc = "Open notes (zk)",
			},
			{
				"<leader>zl",
				function()
					require("zk.commands").get("ZkLinks")()
				end,
				desc = "Open notes linked by the current note (zk)",
			},
			{
				"<leader>zb",
				function()
					require("zk.commands").get("ZkBacklinks")()
				end,
				desc = "Open notes linking to the current note (zk)",
			},
		},
		config = function()
			require("zk").setup({
				-- can be "telescope", "fzf" or "select" (`vim.ui.select`)
				-- it's recommended to use "telescope" or "fzf"
				picker = "telescope",
				lsp = {
					-- `config` is passed to `vim.lsp.start_client(config)`
					config = {
						cmd = { "zk", "lsp" },
						name = "zk",
						-- on_attach = ...
						-- etc, see `:h vim.lsp.start_client()`
					},
					-- automatically attach buffers in a zk notebook that match the given filetypes
					auto_attach = {
						enabled = true,
						filetypes = { "markdown" },
					},
				},
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader><esc>",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Delete all Notifications",
			},
		},
		opts = {
			stages = "static",
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		init = function()
			local Util = require("lazyvim.util")
			if not Util.has("noice.nvim") then
				Util.on_very_lazy(function()
					vim.notify = require("notify")
				end)
			end
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local icons = require("lazyvim.config").icons
			local Util = require("lazyvim.util")

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "alpha" } },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
        -- stylua: ignore
        {
          function() return require("nvim-navic").get_location() end,
          cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
        },
					},
					lualine_x = {
        -- stylua: ignore
        {
          function() return require("noice").api.status.command.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          color = Util.fg("Statement"),
        },
        -- stylua: ignore
        {
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          color = Util.fg("Constant"),
        },
        -- stylua: ignore
        {
          function() return "  " .. require("dap").status() end,
          cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
          color = Util.fg("Debug"),
        },
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = Util.fg("Special"),
						},
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
						},
					},
					lualine_y = {
						-- { "progress", separator = " ", padding = { left = 1, right = 0 } },
						-- { "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						-- function()
						-- 	return " " .. os.date("%R")
						-- end,
					},
				},
				extensions = { "neo-tree", "lazy" },
			}
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		opts = {
			defaults = {
				mappings = {
					i = {
						["<Esc>"] = function(...)
							return require("telescope.actions").close(...)
						end,
						["<C-j>"] = function(...)
							return require("telescope.actions").move_selection_next(...)
						end,
						["<C-k>"] = function(...)
							return require("telescope.actions").move_selection_previous(...)
						end,
					},
				},
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
			},
			-- pickers = {
			-- 	find_files = { hidden = true },
			-- },
		},
	},
	{
		"L3MON4D3/LuaSnip",
		build = (not jit.os:find("Windows"))
				and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
			or nil,
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_lua").load({ paths = "./lua/snip/luasnip/" })
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	version = false,
	-- 	event = "InsertEnter",
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-buffer",
	-- 		"hrsh7th/cmp-path",
	-- 		"saadparwaiz1/cmp_luasnip",
	-- 	},
	-- 	opts = function()
	-- 		local cmp = require("cmp")
	-- 		return {
	-- 			completion = {
	-- 				completeopt = "menu,menuone,noinsert",
	-- 			},
	-- 			snippet = {
	-- 				expand = function(args)
	-- 					require("luasnip").lsp_expand(args.body)
	-- 				end,
	-- 			},
	-- 			mapping = cmp.mapping.preset.insert({
	-- 				["<tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
	-- 				["<S-tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
	-- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
	-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
	-- 				["<C-Space>"] = cmp.mapping.complete(),
	-- 				["<C-e>"] = cmp.mapping.abort(),
	-- 				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	-- 				["<S-CR>"] = cmp.mapping.confirm({
	-- 					behavior = cmp.ConfirmBehavior.Replace,
	-- 					select = true,
	-- 				}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	-- 			}),
	-- 			sources = cmp.config.sources({
	-- 				{ name = "nvim_lsp" },
	-- 				{ name = "luasnip" },
	-- 				{ name = "buffer" },
	-- 				{ name = "path" },
	-- 			}),
	-- 			formatting = {
	-- 				format = function(_, item)
	-- 					local icons = require("lazyvim.config").icons.kinds
	-- 					if icons[item.kind] then
	-- 						item.kind = icons[item.kind] .. item.kind
	-- 					end
	-- 					return item
	-- 				end,
	-- 			},
	-- 			experimental = {
	-- 				ghost_text = {
	-- 					hl_group = "LspCodeLens",
	-- 				},
	-- 			},
	-- 		}
	-- 	end,
	-- },
	-- -- disabled plugins
	{ "folke/tokyonight.nvim", enabled = false },
	{ "catppuccin", enabled = false },
	{ "echasnovski/mini.indentscope", enabled = false },
}
