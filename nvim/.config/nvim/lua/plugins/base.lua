return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {'nvim-lua/plenary.nvim'}
  },

  { 'echasnovski/mini.icons', version = '*' },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "lua", "javascript", "typescript", "tsx", "html", "css" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        layout_config = {
          vetiacal = {
            width = 0.5,
          }
        },
        indent = {
          enable = true
        },
      }
    end
  },

  

  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true, -- Replace netrw as the default file explorer
      view_options = {
        show_hidden = true, -- Show hidden files by default
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional: for file icons
    keys = {
      { "<leader>fe", "<cmd>Oil<CR>", desc = "Open Oil File Explorer" }, -- Keybinding to open Oil
    },
    lazy = false,
    cmd = "Oil", -- Load Oil when the :Oil command is used
  },


  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- Optional, for file icons
    },
    opts = {
      view = {
        adaptive_size = true,
        width = 30,
        side = "right",
      },
      renderer = {
        highlight_git = true,
        highlight_opened_files = "all",
        root_folder_modifier = ":t",
      },
      filters = {
        dotfiles = false,
      },
    },
    keys = {
      { "<leader>fd", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
      { "<leader>fr", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh NvimTree" },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      highlight = {
        before = "",
        keyword = "bg",
        after = "fg",
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]],
      },
    },
  },

}
