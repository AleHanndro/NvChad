local M = {}

local lspkind = require "lspkind"
local colorful_menu = require "colorful-menu"
local web_devicons = require "nvim-web-devicons"

local unknown_types = {
  link = true,
  socket = true,
  fifo = true,
  char = true,
  block = true,
  unknown = true,
}

---@module 'blink-cmp'
---@param ctx blink.cmp.DrawItemContext
local path_icon = function(ctx)
  local type = ctx.item.data.type
  local is_unknown = unknown_types[type]
  local icon, hl = web_devicons.get_icon(is_unknown and "" or ctx.label, is_unknown and "os" or type)

  return icon or ctx.kind_icon, icon and hl or ctx.kind_hl
end

---@type table<string, blink.cmp.DrawComponent>
M.components = {
  kind_icon = {
    text = function(ctx)
      if ctx.source_name == "Path" then
        local icon = path_icon(ctx)
        return icon
      end

      return lspkind.symbol_map[ctx.kind] or ctx.kind_icon
    end,
    highlight = function(ctx)
      if ctx.source_name == "Path" then
        local _, hl = path_icon(ctx)
        return hl
      end

      return ctx.kind_hl
    end,
  },
  label = {
    text = function(ctx)
      return colorful_menu.blink_components_text(ctx)
    end,
    highlight = function(ctx)
      return colorful_menu.blink_components_highlight(ctx)
    end,
  },
}

---@type blink.cmp.CompletionMenuConfigPartial
M.menu = {
  border = "single",
  draw = {
    columns = { { "kind_icon" }, { "label", gap = 1 } },
    components = M.components,
  },
  scrollbar = false,
}

return M
