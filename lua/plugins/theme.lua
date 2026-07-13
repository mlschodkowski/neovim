return {
  {
    "NTBBloodbath/doom-one.nvim",
    lazy = true,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = true,
    config = function()
      require("github-theme").setup({
        options = {
          transparent = false,
        },
      })
    end,
  },
}
