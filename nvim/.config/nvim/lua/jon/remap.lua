vim.g.mapleader   = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")



-- format
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

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
