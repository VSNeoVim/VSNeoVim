local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | source ~/.local/share/VSNeoVim/lua/VisualStudioNeovim/Core/plugins.lua | PackerSync
    autocmd BufWritePost config.lua source <afile> | source ~/.local/share/VSNeoVim/lua/VisualStudioNeovim/Core/plugins.lua | PackerSync
    autocmd BufWritePost dconf.lua source <afile> | source ~/.local/share/VSNeoVim/lua/VisualStudioNeovim/Core/plugins.lua | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

function is_enabled(extension)
  return vsn.configs[extension].enabled
end

-- Install your plugins here
return packer.startup(function(use)
  -- Have packer manage itself
  use "wbthomason/packer.nvim"
  -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/popup.nvim"
  -- Useful lua functions used ny lots of plugins
  use "nvim-lua/plenary.nvim"
  -- Icons
  use {"kyazdani42/nvim-web-devicons", disable = not is_enabled("TreeIcons")}
  -- File Browser
  use {"kyazdani42/nvim-tree.lua", disable = not is_enabled("FileExplorer")}
  -- BufferLine
  use {"akinsho/bufferline.nvim", disable = not is_enabled("BufferLine")}
  -- Buffer delete commands
  use "famiu/bufdelete.nvim"
  -- LuaLine ( status bar )
  use "nvim-lualine/lualine.nvim"
  -- Terminal
  use {"akinsho/toggleterm.nvim", disable = not is_enabled("Terminal")}
  -- Project
  use "ahmedkhalf/project.nvim"
  -- Speed up neovim startup
  use "lewis6991/impatient.nvim"
  -- IndentLine
  use {"lukas-reineke/indent-blankline.nvim", disable = not is_enabled("IndentLine")}
  -- Alpha
  use "goolord/alpha-nvim"
  -- This is needed to fix lsp doc highlighting
  use "antoinemadec/FixCursorHold.nvim"
  -- WhichKey
  use {"folke/which-key.nvim", disable = not is_enabled("WhichKey")}
  -- AutoCompletion with cmp
  use {"hrsh7th/nvim-cmp", disable = not is_enabled("CMP")}
  -- Buffer Completions
  use "hrsh7th/cmp-buffer"
  -- Path Completions
  use "hrsh7th/cmp-path"
  -- CmdLine Completions
  use "hrsh7th/cmp-cmdline"
  -- Snippet Completions
  use "saadparwaiz1/cmp_luasnip"
  -- LSP CMP
  use "hrsh7th/cmp-nvim-lsp"
  -- Snippet engine
  use "L3MON4D3/LuaSnip"
  -- A bunch of snippet to use
  use "rafamadriz/friendly-snippets"
  -- Language Server Protocol
  use {"neovim/nvim-lspconfig", disable = not is_enabled("LSP")}
  -- Installing language Server
  use {"williamboman/nvim-lsp-installer", disable = not is_enabled("LSPInstaller")}
  -- For formatters and linters
  use "jose-elias-alvarez/null-ls.nvim"
  -- Telescope
  use {"nvim-telescope/telescope.nvim", disable = not is_enabled("Telescope")}
  -- Neovim Colorizer
  use {"norcalli/nvim-colorizer.lua", disable = not is_enabled("Colorizer")}
  -- Tabnine cmp
  use { "tzachar/cmp-tabnine", run="./install.sh", disable = not is_enabled("Tabnine")}
  -- Tagbar
  use "simrat39/symbols-outline.nvim"
  -- Notifications
  use "rcarriga/nvim-notify"
  -- Maximizer
  use "szw/vim-maximizer"
  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", disable = not is_enabled("Treesitter")}
  -- Comments
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "numToStr/Comment.nvim"
  -- Autopairs
  use "windwp/nvim-autopairs"
  -- language server settings defined in json for
  use "tamago324/nlsp-settings.nvim"
  -- git signs
  use {"lewis6991/gitsigns.nvim", disable = not is_enabled("Git")}
  -- debugging
  use {"ttbug/DAPInstall.nvim", disable = not is_enabled("DAPInstall")}
  use {"mfussenegger/nvim-dap", disable = not is_enabled("DAP")}
  use {"rcarriga/nvim-dap-ui", disable = not is_enabled("DAPUI")}
  -- lazygit
  use {"kdheepak/lazygit.nvim", disable = not is_enabled("GitUi")}

  for _, extension in pairs(vsn.extensions) do
    use(extension)
  end

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)