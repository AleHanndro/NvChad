local group = vim.api.nvim_create_augroup("NvChadLsp", {})
local map = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    --- @param desc string
    local function opts(desc)
      return { buffer = args.buf, desc = "LSP " .. desc }
    end

    map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")
  end,
})
