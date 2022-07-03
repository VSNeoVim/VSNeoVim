local C = {}

C.capabilities = vim.lsp.protocol.make_client_capabilities()

C.setup = function()
  local signs = {
    {
      name = "DiagnosticSignError",
      text = " ",
    },
    {
      name = "DiagnosticSignWarn",
      text = " ",
    },
    {
      name = "DiagnosticSignHint",
      text = "",
    },
    {
      name = "DiagnosticSignInfo",
      text = " ",
    },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = {
      enable = true,
      prefix = " ",
      source = "always",
    },
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  vim.cmd [[
    highlight! DiagnosticLineNrError guibg=NONE guifg=#ec5f67 gui=bold
    highlight! DiagnosticLineNrWarn guibg=NONE guifg=#E5C07B gui=bold
    highlight! DiagnosticLineNrInfo guibg=NONE guifg=#61AFEF gui=bold
    highlight! DiagnosticLineNrHint guibg=NONE guifg=#98C379 gui=bold

    sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl=DiagnosticSignError numhl=DiagnosticLineNrError
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl=DiagnosticLineNrWarn numhl=DiagnosticLineNrWarn
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl=DiagnosticLineNrInfo numhl=DiagnosticLineNrInfo
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl=DiagnosticLineNrHint numhl=DiagnosticLineNrHint
  ]]
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

C.on_attach = function(client)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

C.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

return C
