return {
	{
		'phaazon/hop.nvim',
		branch = 'v2',
		config = function()
			local hop = require 'hop'.setup {
				keys = 'asdfghjkl;'
			}

			require("helpers.keys").map(
				{'n', 'v', 'i'},
				'<M-f>',
				'<cmd>HopChar1<CR>'
			)
		end
	}
}
