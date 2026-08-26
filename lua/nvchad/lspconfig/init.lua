local M = {}

M.diagnostic_config = function()
  local x = vim.diagnostic.severity

  vim.diagnostic.config {
    float = { border = "single" },
    signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
    virtual_text = false,
  }
end

M.setup = function()
  dofile(vim.g.base46_cache .. "lsp")
  M.diagnostic_config()
  require "nvchad.lspconfig.autocmds"
end

return M
