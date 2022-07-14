local C = {}

local options = { noremap = true, silent = true }

local modes = {
  insert_mode = "i",
  normal_mode = "n",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
}

local defaults = {
  insert_mode = {
    ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
    ["<A-k>"] = "<Esc>:m .-2<CR>==gi",
  },
  normal_mode = {
    ["<C-h>"] = "<C-w>h",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    ["<C-l>"] = "<C-w>l",
    ["H"] = "I",
    ["E"] = "A",
    ["S"] = ":bp!<CR>",
    ["L"] = ":bn!<CR>",
    ["<C-z>"] = ":undo<CR>",
    ["<C-y>"] = ":redo<CR>",
    ["<C-Up>"] = ":resize -2<CR>",
    ["<C-Down>"] = ":resize +2<CR>",
    ["<C-Left>"] = ":vertical resize +2<CR>",
    ["<C-Right>"] = ":vertical resize -2<CR>",
    ["<"] = "<Esc>:<<CR>",
    [">"] = "<Esc>:><CR>",
    ["<S-Tab>"] = "<Esc>:<<CR>",
    ["<Tab>"] = "<Esc>:><CR>",
    ["<C-n>"] = "<Esc>:NvimTreeToggle<CR>",
    ["<C-t>"] = "<Esc>:SymbolsOutline<CR>",
    ["<A-j>"] = "<Esc>:m .+1<CR>==",
    ["<A-k>"] = "<Esc>:m .-2<CR>==",
    ["<C-w>"] = "<Esc>:bdelete!<CR>",
  },
  visual_mode = {
    ["<"] = "<gv",
    [">"] = ">gv",
    ["<S-Tab>"] = "<gv",
    ["<Tab>"] = ">gv",
    ["H"] = "<home>",
    ["E"] = "<end>",
  },
  visual_block_mode = {
    ["<A-j>"] = ":m '>+1<CR>gv-gv",
    ["<A-k>"] = ":m '<-2<CR>gv-gv",
    ["H"] = "<home>",
    ["E"] = "<end>",
  },
  command_mode = {},
}

function C:getshortcuts()
  for i, k in pairs(defaults.insert_mode) do
    vim.keymap.set(modes.insert_mode, i, k, options)
  end
  for i, k in pairs(defaults.visual_mode) do
    vim.keymap.set(modes.visual_mode, i, k, options)
  end
  for i, k in pairs(defaults.visual_block_mode) do
    vim.keymap.set(modes.visual_block_mode, i, k, options)
  end
  for i, k in pairs(defaults.command_mode) do
    vim.keymap.set(modes.command_mode, i, k, options)
  end
  for i, k in pairs(defaults.normal_mode) do
    vim.keymap.set(modes.normal_mode, i, k, options)
  end
end

return C
