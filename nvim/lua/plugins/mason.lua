return {
	{
		'williamboman/mason.nvim',
		lazy = false,
		config = function()
			require('mason').setup({
				ui = {
					icons = {
						package_installed = '✓',
						package_pending = '➜',
						package_uninstalled = '✗'
					},
					border = 'rounded',
				},
			})
		end
	},
	{
		'williamboman/mason-lspconfig.nvim',
		lazy = false,
		dependencies = {
			'williamboman/mason.nvim',
			'neovim/nvim-lspconfig',
		},
		config = function()
			-- LSP on_attach wrapper (uses global function from keymaps.lua)
			local on_attach = function(client, bufnr)
				_G.setup_lsp_keymaps(client, bufnr)
			end

			-- Configure diagnostic display (new API)
			vim.diagnostic.config({
				virtual_text = {
					prefix = '●',
					source = 'if_many',
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = ' ',
						[vim.diagnostic.severity.WARN] = ' ',
						[vim.diagnostic.severity.HINT] = ' ',
						[vim.diagnostic.severity.INFO] = ' ',
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = 'rounded',
					source = 'if_many',
					header = '',
					prefix = '',
				},
			})

			-- Setup mason-lspconfig with handlers
			require('mason-lspconfig').setup({
				ensure_installed = {
					'lua_ls',
					'vtsls', -- TypeScript/JavaScript LSP (faster, more features)
					'eslint', -- ESLint (reads local .eslintrc)
					'html',
					'cssls',
					'jsonls',
					'tailwindcss',
				},
				automatic_installation = true,
			})

			-- Configure each installed server using vim.lsp.config (new API)
			-- vtsls
			vim.lsp.config.vtsls = {
				cmd = { 'vtsls', '--stdio' },
				filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
				root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
			}
			vim.lsp.enable('vtsls')

			-- Track which LSP progress events we've already notified about
			local notified_progress = {}
			
			-- lua_ls
			vim.lsp.config.lua_ls = {
				cmd = { 'lua-language-server' },
				filetypes = { 'lua' },
				root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
				settings = {
					Lua = {
						runtime = { version = 'LuaJIT' },
						diagnostics = { globals = { 'vim' } },
						workspace = {
							library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
							checkThirdParty = false,
						},
						telemetry = { enable = false },
						completion = { callSnippet = 'Replace' },
						hint = { enable = false },  -- Disable inlay hints
					}
				},
				handlers = {
					['$/progress'] = function(_, result, ctx)
						-- Route progress notifications to mini.notify with LSP server name
						if result.value and result.value.kind then
							local client = vim.lsp.get_client_by_id(ctx.client_id)
							local client_name = client and client.name or "LSP"
							local token = result.token
							
							-- Create unique key for this progress event
							local key = string.format("%s_%s_%s", client_name, token, result.value.kind)
							
							-- Only notify if we haven't already notified for this event
							if not notified_progress[key] then
								if result.value.kind == "begin" then
									vim.notify(string.format("Loading %s workspace...", client_name), vim.log.levels.INFO)
									notified_progress[key] = true
								elseif result.value.kind == "end" then
									vim.notify(string.format("%s workspace ready!", client_name), vim.log.levels.INFO)
									notified_progress[key] = true
									-- Clear the token from tracking after completion
									vim.defer_fn(function()
										for k, _ in pairs(notified_progress) do
											if k:match("^" .. client_name .. "_" .. token) then
												notified_progress[k] = nil
											end
										end
									end, 1000)
								end
							end
							-- Skip "report" kind to avoid showing progress numbers
						end
					end,
				}
			}
			vim.lsp.enable('lua_ls')

			-- eslint
			vim.lsp.config.eslint = {
				cmd = { 'vscode-eslint-language-server', '--stdio' },
				filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
				root_markers = { '.eslintrc', '.eslintrc.js', '.eslintrc.json', 'eslint.config.js', 'package.json', '.git' },
			}
			vim.lsp.enable('eslint')

			-- html
			vim.lsp.config.html = {
				cmd = { 'vscode-html-language-server', '--stdio' },
				filetypes = { 'html' },
				root_markers = { 'package.json', '.git' },
			}
			vim.lsp.enable('html')

			-- cssls
			vim.lsp.config.cssls = {
				cmd = { 'vscode-css-language-server', '--stdio' },
				filetypes = { 'css', 'scss', 'less' },
				root_markers = { 'package.json', '.git' },
			}
			vim.lsp.enable('cssls')

			-- jsonls
			vim.lsp.config.jsonls = {
				cmd = { 'vscode-json-language-server', '--stdio' },
				filetypes = { 'json', 'jsonc' },
				root_markers = { 'package.json', '.git' },
			}
			vim.lsp.enable('jsonls')

			-- tailwindcss
			vim.lsp.config.tailwindcss = {
				cmd = { 'tailwindcss-language-server', '--stdio' },
				filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
				root_markers = { 'tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.ts', 'package.json', '.git' },
			}
			vim.lsp.enable('tailwindcss')

			-- Set up autocmd to call on_attach when LSP attaches
			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client then
						on_attach(client, args.buf)
					end
				end,
			})
		end
	},
	{
		'neovim/nvim-lspconfig',
		lazy = false,
	}
}
