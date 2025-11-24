return {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    config = function()
        require('typescript-tools').setup({
            on_attach = function(client, bufnr)
                -- Validate buffer exists and has a valid name
                if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
                    return
                end
                
                local bufname = vim.api.nvim_buf_get_name(bufnr)
                if not bufname or bufname == '' then
                    return
                end
                
                -- Disable formatting (use conform.nvim)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
                
                -- Setup shared LSP keymaps (defined in keymaps.lua)
                _G.setup_lsp_keymaps(client, bufnr)
                
                -- TypeScript specific keymaps
                local opts = { buffer = bufnr, silent = true }
                vim.keymap.set('n', '<leader>lo', '<cmd>TSToolsOrganizeImports<cr>', vim.tbl_extend('force', opts, { desc = 'Organize Imports' }))
                vim.keymap.set('n', '<leader>li', '<cmd>TSToolsAddMissingImports<cr>', vim.tbl_extend('force', opts, { desc = 'Add Missing Imports' }))
                vim.keymap.set('n', '<leader>lu', '<cmd>TSToolsRemoveUnusedImports<cr>', vim.tbl_extend('force', opts, { desc = 'Remove Unused Imports' }))
                vim.keymap.set('n', '<leader>lx', '<cmd>TSToolsFixAll<cr>', vim.tbl_extend('force', opts, { desc = 'Fix All' }))
            end,
            handlers = {
                -- Suppress invalid buffer errors
                ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
                    if not result or not result.diagnostics or not result.uri then
                        return
                    end
                    
                    -- Validate buffer before processing
                    local ok, bufnr = pcall(vim.uri_to_bufnr, result.uri)
                    if not ok or not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
                        return
                    end
                    
                    -- Validate buffer has a valid name
                    local bufname = vim.api.nvim_buf_get_name(bufnr)
                    if not bufname or bufname == '' then
                        return
                    end
                    
                    -- Only process diagnostics if buffer is loaded
                    if not vim.api.nvim_buf_is_loaded(bufnr) then
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

