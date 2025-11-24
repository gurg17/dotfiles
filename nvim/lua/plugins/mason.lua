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
        dependencies = {
            'williamboman/mason.nvim',
            'neovim/nvim-lspconfig',
        },
        lazy = false,
        priority = 900,
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            -- Shared LSP Keymaps function (used by all LSP servers)
            _G.setup_lsp_keymaps = function(client, bufnr)
                local opts = { buffer = bufnr, silent = true }
                
                -- <leader>l prefix - LSP Actions
                vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code Action' }))
                vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename Symbol' }))
                vim.keymap.set('n', '<leader>lf', function()
                    -- Try conform first, fallback to LSP
                    local conform = require('conform')
                    if conform then
                        conform.format({ async = true, lsp_fallback = true })
                    else
                        vim.lsp.buf.format({ async = true })
                    end
                end, vim.tbl_extend('force', opts, { desc = 'Format Buffer' }))
                vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature Help' }))
                vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = 'Show Line Diagnostics' }))
                vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, vim.tbl_extend('force', opts, { desc = 'Diagnostics to Location List' }))
                
                -- Hover documentation
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Hover Documentation' }))
                
                -- Diagnostic navigation
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = 'Previous Diagnostic' }))
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'Next Diagnostic' }))
                
                -- Built-in LSP navigation (use gd, gD, etc. instead)
                -- gd - Go to definition (built-in)
                -- gD - Go to declaration (built-in)
                -- gi - Go to implementation (built-in)
                -- gr - Show references (built-in)
            end

                   -- LSP on_attach wrapper
                   local on_attach = function(client, bufnr)
                       _G.setup_lsp_keymaps(client, bufnr)
                       -- Visual indicator that LSP is attached
                       vim.notify(string.format('LSP attached: %s', client.name), vim.log.levels.DEBUG)
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

