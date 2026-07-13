return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>jl",
      function()
        require("utils.jumplist").pick()
      end,
      desc = "Browse jump history",
    },
  },
}
