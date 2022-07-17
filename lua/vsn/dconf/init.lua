local C = {}

function C:load()
  require("vsn.dconf.settings").load_options()

  require("vsn.dconf.core"):load()
end

return C
