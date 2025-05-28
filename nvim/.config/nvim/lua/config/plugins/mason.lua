return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig"
    },
    version = "*",
    config = function()
        local mason  = require("mason").setup()
    end
}
