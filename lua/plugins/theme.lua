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
	{
		"NTBBloodbath/doom-one.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			-- Both Doom One variants leave the editor canvas to Ghostty, whose
			-- background opacity and blur provide the actual surface.
			vim.g.doom_one_transparent_background = true
		end,
	},
	{ "yazeed1s/oh-lucy.nvim", lazy = false, priority = 1000 },
	{ "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000 },
	{ "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
	{ "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 },
	{ "gbprod/nord.nvim", lazy = false, priority = 1000 },
	{ "scottmckendry/cyberdream.nvim", lazy = false, priority = 1000 },
	{ "sainnhe/everforest", lazy = false, priority = 1000 },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		opts = {
			styles = {
				italic = false,
			},
			disable_background = true,
		},
	},
	{ "Mofiqul/vscode.nvim", lazy = false, priority = 1000 },
	{ "olimorris/onedarkpro.nvim", lazy = false, priority = 1000 },
	{ "Mofiqul/dracula.nvim", lazy = false, priority = 1000 },
	{ "EdenEast/nightfox.nvim", lazy = false, priority = 1000 },
	{ "bluz71/vim-moonfly-colors", lazy = false, priority = 1000 },
	{ "craftzdog/solarized-osaka.nvim", lazy = false, priority = 1000 },
	{ "olivercederborg/poimandres.nvim", lazy = false, priority = 1000 },
	{
		"projekt0n/github-nvim-theme",
		lazy = false,
		priority = 1000,
		config = function()
			require("github-theme").setup({
				options = {
					transparent = true,
				},
			})
		end,
	},
	{ "marko-cerovac/material.nvim", lazy = false, priority = 1000 },
	{ "nyoom-engineering/oxocarbon.nvim", lazy = false, priority = 1000 },
	{ "oskarnurm/koda.nvim", lazy = false, priority = 1000 },
	{ "sainnhe/sonokai", lazy = false, priority = 1000 },
	{ "sainnhe/gruvbox-material", lazy = false, priority = 1000 },
	{ "sainnhe/edge", lazy = false, priority = 1000 },
	{ "Shatur/neovim-ayu", lazy = false, priority = 1000 },
	{ "ray-x/aurora", lazy = false, priority = 1000 },
	{ "AlexvZyl/nordic.nvim", lazy = false, priority = 1000 },
	{ "ficcdaf/ashen.nvim", lazy = false, priority = 1000 },
	{ "ramojus/mellifluous.nvim", lazy = false, priority = 1000 },
	{ "ribru17/bamboo.nvim", lazy = false, priority = 1000 },
	{ "dgox16/oldworld.nvim", lazy = false, priority = 1000 },
	{ "comfysage/evergarden", lazy = false, priority = 1000 },
	{ "vague2k/vague.nvim", lazy = false, priority = 1000 },
	{ "uhs-robert/oasis.nvim", lazy = false, priority = 1000 },
	{ "mcchrish/zenbones.nvim", dependencies = { "rktjmp/lush.nvim" }, lazy = false, priority = 1000 },
	{ "savq/melange-nvim", lazy = false, priority = 1000 },
	{ "nvimdev/zephyr-nvim", lazy = false, priority = 1000 },
	{ "miikanissi/modus-themes.nvim", lazy = false, priority = 1000 },
	{ "rockyzhang24/arctic.nvim", dependencies = { "rktjmp/lush.nvim" }, lazy = false, priority = 1000 },
	{ "rmehri01/onenord.nvim", lazy = false, priority = 1000 },
	{ "kvrohit/rasmus.nvim", lazy = false, priority = 1000 },
	{ "maxmx03/fluoromachine.nvim", lazy = false, priority = 1000 },
	{ "xero/evangelion.nvim", lazy = false, priority = 1000 },
	{ "shaunsingh/nord.nvim", lazy = false, priority = 1000 },
	{ "metalelf0/black-metal-theme-neovim", lazy = false, priority = 1000 },
	{ "jaredgorski/spacecamp", lazy = false, priority = 1000 },
	{ "Mofiqul/adwaita.nvim", lazy = false, priority = 1000 },
}
