-- Buffer tabs at the top

local M = {}

-- Safe buffer close: never quits Neovim when closing last buffer
function M.safe_close(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  -- Count valid listed buffers
  local buffers = vim.tbl_filter(function(b)
    return vim.api.nvim_buf_is_valid(b) and vim.bo[b].buflisted
  end, vim.api.nvim_list_bufs())

  -- If this is the last buffer, create empty buffer first
  if #buffers <= 1 then
    vim.cmd("enew")
  else
    -- If deleting the current buffer, switch to another first
    if bufnr == vim.api.nvim_get_current_buf() then
      for _, b in ipairs(buffers) do
        if b ~= bufnr then
          vim.cmd("buffer " .. b)
          break
        end
      end
    end
  end

  -- Delete the target buffer
  if vim.api.nvim_buf_is_valid(bufnr) then
    vim.cmd("bd " .. bufnr)
  end
end

-- Plugin spec
M.plugin = {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  keys = {
    { "<leader>x", function() M.safe_close() end, desc = "Close buffer" },
  },
  opts = {
    options = {
      mode = "buffers",
      close_command = function(bufnr)
        M.safe_close(bufnr)
      end,
      right_mouse_command = function(bufnr)
        M.safe_close(bufnr)
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          text_align = "center",
          separator = true,
        },
      },
      show_buffer_close_icons = true,
      show_close_icon = false,
      separator_style = "thick",
      always_show_bufferline = true,
      indicator = {
        style = "none",
      },
    },
  },
}

return M
