-- UI components aggregator

local M = {}

-- Import feature modules
local tabs = require("config.ui.tabs")
local theme = require("config.ui.theme")
local file_explorer = require("config.ui.file-explorer")

-- Export safe close function for keymaps
M.safe_close_buffer = tabs.safe_close

-- Aggregate all plugins
M.plugins = {
  theme,
  file_explorer,
  tabs.plugin,
}

return M
