return {
	'echasnovski/mini.files', 
	version	= '*',
	config = function ()
		require('mini.files').setup()
		vim.keymap.set("n", "<leader>eb", "<cmd>lua MiniFiles.open()<cr>", { desc = "File Browser" })
	end
}
