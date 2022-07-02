local C = {}

local utils = require "vsn.utils"

local builtin = utils.require_clean "telescope.builtin"
local finders = utils.require_clean "telescope.finders"
local pickers = utils.require_clean "telescope.pickers"
local sorters = utils.require_clean "telescope.sorters"
local themes = utils.require_clean "telescope.themes"
local actions = utils.require_clean "telescope.actions"
local previewers = utils.require_clean "telescope.previewers"
local make_entry = utils.require_clean "telescope.make_entry"

function C.find_vsneovim_files(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    prompt_prefix = ">> ",
    prompt_title = "~ VSNeoVim files ~",
    cwd = get_runtime_dir(),
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.find_files(opts)
end

function C.grep_vsneovim_files(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    prompt_prefix = ">> ",
    prompt_title = "~ search VSNeoVim ~",
    cwd = get_runtime_dir(),
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.live_grep(opts)
end

function C.vsneovim_cache_logs(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    prompt_prefix = ">> ",
    prompt_title = "~ VSNeoVim CacheLogs ~",
    cwd = get_cache_dir(),
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.find_files(opts)
end

local copy_to_clipboard_action = function(prompt_bufnr)
  local _, action_state = utils.require_clean "telescope.actions.state"
  local entry = action_state.get_selected_entry()
  local version = entry.value
  vim.fn.setreg("+", version)
  vim.fn.setreg('"', version)
  vim.notify("Copied " .. version .. " to clipboard", vim.log.levels.INFO)
  actions.close(prompt_bufnr)
end

function C.view_vsneovim_changelog()
  local opts = themes.get_ivy {
    cwd = get_vsn_base_dir(),
  }
  opts.entry_maker = make_entry.gen_from_git_commits(opts)

  pickers.new(opts, {
    prompt_title = "~ VSNeoVim Changelog ~",

    finder = finders.new_oneshot_job(
      vim.tbl_flatten {
        "git",
        "log",
        "--pretty=oneline",
        "--abbrev-commit",
      },
      opts
    ),
    previewer = {
      previewers.git_commit_diff_as_was.new(opts),
    },

    --TODO: consider opening a diff view when pressing enter
    attach_mappings = function(_, map)
      map("i", "<enter>", copy_to_clipboard_action)
      map("n", "<enter>", copy_to_clipboard_action)
      map("i", "<esc>", actions._close)
      map("n", "<esc>", actions._close)
      map("n", "q", actions._close)
      return true
    end,
    sorter = sorters.generic_sorter,
  }):find()
end

function C.find_project_files()
  local ok = utils.require_clean(builtin.git_files)

  if not ok then
    builtin.find_files()
  end
end

return C
