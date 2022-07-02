local C = {}

function C:init()
  require "vsn.lsp.lsp-saga"
  require "vsn.lsp.lsp-installer"
  require "vsn.lsp.null-ls"
  require("vsn.lsp.handlers").setup()
end

return C
