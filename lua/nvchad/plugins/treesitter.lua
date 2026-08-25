---@type LazySpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      auto_install = true,
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "printf",
        "query",
        "vim",
        "vimdoc",
      },
    },
    config = function(_, opts)
      pcall(function()
        dofile(vim.g.base46_cache .. "syntax")
        dofile(vim.g.base46_cache .. "treesitter")
      end)

      require("nvchad.treesitter").setup(opts)
    end,
    opts_extend = { "ensure_installed" },
  },
}
