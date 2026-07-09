return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        PATH = "prepend",
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "clangd",
          "cssls",
          "gopls",
          "html",
          "jsonls",
          "lua_ls",
          "marksman",
          "pyright",
          "rust_analyzer",
          "sqlls",
          "ts_ls",
          "yamlls",
        },
        automatic_enable = false,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp", "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        bashls = {},
        clangd = {},
        cssls = {},
        gopls = {},
        html = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        marksman = {},
        pyright = {},
        rust_analyzer = {},
        sqlls = {},
        ts_ls = {},
        yamlls = {},
      }

      for server_name, server_opts in pairs(servers) do
        server_opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})
        lspconfig[server_name].setup(server_opts)
      end

      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        single_file_support = true,
        filetypes = {
          "css",
          "html",
          "javascript",
          "javascriptreact",
          "php",
          "templ",
          "typescript",
          "typescriptreact",
        },
      })
    end,
  },
}
