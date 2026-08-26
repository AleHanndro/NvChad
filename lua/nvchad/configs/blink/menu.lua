local M = {}
local ui = require("nvconfig").ui.cmp
local atom_styled = ui.style == "atom" or ui.style == "atom_colored"

local menu_cols
if atom_styled or ui.icons_left then
  menu_cols = { { "kind_icon" }, { "label" }, { "kind" } }
else
  menu_cols = { { "label" }, { "kind_icon" }, { "kind" } }
end

---@type table<string, blink.cmp.DrawComponent>
M.components = {
  kind_icon = {
    text = function(ctx)
      local icons = require "nvchad.icons.lspkind"
      local icon = (icons[ctx.kind] or "󰈚")

      if atom_styled then
        icon = " " .. icon .. " "
      end

      return icon
    end,
  },
  kind = {
    highlight = function(ctx)
      return atom_styled and "comment" or ctx.kind
    end,
  },
}

---@type blink.cmp.CompletionMenuConfigPartial
M.menu = {
  border = atom_styled and "none" or "single",
  draw = {
    columns = menu_cols,
    components = M.components,
    padding = { atom_styled and 0 or 1, 1 },
  },
  scrollbar = false,
}

return M
