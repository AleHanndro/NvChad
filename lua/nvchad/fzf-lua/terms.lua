local M = {}

local function get_general_terms()
  local bufs = vim.api.nvim_list_bufs()
  local nvterms = vim.g.nvchad_terms or {}
  local result = {}

  for _, buf in ipairs(bufs) do
    local is_term = vim.bo[buf].buftype == "terminal"
    local is_not_fzf = vim.bo[buf].filetype ~= "fzf"
    if is_term and is_not_fzf and not nvterms[tostring(buf)] then
      result[tostring(buf)] = {}
    end
  end

  return result
end

M.pick_term = function()
  local fzf_lua = require "fzf-lua"

  vim.g.nvchad_terms = vim.g.nvchad_terms or {}
  local term_bufs = vim.tbl_extend("force", get_general_terms(), vim.g.nvchad_terms)
  local buffers = {}

  for buf_str, _ in pairs(term_bufs) do
    local buf = tonumber(buf_str)
    if buf and vim.api.nvim_buf_is_valid(buf) then
      local info = vim.fn.getbufinfo(buf)[1]
      local name = info.name ~= "" and vim.fn.fnamemodify(info.name, ":t") or "[Terminal]"
      table.insert(buffers, string.format("[%d] %s", buf, name))
    end
  end

  if #buffers == 0 then
    print "No terminal buffers are opened/hidden!"
    return
  end

  fzf_lua.fzf_exec(buffers, {
    prompt = " Pick Term> ",
    actions = {
      ["default"] = function(selected)
        if not selected or #selected == 0 then
          return
        end

        local bufnr_str = selected[1]:match "%[(%d+)%]"
        if not bufnr_str then
          return
        end

        local bufnr = tonumber(bufnr_str)

        if bufnr and vim.fn.bufwinid(bufnr) == -1 then
          local termopts = vim.g.nvchad_terms[bufnr_str]
          if termopts then
            require("nvchad.term").display(termopts)
          else
            vim.api.nvim_set_current_buf(bufnr)
          end
        end
      end,
    },
  })
end

return M
