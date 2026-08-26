local M = {}

M.diagnostic_config = function()
  local x = vim.diagnostic.severity

  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    virtual_text = { prefix = "" },
    float = { border = "single", source = "if_many" },
    signs = {
      text = {
        [x.ERROR] = "󰅙",
        [x.WARN] = "",
        [x.INFO] = "󰋼",
        [x.HINT] = "󰌵",
      },
    },
    underline = true,
  }
end

--- @type vim.lsp.client.on_init_cb
M.on_init = function(client, _)
  if client:supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.setup = function()
  dofile(vim.g.base46_cache .. "lsp")
  M.diagnostic_config()
  vim.lsp.config("*", { on_init = M.on_init })
end

return M
