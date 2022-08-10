# init.vim

Since I am using neovim rather than Vim, I place all of my configuration inside init.lua instead of a .vimrc file. Vim plugin management is done with packer.

TODO: Add nvim lsp, lua documentation. I'll be slowly migrating more of this over to lua. I manage installation of LSP servers rather than using an installer such as [lsp-install](https://github.com/kabouzeid/nvim-lspinstall)

Plugin settings get registered inside of [init.vim](https://github.com/jonleopard/dotfiles/blob/master/nvim/.config/nvim/init.vim#L258). This calls [init.lua](https://github.com/jonleopard/dotfiles/blob/master/nvim/.config/nvim/lua/plugin-settings/init.lua), where the plugin files are initialized. This is a little messy but works for now.

Links:
* [neovim](https://github.com/neovim/neovim)
* [vim-plug](https://github.com/junegunn/vim-plug)
* [empty folder tracking in git](https://stackoverflow.com/questions/7229885/what-are-the-differences-between-gitignore-and-gitkeep)
