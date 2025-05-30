--local M = {
    --"nvim-treesitter/nvim-treesitter",
    --build = function()
        --require("nvim-treesitter.install").update({ with_sync = true })()
    --end,
--}

--return { M }


return {
    {
        "nvim-treesitter/nvim-treesitter", 
        branch = 'master', 
        lazy = false, 
        build = ":TSUpdate"
    },
}
