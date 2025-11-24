return {
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
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
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'neovim/nvim-lspconfig',
        },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            -- LSP on_attach wrapper (uses global function from keymaps.lua)
            local on_attach = function(client, bufnr)
                _G.setup_lsp_keymaps(client, bufnr)
            end

            -- Configure diagnostic display
            vim.diagnostic.config({
                virtual_text = {
                    prefix = '●',
                    source = 'if_many',
                },
                signs = true,
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

            -- Setup diagnostic signs
            local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
            for type, icon in pairs(signs) do
                local hl = 'DiagnosticSign' .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            -- Server-specific configurations
            local server_configs = {
                   lua_ls = {
                       settings = {
                           Lua = {
                               runtime = {
                                   version = 'LuaJIT',
                               },
                               diagnostics = {
                                   globals = { 'vim' },
                               },
                               workspace = {
                                   library = {
                                       vim.env.VIMRUNTIME,
                                       "${3rd}/luv/library",
                                   },
                                   checkThirdParty = false,
                               },
                               telemetry = {
                                   enable = false,
                               },
                               completion = {
                                   callSnippet = 'Replace',
                               },
                           }
                       }
                   },
            }

            -- Setup mason-lspconfig with handlers
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'lua_ls',
                    'eslint',
                    'html',
                    'cssls',
                    'jsonls',
                    'tailwindcss',
                },
                automatic_installation = true,
                handlers = {
                    -- Default handler for all servers
                    function(server_name)
                        local config = server_configs[server_name] or {}
                        require('lspconfig')[server_name].setup(vim.tbl_extend('force', {
                            on_attach = on_attach,
                            capabilities = capabilities,
                        }, config))
                    end,
                },
            })
        end
    },
    {
        'neovim/nvim-lspconfig',
        lazy = true,
    }
}

