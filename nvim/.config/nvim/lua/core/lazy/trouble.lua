return {
    "folke/trouble.nvim",

    config = function()
        vim.keymap.set("n", "<leader>tt", function()
            require("trouble").toggle()
        end
        )

        vim.keymap.set("n", "[d", function()
            require("trouble").next({ skip_groups = true, jump = true })
        end
        )
        vim.keymap.set("n", "]d", function()
            require("trouble").previous({ skip_groups = true, jump = true })
        end
        )
        vim.keymap.set("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
            { silent = true, noremap = true }
        )
        vim.keymap.set("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>",
            { silent = true, noremap = true }
        )
        vim.keymap.set("n", "<leader>tl", "<cmd>TroubleToggle loclist<cr>",
            { silent = true, noremap = true }
        )
        vim.keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>",
            { silent = true, noremap = true }
        )
        vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
            { silent = true, noremap = true }
        )
    end
}
