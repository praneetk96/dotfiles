return {
    "williamboman/mason.nvim",
    --dependencies = {
        --"williamboman/mason-lspconfig.nvim",
        --"neovim/nvim-lspconfig"
    --},
    version = "*",
    config = function()
        --local mason  = require("mason").setup()
        local mason  = require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            },
            opts = {
                packages = { 'clang-format', 'clangd', 'cpplint', 'cpptools', 'debugpy', 'jq', 'json-lsp', 'jsonlint', 'lua-language-server', 'pyink', 'pylint', 'pyright', 'stylua', 'vim-language-server' }
            },
        })
    end
}
