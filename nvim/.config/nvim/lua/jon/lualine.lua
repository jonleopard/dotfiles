local current_theme_name = vim.g.colors_name

require 'lualine'.setup {
    options = {
        -- Auto theme should just default to whatever colors are found
        theme = current_theme_name
    }
}
