local utils = require "vsn.utils"

local whichKey = utils.require_clean "which-key"

local config = {
  setup = {
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are CReated
      presets = {
        operators = false, -- adds help for operators like d, y, ...
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
      spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
    },
    icons = {
      breadCRumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
      sCRoll_down = "<c-d>", -- binding to scroll down inside the popup
      sCRoll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 3, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
  },

  opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when CReating keymaps
    noremap = true, -- use `noremap` when CReating keymaps
    nowait = true, -- use `nowait` when CReating keymaps
  },
  vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when CReating keymaps
    noremap = true, -- use `noremap` when CReating keymaps
    nowait = true, -- use `nowait` when CReating keymaps
  },
  -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
  -- see https://neovim.io/doc/user/map.html#:map-cmd
  vmappings = {
    ["/"] = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" },
  },
  mappings = {
    ["a"] = { "<cmd>Alpha<CR>", "Dashboard" },
    ["n"] = { "<cmd>ene <BAR> startinsert <CR>", "New File" },
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>qa!<CR>", "Quit" },
    ["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" },
    ["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" },
    ["f"] = { "<cmd>Telescope find_files", "Find File" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    b = {
      name = "Buffers",
      j = { "<cmd>BufferLinePick<CR>", "Jump" },
      f = { "<cmd>Telescope buffers<CR>", "Find" },
      b = { "<cmd>BufferLineCyclePrev<CR>", "Previous" },
      e = {
        "<cmd>BufferLinePickClose<CR>",
        "Pick which buffer to close",
      },
      h = { "<cmd>BufferLineCloseLeft<CR>", "Close all to the left" },
      l = {
        "<cmd>BufferLineCloseRight<CR>",
        "Close all to the right",
      },
      D = {
        "<cmd>BufferLineSortByDirectory<CR>",
        "Sort by directory",
      },
      L = {
        "<cmd>BufferLineSortByExtension<CR>",
        "Sort by language",
      },
    },
    d = {
      name = "Debug",
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
      g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
      p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
      s = { "<cmd>lua require('dapui').toggle()<cr>", "Start" },
      C = { "<cmd>lua require('dapui').close()<cr>", "Stop" },
      q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    },
    p = {
      name = "Packer",
      c = { "<cmd>PackerCompile<CR>", "Compile" },
      i = { "<cmd>PackerInstall<CR>", "Install" },
      s = { "<cmd>PackerSync<CR>", "Sync" },
      S = { "<cmd>PackerStatus<CR>", "Status" },
      u = { "<cmd>PackerUpdate<CR>", "Update" },
    },

    -- " Available Debug Adapters:
    -- "   https://miCRosoft.github.io/debug-adapter-protocol/implementors/adapters/
    -- " Adapter configuration and installation instructions:
    -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    -- " Debug Adapter protocol:
    -- "   https://miCRosoft.github.io/debug-adapter-protocol/
    -- " Debugging
    g = {
      name = "Git",
      j = { "<cmd>lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
      u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>",
        "Undo Stage Hunk",
      },
      o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
      b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
      C = {
        "<cmd>Telescope git_bcommits<CR>",
        "Checkout commit(for current file)",
      },
      d = {
        "<cmd>Gitsigns diffthis HEAD<CR>",
        "Git Diff",
      },
    },
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
      d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<CR>", "Buffer Diagnostics" },
      w = { "<cmd>Telescope diagnostics<CR>", "Diagnostics" },
      f = { "<cmd>lua vim.lsp.buf.formatting()", "Format" },
      i = { "<cmd>LspInfo<CR>", "Info" },
      I = { "<cmd>LspInstallInfo<CR>", "Installer Info" },
      n = { "<cmd>LspInstall ", "Install New Server" },
      j = {
        vim.diagnostic.goto_next,
        "Next Diagnostic",
      },
      k = {
        vim.diagnostic.goto_prev,
        "Prev Diagnostic",
      },
      l = { vim.lsp.codelens.run, "CodeLens Action" },
      q = { vim.diagnostic.setloclist, "Quickfix" },
      r = { vim.lsp.buf.rename, "Rename" },
      s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
      S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
        "Workspace Symbols",
      },
      e = { "<cmd>Telescope quickfix<CR>", "Telescope Quickfix" },
    },
    v = {
      name = "+VSNeoVim",
      c = {
        "<cmd>edit " .. get_config_dir() .. "/config.lua<CR>",
        "Edit config.lua",
      },
      f = {
        "<cmd>lua require('vsn.core.cf').find_vsneovim_files()<CR>",
        "Find VSNeoVim files",
      },
      g = {
        "<cmd>lua require('vsn.core.cf').grep_vsneovim_files()<CR>",
        "Grep VSNeoVim files",
      },
      k = { "<cmd>Telescope keymaps<CR>", "View VSNeoVim's keymappings" },
      I = {
        "<cmd>lua require('vsn.core.cf').view_vsneovim_changelog()<CR>",
        "View VSNeoVim's changelog",
      },
      l = { "<cmd>lua require('vsn.core.cf').vsneovim_cache_logs()<CR>", "View VSNeoVim cachelogs" },
      n = { "<cmd>lua require('telescope').extensions.notify.notify()<CR>", "View Notifications" },
    },
    s = {
      name = "Search",
      b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
      c = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
      f = { "<cmd>Telescope find_files<CR>", "Find File" },
      h = { "<cmd>Telescope help_tags<CR>", "Find Help" },
      H = { "<cmd>Telescope highlights<CR>", "Find highlight groups" },
      M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
      r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
      P = { "<cmd>Telescope projects<CR>", "Open Recent project" },
      R = { "<cmd>Telescope registers<CR>", "Registers" },
      t = { "<cmd>Telescope live_grep<CR>", "Find Text" },
      k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
      C = { "<cmd>Telescope commands<CR>", "Commands" },
      p = {
        "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<CR>",
        "Colorscheme with Preview",
      },
    },
    t = {
      name = "Terminal",
      n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
      u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
      t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
      p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
      f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
      h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
      v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    },
    T = {
      name = "Treesitter",
      i = { ":TSConfigInfo<CR>", "Info" },
    },
  },
}

whichKey.setup(config.setup)

local opts = config.opts
local vopts = config.vopts

local mappings = config.mappings
local vmappings = config.vmappings

whichKey.register(mappings, opts)
whichKey.register(vmappings, vopts)
