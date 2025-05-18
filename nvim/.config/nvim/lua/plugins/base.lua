return {{
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {'nvim-lua/plenary.nvim'}
},
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
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
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
                source = "always", -- Show the source of the diagnostic (e.g., lua_ls)
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
}
