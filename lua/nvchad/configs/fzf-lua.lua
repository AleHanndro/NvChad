local actions = require "fzf-lua.actions"
local spec = require("lazy.core.config").plugins["fzf-lua"]
local opts = type(spec.opts) == "table" and spec.opts or {}

local remap_ctrl_g = {
  ["ctrl-g"] = false,
  ["alt-g"] = actions.grep_lgrep,
}
local default_grep_actions = opts.grep_curbuf and opts.grep_curbuf.actions
  or vim.tbl_deep_extend("force", remap_ctrl_g, opts.grep and opts.grep.actions or {})

---@module 'fzf-lua'
---@type fzf-lua.Config|{}
return {
  { "fzf-native", "hide" },
  grep = { actions = default_grep_actions },
  grep_curbuf = { actions = default_grep_actions },
  tags = { actions = remap_ctrl_g },
}
