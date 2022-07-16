local utils = require "vsn.utils"
local packer = utils.require_clean "packer"

return packer.startup(function(use)
  -- packer
  use { "wbthomason/packer.nvim" }
  -- onedarker
  use { "vsneovim/onedarker.nvim" }
  -- icons
  use { "kyazdani42/nvim-web-devicons", disable = not is_enabled "useIcon" }
  -- alpha
  use { "goolord/alpha-nvim" }
  -- nvim-tree
  use { "kyazdani42/nvim-tree.lua", disable = not is_enabled "nvimTree" }
  -- autopairs
  use { "windwp/nvim-autopairs" }
  -- lspconfig
  use { "neovim/nvim-lspconfig", disable = not is_enabled "LSP" }
  use { "williamboman/nvim-lsp-installer", disable = not is_enabled "LSP" }
  use { "glepnir/lspsaga.nvim", disable = not is_enabled "LSP", commit = "ee3e0bc0d2f4d26fe2f3c3018856c3995a258ffc" }
  use { "jose-elias-alvarez/null-ls.nvim", disable = not is_enabled "LSP" }
  -- cmp
  use { "hrsh7th/cmp-nvim-lsp", disable = not is_enabled "CMP" }
  use { "hrsh7th/cmp-buffer", disable = not is_enabled "CMP" }
  use { "hrsh7th/cmp-path", disable = not is_enabled "CMP" }
  use { "hrsh7th/cmp-cmdline", disable = not is_enabled "CMP" }
  use { "hrsh7th/nvim-cmp", disable = not is_enabled "CMP" }
  use { "L3MON4D3/LuaSnip", disable = not is_enabled "CMP" }
  use { "saadparwaiz1/cmp_luasnip", disable = not is_enabled "CMP" }
  -- popup
  use { "nvim-lua/popup.nvim" }
  -- plenary
  use { "nvim-lua/plenary.nvim" }
  -- syntax highlighting (treesitter)
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", disable = not is_enabled "Treesitter" }
  -- fix cursor hold
  use { "antoinemadec/FixCursorHold.nvim" }
  -- notifications (notify)
  use { "rcarriga/nvim-notify" }
  use { "nvim-telescope/telescope.nvim", disable = not is_enabled "Telescope" }
  -- comment
  use { "JoosepAlviste/nvim-ts-context-commentstring" }
  use { "numToStr/Comment.nvim" }
  -- git
  use { "lewis6991/gitsigns.nvim", disable = not is_enabled "Git" }
  use { "kdheepak/lazygit.nvim", disable = not is_enabled "Git" }
  -- which-key
  use { "max397574/which-key.nvim", disable = not is_enabled "WhichKey" }
  -- project
  use { "ahmedkhalf/project.nvim" }
  -- bufferline
  use { "akinsho/bufferline.nvim", disable = not is_enabled "BufferLine" }
  -- statusline (bufferline)
  use { "nvim-lualine/lualine.nvim" }
  -- terminal
  use { "akinsho/toggleterm.nvim", disable = not is_enabled "Terminal", commit='8e6f938ed8eec7f988dc07aec2af148ad57c6d95' }
  -- tagbar
  use { "simrat39/symbols-outline.nvim" }
  -- debuging
  use { "rcarriga/nvim-dap-ui", disable = not is_enabled "DAP" }
  use { "mfussenegger/nvim-dap", disable = not is_enabled "DAP" }
  use { "ttbug/DAPInstall.nvim", disable = not is_enabled "DAP" }
  -- colorizer
  use { "norcalli/nvim-colorizer.lua", disable = not is_enabled "Colorizer" }
  -- tabnine
  use { "tzachar/cmp-tabnine", run = "./install.sh", disable = not is_enabled "Tabnine" }
  -- indentline
  use { "lukas-reineke/indent-blankline.nvim", disable = not is_enabled "IndentLine" }
  -- auto close tags
  use { "windwp/nvim-ts-autotag" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end)
