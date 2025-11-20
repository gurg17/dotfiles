return {
    'echasnovski/mini.clue',
    version = '*',
    config = function()
        local miniclue = require('mini.clue')
        miniclue.setup({
            triggers = {
                -- Leader triggers
                { mode = 'n', keys = '<Leader>' },
                { mode = 'x', keys = '<Leader>' },

                -- Built-in completion
                { mode = 'i', keys = '<C-x>' },

                -- `g` key
                { mode = 'n', keys = 'g' },
                { mode = 'x', keys = 'g' },

                -- Marks
                { mode = 'n', keys = "'" },
                { mode = 'n', keys = '`' },
                { mode = 'x', keys = "'" },
                { mode = 'x', keys = '`' },

                -- Registers
                { mode = 'n', keys = '"' },
                { mode = 'x', keys = '"' },
                { mode = 'i', keys = '<C-r>' },
                { mode = 'c', keys = '<C-r>' },

                -- Window commands
                { mode = 'n', keys = '<C-w>' },

                -- `z` key
                { mode = 'n', keys = 'z' },
                { mode = 'x', keys = 'z' },

                -- Bracket navigation
                { mode = 'n', keys = '[' },
                { mode = 'n', keys = ']' },
            },

            clues = {
                -- Leader key groups (only group prefixes)
                { mode = 'n', keys = '<Leader>a', desc = '+AI' },
                { mode = 'n', keys = '<Leader>o', desc = '+AI Actions' },
                { mode = 'n', keys = '<Leader>e', desc = '+Explorer' },
                { mode = 'n', keys = '<Leader>g', desc = '+LSP Navigate' },
                { mode = 'n', keys = '<Leader>l', desc = '+LSP Actions' },
                { mode = 'n', keys = '<Leader>q', desc = '+Quit/Close' },
                { mode = 'n', keys = '<Leader>s', desc = '+Search' },
                { mode = 'n', keys = '<Leader>t', desc = '+Test' },
                { mode = 'n', keys = '<Leader>w', desc = '+Write/Save' },
                
                -- Built-in Vim clue generators
                miniclue.gen_clues.builtin_completion(),
                miniclue.gen_clues.g(),
                miniclue.gen_clues.marks(),
                miniclue.gen_clues.registers(),
                miniclue.gen_clues.windows(),
                miniclue.gen_clues.z(),
            },

            window = {
                delay = 500,
                config = {
                    width = 'auto',
                    border = 'rounded',
                },
            },
        })
    end
}

