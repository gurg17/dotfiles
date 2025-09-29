return {
	'nvim-mini/mini.notify', 
	version = '*', 
	config = function ()
		require('mini.notify').setup()
		vim.notify('Error #1', vim.log.levels.ERROR)
	end
}
