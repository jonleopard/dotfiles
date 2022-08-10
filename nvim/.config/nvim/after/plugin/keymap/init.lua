local Remap = require("jon.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap


---- UndoTree
nnoremap("<leader>u", ":UndotreeShow<CR>")

-- greatest remap ever
-- xnoremap("<leader>p", "\"_dP")

-- next greatest remap ever : asbjornHaland
-- nnoremap("<leader>y", "\"+y")
-- vnoremap("<leader>y", "\"+y")
-- nmap("<leader>Y", "\"+Y")

-- format
--keymap("n", "<leader>F", ":Format<cr>", opts)

---- Dirvish
--keymap("n", "<leader>e", ":wincmd v<bar> :Dirvish <bar> :vertical resize 30<CR>", opts)

-- Y yank rest of line
nnoremap("Y", "yg$")

-- Save
nnoremap("<leader>s", ":update")
nnoremap("<leader>w", ":update")

-- Quit
nnoremap("<leader>q", ":q")
nnoremap("<leader>Q", ":qa!")

-- Cancel
inoremap("<C-c>", "<Esc>")

---- Buffers
--keymap("n", "]b", ":bnext", opts)
--keymap("n", "[b", ":bprev", opts)

---- To open a new empty buffer
---- This replaces :tabnew which I used to bind to this mapping
--keymap("n", "<leader>T", ":enew<cr>", opts)

--nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
--nnoremap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
