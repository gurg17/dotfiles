return {
    {
        'williamboman/mason.nvim',
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
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            -- LSP Keymaps
            local on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, silent = true }
                
                -- <leader>g prefix - Navigation
                vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to Definition' }))
                vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Go to Declaration' }))
                vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = 'Go to Implementation' }))
                vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, vim.tbl_extend('force', opts, { desc = 'Go to Type Definition' }))
                vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'Show References' }))
                
                -- <leader>l prefix - Actions
                vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code Action' }))
                vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename Symbol' }))
                vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format({ async = true }) end, vim.tbl_extend('force', opts, { desc = 'Format Document' }))
                vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature Help' }))
                vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = 'Show Line Diagnostics' }))
                vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, vim.tbl_extend('force', opts, { desc = 'Diagnostics to Location List' }))
                
                -- Hover documentation
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Hover Documentation' }))
                
                -- Diagnostic navigation
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = 'Previous Diagnostic' }))
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'Next Diagnostic' }))
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
                            diagnostics = {
                                globals = { 'vim' }
                            },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file('', true),
                                checkThirdParty = false,
                            },
                            telemetry = {
                                enable = false,
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

