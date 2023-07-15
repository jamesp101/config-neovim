return {
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = function ()
			local term = require('toggleterm').setup()

			require("helpers.keys").map("n", "<leader>`", "<cmd>ToggleTerm<cr>", "Terminal")
		end,
	}
}
