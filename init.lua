local VisualStudioNeovim = {
  -- Core
  options = "VisualStudioNeovim.dconf.options",
  keymaps = "VisualStudioNeovim.dconf.keymaps",
  plugins = "VisualStudioNeovim.dconf.plugins",
  cursor = "VisualStudioNeovim.dconf.cursor",
}
local Configs = {
  -- Configs
  FileExplorer = "VisualStudioNeovim.Configs.FileExplorer",
  BufferLine = "VisualStudioNeovim.Configs.BufferLine",
  LuaLine = "VisualStudioNeovim.Configs.LuaLine",
  Terminal = "VisualStudioNeovim.Configs.Terminal",
  Project = "VisualStudioNeovim.Configs.Project",
  Impatient = "VisualStudioNeovim.Configs.Impatient",
  IndentLine = "VisualStudioNeovim.Configs.IndentLine",
  Alpha = "VisualStudioNeovim.Configs.Alpha",
  WhichKey = "VisualStudioNeovim.Configs.WhichKey",
  CMP = "VisualStudioNeovim.Configs.CMP",
  LSP = "VisualStudioNeovim.Configs.LSP",
  Tlescope = "VisualStudioNeovim.Configs.Telescope",
  Colorizer = "VisualStudioNeovim.Configs.Colorizer",
  Notification = "VisualStudioNeovim.Configs.Notification",
  Treesitter = "VisualStudioNeovim.Configs.Treesitter",
  Comments = "VisualStudioNeovim.Configs.Comments",
  Autopairs = "VisualStudioNeovim.Configs.Autopairs",
  Gitsigns = "VisualStudioNeovim.Configs.Gitsigns",
  SymbolsOutline = "VisualStudioNeovim.Configs.SymbolsOutline",
  DAP = "VisualStudioNeovim.Configs.DAP",
  LazyGit = "VisualStudioNeovim.Configs.LazyGit",
}


require("VisualStudioNeovim.dconf.dconf")
require("VisualStudioNeovim.dconf.utils")

for _,v in pairs(VisualStudioNeovim) do
  pcall(require, v)
end
for _,v in pairs(Configs) do
  pcall(require, v)
end
