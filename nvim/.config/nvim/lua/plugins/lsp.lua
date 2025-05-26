return {

  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        settings = {

          Lua = {
            runtime = {
              -- Use LuaJIT for Neovim
              version = "LuaJIT",
            },
            diagnostics = {
              -- Recognize the `vim` global to avoid "undefined global vim" warnings
              globals = { "vim" },
            },
            workspace = {
              -- Include Neovim runtime files for better autocompletion
              library = vim.api.nvim_get_runtime_file("", true),
              -- Disable third-party library checks to reduce noise
              checkThirdParty = false,
            },
            -- Optional: Disable telemetry
            telemetry = { enable = false },
          },

        },
      })
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      automatic_installation = true,
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_enable = true,
        ensure_installed = { "denols", "eslint", "lua_ls" }
      })

      vim.diagnostic.config({
        virtual_text = false, -- Disable inline virtual text
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰰱",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        },
        update_in_insert = false, -- Don’t update diagnostics while typing
        severity_sort = true, -- Sort by severity (errors first)
        float = {
          border = "rounded", -- Add borders to floating windows
          source = true, -- Show the source of the diagnostic (e.g., lua_ls)
          header = "", -- Optional: Customize header
          prefix = "", -- Optional: Customize prefix
        },
      })

      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          vim.diagnostic.open_float(nil, { focusable = false, scope = "line" })
        end,
      })

      vim.o.updatetime = 500 -- 500ms delay; adjust as needed
    end
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot", -- Lazy-load on :Copilot command
    event = "InsertEnter", -- Load when entering insert mode
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true, -- Automatically show suggestions
        debounce = 75, -- Debounce time in ms
        keymap = {
          accept = "<A-L>", -- Accept suggestion with Alt-l
          accept_word = "<A-l>", -- Disable word-by-word accept
          accept_line = false, -- Disable line-by-line accept
          next = "<A-]>",
          prev = "<A-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        ["*"] = true, -- Enable for all filetypes by default
        markdown = false, -- Disable for markdown (optional)
      },
      copilot_node_command = "node", -- Path to Node.js executable
      server_opts_overrides = {},
    }
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua", "hrsh7th/nvim-cmp" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "copilot" }, -- Add Copilot as a source
          { name = "buffer" },
          { name = "path" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
      })
    end,
  },

  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
}
