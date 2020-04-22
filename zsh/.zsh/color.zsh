# makes color constants available
autoload -U colors

export BAT_THEME="base16"

# enable colored output from ls, etc. on FreeBSD-based systems
# https://superuser.com/questions/700406/zsh-not-recognizing-ls-colors
# https://superuser.com/questions/528228/how-can-i-configure-the-color-of-ls-directory-under-zsh/530467#530467
# https://apple.stackexchange.com/questions/33677/how-can-i-configure-mac-terminal-to-have-color-ls-output
export CLICOLOR=1
#export LSCOLORS=ExFxCxDxBxegedabagacad


# Use Base16 to swtich shell colors
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
