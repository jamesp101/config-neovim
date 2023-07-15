-- Git related plugins
return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	{
		"akinsho/git-conflict.nvim",
		commit = "2957f74",
		config = function()
			require("git-conflict").setup({
				default_mappings = {
					ours = "co",
					theirs = "ct",
					none = "c0",
					both = "cb",
					next = "cn",
					prev = "cp",
				},
			})
		end,
	},
	{
		"wintermute-cell/gitignore.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim", },
		config = function()
			local g   = require("gitignore")
			local map = require('helpers.keys').map
			map('n', '<leader>gI',
				"<cmd>Gitignore .<CR>"
			)
		end
	},
	{
		'NeogitOrg/neogit',
		config = function()
			local neogit = require('neogit')
			neogit.setup()
			local map = require('helpers.keys').map
			map('n', '<leader>gg', function()
				neogit.open({})
			end)
		end
	}




}
