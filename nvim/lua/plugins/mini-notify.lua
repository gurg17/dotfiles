return {
	'echasnovski/mini.notify', 
	version = '*', 
	config = function ()
		local notify = require('mini.notify')
		notify.setup({
			content = {
				format = nil,
				sort = nil,
			},
			lsp_progress = {
				enable = true,
				duration_last = 1000,
			},
			window = {
				config = {},
				max_width_share = 0.382,
				winblend = 25,
			},
		})
		-- Override vim.notify to use mini.notify
		vim.notify = notify.make_notify()
	end
}
