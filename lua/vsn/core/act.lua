local utils = require "vsn.utils"

local act = utils.require_clean "nvim-ts-autotag"

local types = {
  "html",
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "svelte",
  "vue",
  "tsx",
  "jsx",
  "rescript",
  "xml",
  "php",
  "markdown",
  "glimmer",
  "handlebars",
  "hbs",
}
local skipTags = {
  "area",
  "base",
  "br",
  "col",
  "command",
  "embed",
  "hr",
  "img",
  "slot",
  "keygen",
  "link",
  "meta",
  "param",
  "source",
  "track",
  "wbr",
  "menuitem",
}
local config = {
  autotag = {
    enable = vsn.options.auto_close_tags,
    filetypes = types,
    skip_tags = skipTags,
  },
}
act.setup(config)
