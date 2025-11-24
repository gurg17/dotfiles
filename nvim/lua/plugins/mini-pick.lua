return {
	'echasnovski/mini.pick',
	version = '*',
	keys = {
		{ "<leader><leader>", "<cmd>Pick files<cr>",                  desc = "Find Files" },
		{ "<leader>es",       "<cmd>Pick buffers<cr>",                desc = "Switch Buffer" },
		{ "<leader>sg",       "<cmd>Pick grep_live<cr>",              desc = "Live Grep" },
		{ "<leader>sw",       "<cmd>Pick grep pattern='<cword>'<cr>", desc = "Grep Word" },
	},
	config = function()
		require('mini.pick').setup()
	end
}
