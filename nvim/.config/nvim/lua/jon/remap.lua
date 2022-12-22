vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Search:  keep cursor in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Format
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })


------ Dirvish
----keymap("n", "<leader>e", ":wincmd v<bar> :Dirvish <bar> :vertical resize 30<CR>", opts)

---- Y yank rest of line
--vim.keymap.set("Y", "yg$")

---- Save
--vim.keymap.set("<leader>s", ":update<CR>")
--vim.keymap.set("<leader>w", ":update<CR>")

---- Quit
--vim.keymap.set("<leader>q", ":q<CR>")
--vim.keymap.set("<leader>Q", ":qa!<CR>")

---- Cancel
--vim.keymap.set("<C-c>", "<Esc>")

---- Buffers
--keymap("n", "]b", ":bnext", opts)
--keymap("n", "[b", ":bprev", opts)

---- To open a new empty buffer
---- This replaces :tabnew which I used to bind to this mapping
--keymap("n", "<leader>T", ":enew<cr>", opts)

--nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
--nnoremap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

