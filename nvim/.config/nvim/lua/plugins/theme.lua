return {
    {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy", -- Load lualine after UI is ready
    opts = {
      options = {
        theme = "auto", -- Auto-detects colorscheme (e.g., solarized, dracula)
        component_separators = { left = "", right = "" }, -- Powerline-like separators
        section_separators = { left = "", right = "" }, -- Powerline arrows
        disabled_filetypes = { statusline = {}, winbar = {} }, -- Disable for specific filetypes if needed
        globalstatus = true, -- Single statusline for all windows
      },
      sections = {
        lualine_a = { "mode" }, -- Vim mode (e.g., NORMAL, INSERT)
        lualine_b = { "branch", "diff", "diagnostics" }, -- Git branch, diff, LSP diagnostics
        lualine_c = { "filename" }, -- File name
        lualine_x = { "encoding", "fileformat", "filetype" }, -- File details
        lualine_y = { "progress" }, -- Cursor position
        lualine_z = { "location" }, -- Line/column numbers
      },
      inactive_sections = { -- For inactive windows
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    },
},
    {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        -- load the colorscheme here
        vim.cmd([[colorscheme tokyonight]])
    end
}}
