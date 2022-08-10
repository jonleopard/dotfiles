local Worktree = require("git-worktree")
require("git-worktree").setup({})


local function is_nrdp()
  return not not (string.find(vim.loop.cwd(), vim.env.NRDP, 1, true))
end

local M = {}
function M.execute(path, just_build)
    if is_nrdp(path) then
        local command = string.format(":silent !tmux-nrdp tmux %s %s", path, just_build)
        vim.cmd(command)
    end
end

Worktree.on_tree_change(function(_ --[[op]], path, _ --[[upstream]])
    M.execute(path.path)
end)

return M
