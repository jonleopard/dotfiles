return {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
        require('gitsigns').setup()
    end
}


-- Old setup
-- require('gitsigns').setup {
--   signs = {
--     add = { hl = 'GitGutterAdd', text = '+' },
--     change = { hl = 'GitGutterChange', text = '~' },
--     delete = { hl = 'GitGutterDelete', text = '_' },
--     topdelete = { hl = 'GitGutterDelete', text = '‾' },
--     changedelete = { hl = 'GitGutterChange', text = '~' },
--   },
--   current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
--   current_line_blame_opts = {
--     virt_text = true,
--     virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
--     delay = 500,
--     ignore_whitespace = false,
--   },
-- }
