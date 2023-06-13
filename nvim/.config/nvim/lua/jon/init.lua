-- Core
require("jon.set")
require("jon.remap")
--require("jon.plugins")

local augroup = vim.api.nvim_create_augroup
local JonGroup = augroup('Jon', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = JonGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
