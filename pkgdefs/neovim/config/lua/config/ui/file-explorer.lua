-- File explorer (sidebar)
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
  },
  init = function()
    -- Auto-open on directory start (nvim .)
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function(data)
        local directory = vim.fn.isdirectory(data.file) == 1
        if directory then
          vim.cmd.cd(data.file)

          -- Wipe the directory buffer and create empty buffer
          local dir_buf = vim.api.nvim_get_current_buf()
          vim.cmd("enew")
          if vim.api.nvim_buf_is_valid(dir_buf) then
            vim.api.nvim_buf_delete(dir_buf, { force = true })
          end

          -- Now open neo-tree
          vim.cmd("Neotree show")
        end
      end,
    })
  end,
  opts = {
    close_if_last_window = false,
    enable_git_status = true,
    enable_diagnostics = false,
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      hijack_netrw_behavior = "open_current",
    },
    window = {
      position = "left",
      width = 30,
      mappings = {
        ["<cr>"] = "open",
        ["<esc>"] = "cancel",
      },
    },
  },
}
