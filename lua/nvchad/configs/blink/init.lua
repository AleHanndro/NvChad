dofile(vim.g.base46_cache .. "blink")

---@module 'blink-cmp'
---@type blink.cmp.Config
return {
  appearance = { nerd_font_variant = "normal" },
  cmdline = { enabled = true },
  fuzzy = { implementation = "prefer_rust" },
  -- Prefer Neovim's builtin signature_help keymap `<C-s>`
  signature = { enabled = false },
  snippets = { preset = "luasnip" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  keymap = {
    preset = "default",
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
  },

  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = { border = "single", scrollbar = false },
    },
    list = {
      selection = {
        auto_insert = function(ctx)
          return vim.bo[ctx.bufnr].filetype ~= "markdown"
        end,
        preselect = false,
      },
    },
    menu = require("nvchad.configs.blink.menu").menu,
  },
}
