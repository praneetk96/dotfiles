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
            }
        })
    end
}
