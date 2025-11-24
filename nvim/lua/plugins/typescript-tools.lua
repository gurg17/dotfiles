return {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig', 'williamboman/mason-lspconfig.nvim' },
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    config = function()
        require('typescript-tools').setup({
            on_attach = function(client, bufnr)
                -- Validate buffer
                if not vim.api.nvim_buf_is_valid(bufnr) then
                    return
                end
                
                -- Disable formatting (use conform.nvim)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
                
                -- Setup shared LSP keymaps
                if _G.setup_lsp_keymaps then
                    _G.setup_lsp_keymaps(client, bufnr)
                else
                    -- Fallback if global function not defined yet
                    local opts = { buffer = bufnr, silent = true }
                    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code Action' }))
                    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename Symbol' }))
                    vim.keymap.set('n', '<leader>lf', function()
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
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Hover Documentation' }))
                    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = 'Previous Diagnostic' }))
                    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'Next Diagnostic' }))
                end
                
                -- TypeScript specific keymaps
                local opts = { buffer = bufnr, silent = true }
                vim.keymap.set('n', '<leader>lo', '<cmd>TSToolsOrganizeImports<cr>', vim.tbl_extend('force', opts, { desc = 'Organize Imports' }))
                vim.keymap.set('n', '<leader>li', '<cmd>TSToolsAddMissingImports<cr>', vim.tbl_extend('force', opts, { desc = 'Add Missing Imports' }))
                vim.keymap.set('n', '<leader>lu', '<cmd>TSToolsRemoveUnusedImports<cr>', vim.tbl_extend('force', opts, { desc = 'Remove Unused Imports' }))
                vim.keymap.set('n', '<leader>lx', '<cmd>TSToolsFixAll<cr>', vim.tbl_extend('force', opts, { desc = 'Fix All' }))
                
                -- Visual indicator that LSP is attached
                vim.notify('LSP attached: typescript-tools', vim.log.levels.DEBUG)
            end,
            handlers = {
                -- Suppress invalid buffer errors
                ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
                    if not result or not result.diagnostics then
                        return
                    end
                    -- Validate buffer before processing
                    local bufnr = vim.uri_to_bufnr(result.uri)
                    if not vim.api.nvim_buf_is_valid(bufnr) then
                        return
                    end
                    pcall(vim.lsp.handlers["textDocument/publishDiagnostics"], err, result, ctx, config)
                end,
            },
            settings = {
                separate_diagnostic_server = false,
                publish_diagnostic_on = 'insert_leave',
                expose_as_code_action = 'all',
                suppress_ts_errors = true,
                tsserver_file_preferences = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
            },
        })
    end
}

