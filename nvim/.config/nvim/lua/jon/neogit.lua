local nnoremap = require('jon.keymap').nnoremap
local neogit = require('neogit')

neogit.setup {}

nnoremap("<leader>gs", function()
    neogit.open({ })
end);

nnoremap("<leader>ga", "<cmd>!git fetch --all<CR>");
