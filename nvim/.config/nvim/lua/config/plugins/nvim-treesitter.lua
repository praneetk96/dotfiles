return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    event = { "BufReadPre", "BufNewFile" },
    lazy = false, 
    build = ":TSUpdate",
    config = function()
        -- import nvim-treesitter plugin
        local treesitter = require("nvim-treesitter.configs")

        -- configure treesitter
        treesitter.setup({ -- enable syntax highlighting
        highlight = {
        enable = true,
        },
        -- enable indentation
        indent = { enable = true },
        -- ensure these language parsers are installed
        ensure_installed = {
            "bash",
            "c",
            "cmake",
            "comment",
            "css",
            "csv",
            "desktop",
            "diff",
            "fish",
            "gitignore",
            "haskell",
            "haskell_persistent",
            "html",
            "java",
            "javadoc",
            "javascript",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "powershell",
            "python",
            "query",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
        },
        incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
        },
        },
    })
    end,
}
