local nnoremap = require("jon.keymap").nnoremap

local silent = { silent = true }



nnoremap("<leader>a", function() require("harpoon.mark").add_file() end, silent)
nnoremap("<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, silent)
nnoremap("<leader>tc", function() require("harpoon.cmd-ui").toggle_quick_menu() end, silent)


nnoremap("<C-h>", function() require("harpoon.ui").nav_file(1) end, silent)
nnoremap("<C-j>", function() require("harpoon.ui").nav_file(2) end, silent)
nnoremap("<C-k>", function() require("harpoon.ui").nav_file(3) end, silent)
nnoremap("<C-l>", function() require("harpoon.ui").nav_file(4) end, silent)

-- nnoremap("n", "<leader>th",":lua require(\"harpoon.term\").gotoTerminal(1)<CR>",opts)
-- nnoremap("n", "<leader>tj",":lua require(\"harpoon.term\").gotoTerminal(2)<CR>",opts)
-- nnoremap("n", "<leader>tk",":lua require(\"harpoon.term\").sendCommand(1, 1)<CR>",opts)
-- nnoremap("n", "<leader>tl",":lua require(\"harpoon.term\").sendCommand(1, 2)<CR>",opts)
