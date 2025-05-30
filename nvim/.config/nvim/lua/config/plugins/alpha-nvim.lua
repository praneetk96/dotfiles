return {
    {
        "goolord/alpha-nvim",
        --dependencies = { 'echasnovski/mini.icons' },
        --dependencies = { 'nvim-tree/nvim-web-devicons' },
        dependencies = { 
            'nvim-tree/nvim-web-devicons',
            'MaximilianLloyd/ascii.nvim'
        },
        config = function()
            local alpha = require("alpha")
            local startify = require("alpha.themes.startify")
            
            startify.section.header.val = {	
                [[                                                                       ]],
                [[                                                                     ]],
                [[       ████ ██████           █████      ██                     ]],
                [[      ███████████             █████                             ]],
                [[      █████████ ███████████████████ ███   ███████████   ]],
                [[     █████████  ███    █████████████ █████ ██████████████   ]],
                [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
                [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
                [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
                [[                                                                       ]],
            }

            alpha.setup(startify.opts)
        end,
    },
}
