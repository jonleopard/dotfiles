# makes color constants available
autoload -U colors

# For bat
export BAT_THEME="base16-256"

# Use base16-shell to swtich shell colors
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"


# This command will set the base16 theme for shell, vim, bat, lightline, and fzf. Use this
# instead of the `base16_` command because that only sets shell, and vim.

# TODO: I am installing https://github.com/fnune/base16-fzf as a zsh plugin so
# that it gets updated when I run `antibody update`. This is why source path is
# so long.
# Alternative is to clone repo into ~/.config/base16-fzf.


function theme() {
  if [ -z $1 ]; then
    echo 'Please pass one argument: the name of the base16 theme you want to use.'
    echo 'For example: `theme tomorrow`'
    return 1
  fi
  eval "base16_$1"
  eval "source ~/Library/Caches/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-fnune-SLASH-base16-fzf/bash/base16-$1.config"
}

# enable colored output from ls, etc. on FreeBSD-based systems
# https://superuser.com/questions/700406/zsh-not-recognizing-ls-colors
# https://superuser.com/questions/528228/how-can-i-configure-the-color-of-ls-directory-under-zsh/530467#530467
# https://apple.stackexchange.com/questions/33677/how-can-i-configure-mac-terminal-to-have-color-ls-output
export CLICOLOR=1
#export LSCOLORS=ExFxCxDxBxegedabagacad
