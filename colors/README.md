# colors


TLDR; change colors with `theme [base16 theme]`
```
$ theme nord
```

I'm using `base16` to handle colors. `base16-shell` enables you to change your
colorscheme via the commandline. Your colorscheme will be the same across
your development environment. Lightline and fzf are the only two places you'll need to update your colorschemes manually.

So, `base16` is being used for:
- Shell
- Vim (as well as lightline) 
- Tmux
- fzf

### Install base16-shell and color repos
I use my own forks since I am constantly pulling in and building the new themes
that get added to the base16 repos. Once you have `base16-shell` installed, just run `base16_` + `TAB` for a list of available colorschemes. 


```
git clone https://github.com/jonleopard/base16-shell.git ~/.config/base16-shell
```

#### Todo
- Add this to the setup script
- Automate the process of pulling in/updating new base16 themes. I'm using [base16-builder-go](https://github.com/belak/base16-builder-go)



#### Links:
- [base16](https://github.com/chriskempson/base16)
- [base16-fzf](https://github.com/fnune/base16-fzf)
- [base16-shell](https://github.com/jonleopard/base16-shell)
- [base16-vim](https://github.com/jonleopard/base16-vim)
- [base16-vim-lightline](https://github.com/jonleopard/base16-vim-lightline)
- [fzf match base16 theme](https://github.com/fnune/base16-fzf/issues/10)


Read this for more info on TrueColor support in Terminals.
https://gist.github.com/XVilka/8346728
