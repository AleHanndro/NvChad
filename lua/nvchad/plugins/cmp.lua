---@type LazySpec[]
return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = {
      {
        "onsails/lspkind.nvim",
        opts = {
          symbol_map = {
            Array = "  ",
            Boolean = " 󰨙 ",
            Class = " 󰯳 ",
            Codeium = " 󰘦 ",
            Collapsed = " > ",
            Color = " 󰰠 ",
            Constant = " 󰯱 ",
            Constructor = "  ",
            Control = "  ",
            Copilot = "  ",
            Enum = " 󰯹 ",
            EnumMember = " E ",
            Event = "  ",
            Field = "  ",
            File = "  ",
            Folder = "  ",
            Function = " 󰡱 ",
            Interface = " 󰰅 ",
            Key = "  ",
            Keyword = " 󱕴 ",
            Method = " 󰰑 ",
            Module = " 󰆼 ",
            Namespace = " 󰰔 ",
            Null = "  ",
            Number = " 󰰔 ",
            Object = " 󰲟 ",
            Operator = "  ",
            Package = " 󰰚 ",
            Property = " 󰲽 ",
            Reference = " 󰰠 ",
            Snippet = "  ",
            String = "  ",
            Struct = " 󰰣 ",
            TabNine = " 󰏚 ",
            Text = " 󱜥 ",
            TypeParameter = " 󰰦 ",
            Unit = " 󱜥 ",
            Value = "  ",
            Variable = " 󰫧 ",
          },
        },
        config = function(_, opts)
          require("lspkind").init(opts)
        end,
      },
      { "xzbdmw/colorful-menu.nvim", opts = {} },
      {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, update_events = "TextChanged,TextChangedI" },
        config = function(_, opts)
          local luasnip = require "luasnip"
          luasnip.config.set_config(opts)

          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_snipmate").lazy_load()

          -- fix luasnip #258
          vim.api.nvim_create_autocmd("InsertLeave", {
            callback = function()
              if luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] and not luasnip.session.jump_active then
                luasnip.unlink_current()
              end
            end,
          })
        end,
      },
    },
    opts = function()
      return require "nvchad.configs.blink"
    end,
    opts_extend = { "sources.default" },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
  },
}
