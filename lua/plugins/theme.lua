return {
	{
		"slugbyte/lackluster.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("lackluster")
			-- vim.cmd.colorscheme("lackluster-hack") -- my favorite
			-- vim.cmd.colorscheme("lackluster-mint")
		end,
	},
	{ "loctvl842/monokai-pro.nvim", lazy = false, priority = 1000 },
	{ "NTBBloodbath/doom-one.nvim", lazy = false, priority = 1000 },
}
