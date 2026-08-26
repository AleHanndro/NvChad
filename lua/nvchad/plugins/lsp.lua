--- @type LazySpec[]
return {
  {
    "mason-org/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonLog",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonUpdate",
    },
    opts = function()
      dofile(vim.g.base46_cache .. "mason")

      return {
        ui = {
          icons = {
            package_installed = " ",
            package_pending = " ",
            package_uninstalled = " ",
          },
        },
      }
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      enable = {},
    },
    config = function(_, opts)
      require("nvchad.lspconfig").setup()
      vim.lsp.enable(opts.enable)
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    event = "User FilePost",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {},
    },
  },
}
