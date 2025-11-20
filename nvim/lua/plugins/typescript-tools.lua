return {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    config = function()
        require('typescript-tools').setup({
            on_attach = function(client, bufnr)
                -- Disable ts_ls if typescript-tools is active
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
                
                local opts = { buffer = bufnr, silent = true }
                
                -- TypeScript specific keymaps
                vim.keymap.set('n', '<leader>lo', '<cmd>TSToolsOrganizeImports<cr>', vim.tbl_extend('force', opts, { desc = 'Organize Imports' }))
                vim.keymap.set('n', '<leader>li', '<cmd>TSToolsAddMissingImports<cr>', vim.tbl_extend('force', opts, { desc = 'Add Missing Imports' }))
                vim.keymap.set('n', '<leader>lu', '<cmd>TSToolsRemoveUnusedImports<cr>', vim.tbl_extend('force', opts, { desc = 'Remove Unused Imports' }))
                vim.keymap.set('n', '<leader>lx', '<cmd>TSToolsFixAll<cr>', vim.tbl_extend('force', opts, { desc = 'Fix All' }))
            end,
            settings = {
                separate_diagnostic_server = true,
                publish_diagnostic_on = 'insert_leave',
                expose_as_code_action = 'all',
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

