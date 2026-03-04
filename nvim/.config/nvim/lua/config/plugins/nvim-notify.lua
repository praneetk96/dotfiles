return {
    'rcarriga/nvim-notify',
    lazy = false,
    priority = 1000,
    config = function()
        require("notify").setup({
            -- Animation style (see below for details)
            stages = "fade_in_slide_out",

            -- Render function for notifications. See notify-render()
            render = "compact",

            -- Default timeout for notifications
            timeout = 3000,

            -- For stages that change opacity this is treated as the highlight behind the window.
            -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
            background_colour = "#000000",

             -- Minimum width for notification windows
            minimum_width = 50,

            -- Icons for the different levels
            icons = {
                ERROR = "",
                WARN = "",
                INFO = "",
                DEBUG = "",
                TRACE = "✎",
            },
        })
        vim.notify = require("notify")
    end,
}
