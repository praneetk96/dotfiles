return {
    "mason-org/mason.nvim",
    version = "*",
    config = function()
        local mason  = require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            },
        })
    end
}
