# tmux




## Info
- Plugin Manager: [tpm](https://github.com/tmux-plugins/tpm)
- [How do I use RGB Color?](https://github.com/tmux/tmux/wiki/FAQ#how-do-i-use-rgb-colour)


## Useful tips
- [fzf integration](https://github.com/junegunn/fzf/blob/master/bin/fzf-tmux)
- Truecolor support is a bit of a mess. Alacritty created their own profile to circumvent some of these issues, but `:checkhealth`  in `neovim` fails when using their profile. Instead, I've built a `tmux-256color` TERM profile using this [guide](https://gist.github.com/joshuarli/247018f8617e6715e1e0b5fd2d39bb6c). Alternatively, just use `screen-256color` and also something like `set-option -a terminal-overrides ",alacritty:RGB"` as your truecolor profile.
- Run `tmux info | grep -e RGB -e Tc` to see if you have either RGB oe Tc support. If you don't refer to [this.](https://stackoverflow.com/questions/51488920/backspace-not-working-in-tmux-command-prompt/68456561#68456561)
