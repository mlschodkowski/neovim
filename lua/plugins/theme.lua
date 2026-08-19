local themes = {
	"personal",
	"claude-dark",
	"sora",
	"doom-one",
	"doom-one-darker",
	"onedarker",
	"golden_gate",
	"oxocarbon",
	"habamax",
	"vim",
	"kanagawa-wave-reduced",
	"kanagawa-dragon-reduced",
	"kanso",
	"kanso-zen",
	"kanso-ink",
	"kanso-mist",
	"kanso-pearl",
	"zenwritten",
	"github-monochrome-dark",
	"nightfox",
	"dayfox",
	"dawnfox",
	"duskfox",
	"nordfox",
	"terafox",
	"carbonfox",
	"nord",
	"nord-darker",
	"onenord",
	"onenord-darker",
	"nord-night",
	"nordic",
	"iceberg",
	"ashen",
	"carvion",
	"monoglow",
	"monoglow-z",
	"monoglow-lack",
	"monoglow-void",
	"mint-signal",
}

return {
	{
		"NTBBloodbath/doom-one.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"cocopon/iceberg.vim",
		lazy = false,
		priority = 1000,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
	},
	{
		"webhooked/kanso.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"zenbones-theme/zenbones.nvim",
		lazy = false,
		dependencies = { "rktjmp/lush.nvim" },
	},
	{
		"idr4n/github-monochrome.nvim",
		lazy = false,
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
	},
	{
		"shaunsingh/nord.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"rmehri01/onenord.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"ficcdaf/ashen.nvim",
		tag = "*",
		lazy = false,
		priority = 1000,
		opts = {
			colors = {
				background = "#211f1d",
				g_1 = "#f5eee6",
				g_2 = "#e8ded3",
				g_3 = "#d8c7bb",
				orange_glow = "#d97757",
				orange_blaze = "#d97757",
				orange_smolder = "#e68a68",
				orange_golden = "#d6b06d",
			},
		},
	},
	{
		"zitrocode/carvion.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"Aejkatappaja/sora",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function(_, opts)
			require("sora").setup(opts)
			vim.cmd.colorscheme("sora")
		end,
	},
	{
		"wnkz/monoglow.nvim",
		lazy = false,
		priority = 999,
		opts = {},
		config = function(_, opts)
			require("monoglow").load(opts)
			vim.cmd.colorscheme("mint-signal")
		end,
	},
	{
		"vague2k/huez.nvim",
		branch = "stable",
		event = "UIEnter",
		config = function()
			local curated = {}
			for _, name in ipairs(themes) do
				curated[name] = true
			end

			local excluded = {}
			for _, name in ipairs(vim.fn.getcompletion("", "color", true)) do
				if not curated[name] then
					table.insert(excluded, name)
				end
			end

			require("huez").setup({
				background = "dark",
				fallback = "mint-signal",
				exclude = excluded,
				suppress_messages = true,
				picker = {
					themes = {
						layout = "right",
						opts = {
							previewer = false,
							layout_config = {
								anchor = "NE",
								width = 0.32,
								height = 0.42,
								prompt_position = "top",
							},
						},
					},
				},
			})
		end,
	},
	{
		"erl-koenig/theme-hub.nvim",
		cmd = "ThemeHub",
		keys = {
			{ "<leader>fT", "<cmd>ThemeHub<CR>", desc = "Install theme" },
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			persistent = false,
		},
	},
}
