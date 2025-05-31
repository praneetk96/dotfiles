return {
    {
        "hrsh7th/cmp-nvim-lsp"
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            -- "octaltree/cmp-look",
            -- "uga-rosa/cmp-dictionary",
            -- "f3fora/cmp-spell",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
        local cmp = require("cmp")
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping.scroll_docs(-4),
                ["<S-Tab>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- For luasnip users.
            }, {
                { name = "buffer" },
                { name = "path" },
                -- { name = "look" },
                -- { name = "dictionary" },
                -- { name = "spell" },
            }),
        })
    end,
  },
}

--return {
    ---- Autocompletion
    --{
        --'hrsh7th/nvim-cmp',
        --dependencies = {
            --'hrsh7th/cmp-nvim-lsp',
            --'L3MON4D3/LuaSnip',
            --'saadparwaiz1/cmp_luasnip',
        --},
        --config = function()
            --local cmp = require('cmp')
            --local luasnip = require('luasnip')

            --cmp.setup({
                --snippet = {
                    --expand = function(args)
                        --luasnip.lsp_expand(args.body)
                    --end,
                --},
                --mapping = cmp.mapping.preset.insert({
                    --['<Tab>'] = cmp.mapping.select_next_item(),
                    --['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    --['<CR>'] = cmp.mapping.confirm({ select = true }),
                --}),
                --sources = {
                    --{ name = 'nvim_lsp' },
                    --{ name = 'luasnip' },
                --},
            --})
        --end,
    --},
    
    ---- LSP Config
    --{
        --'neovim/nvim-lspconfig',
        --config = function()
            --local lspconfig = require('lspconfig')
            --local capabilities = require('cmp_nvim_lsp').default_capabilities()

            ---- Python
            --lspconfig.pyright.setup {
                --capabilities = capabilities,
            --}

            ---- C/C++
            --lspconfig.clangd.setup {
                --capabilities = capabilities,
            --}
        --end,
    --},
--}
