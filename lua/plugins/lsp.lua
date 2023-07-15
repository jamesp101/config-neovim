-- LSP Configuration & Pugins
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- { "j-hui/fidget.nvim", tag = 'legacy' },
			"folke/neodev.nvim",
			"RRethy/vim-illuminate",
			"hrsh7th/cmp-nvim-lsp",
			"simrat39/symbols-outline.nvim",
			'glepnir/lspsaga.nvim',
			'ray-x/lsp_signature.nvim'
		},
		config = function()
			-- Set up Mason before anything else
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					'tsserver',
					'svelte',
					'pyright'
				},
				automatic_installation = true,
			})

			-- Quick access via keymap
			require("helpers.keys").map("n", "<leader>M", "<cmd>Mason<cr>", "Show Mason")

			-- Neodev setup before LSP config
			require("neodev").setup()

			require("symbols-outline").setup()
			require('lspsaga').setup({
				rename = {
					keys = {
						quit = "<ESC>"
					}
				}
			})



			-- Set up cool signs for diagnostics
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- Diagnostic config
			local config = {
				-- virtual_text = false,
				ui = {
					code_action = ""
				},
				signs = {
					active = signs,
				},
				update_in_insert = true,
				underline = true,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			}
			vim.diagnostic.config(config)
			-- This function gets run when an LSP connects to a particular buffer.
			local on_attach = function(client, bufnr)
				local lsp_map = require("helpers.keys").lsp_map

				vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
					vim.lsp.buf.format()
				end, { desc = "Format current buffer with LSP" })


				lsp_map("<leader>lf", "<cmd>Format<cr>", bufnr, "Format")
				lsp_map("<leader>lM", '<cmd>Lspsaga outline<CR>', nil, "Outline")
				lsp_map("<leader>lm", '<cmd>SymbolsOutline<CR>', nil, "Outline")

				lsp_map("<leader>lr", "<CMD>Lspsaga rename<CR>", bufnr, "Rename")
				lsp_map("<leader>la", "<CMD>Lspsaga code_action<CR>", bufnr, "Code action")
				lsp_map("<leader>ld", vim.lsp.buf.type_definition, bufnr, "Type definition")


				--
				lsp_map("K", "<CMD>Lspsaga hover_doc<CR>", bufnr, "Hover")
				lsp_map("<leader>lh", "<CMD>Lspsaga hover_doc<CR>", bufnr, "Hover")
				lsp_map("gd", "<CMD>Lspsaga goto_definition<CR>", bufnr, "Goto Definition")
				lsp_map("gp", "<CMD>Lspsaga peek_definition<CR>", bufnr, "Peek")

				lsp_map("<leader>le", "<CMD>Lspsaga show_buf_diagnostics<CR>", bufnr, "Peek")
				lsp_map("<leader>lE", "<CMD>Lspsaga show_workspace_diagnostics<CR>", bufnr, "Peek")


				-- RUn
				require("illuminate").on_attach(client)
				require('lsp_signature').setup()
			end

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- Auto Config
			local lspconfig = require('lspconfig')
			local servers = require('mason-lspconfig').get_installed_servers()

			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					on_attach = on_attach,
					capabilities = capabilities

				})
			end

			-- Lua
			require("lspconfig")["lua_ls"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			})
		end,
	},
}
