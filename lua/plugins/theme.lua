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
	{ "yazeed1s/oh-lucy.nvim", lazy = false, priority = 1000 },
	{ "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000 },
	{ "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
	{ "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 },
	{ "gbprod/nord.nvim", lazy = false, priority = 1000 },
	{ "scottmckendry/cyberdream.nvim", lazy = false, priority = 1000 },
	{ "sainnhe/everforest", lazy = false, priority = 1000 },
	{ "rose-pine/neovim", name = "rose-pine", lazy = false, priority = 1000 },
	{ "Mofiqul/vscode.nvim", lazy = false, priority = 1000 },
	{ "olimorris/onedarkpro.nvim", lazy = false, priority = 1000 },
	{ "Mofiqul/dracula.nvim", lazy = false, priority = 1000 },
	{ "EdenEast/nightfox.nvim", lazy = false, priority = 1000 },
	{ "bluz71/vim-moonfly-colors", lazy = false, priority = 1000 },
	{ "craftzdog/solarized-osaka.nvim", lazy = false, priority = 1000 },
	{ "olivercederborg/poimandres.nvim", lazy = false, priority = 1000 },
	{ "projekt0n/github-nvim-theme", lazy = false, priority = 1000 },
	{ "marko-cerovac/material.nvim", lazy = false, priority = 1000 },
	{ "nyoom-engineering/oxocarbon.nvim", lazy = false, priority = 1000 },
}
