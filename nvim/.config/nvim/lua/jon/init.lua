-- Core
require("jon.plugins")
require("jon.options")
require("jon.keymap")
require("jon.colors")

-- Plugins
require("jon.tmux")
require("jon.telescope")
require("jon.gitsigns")
require("jon.git-worktree")
require("jon.harpoon")
require("jon.neogit")

P = function(v)
	print(vim.inspect(v))
	return v
end

if pcall(require, "plenary") then
	RELOAD = require("plenary.reload").reload_module

	R = function(name)
		RELOAD(name)
		return require(name)
	end
end
