local utils = require "vsn.utils"

local toggleterm = utils.require_clean "toggleterm"

local Terminal = utils.require_clean("toggleterm.terminal").Terminal

local config = {
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

function _G.set_term_keys()
  local option = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], option)
  vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], option)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], option)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], option)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], option)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], option)
end

vim.cmd "autocmd! TermOpen term://* lua set_term_keys()"

local lazygit = Terminal:new { cmd = "lazygit", hidden = true }

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local node = Terminal:new { cmd = "node", hidden = true }

function _NODE_TOGGLE()
  node:toggle()
end

local ncdu = Terminal:new { cmd = "ncdu", hidden = true }

function _NCDU_TOGGLE()
  ncdu:toggle()
end

local htop = Terminal:new { cmd = "htop", hidden = true }

function _HTOP_TOGGLE()
  htop:toggle()
end

local python = Terminal:new { cmd = "python", hidden = true }

function _PYTHON_TOGGLE()
  python:toggle()
end

toggleterm.setup(config)
