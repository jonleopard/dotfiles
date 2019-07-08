# makes color constants available
autoload -U colors

export BAT_THEME="base16"

# enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

# Use Base16 to swtich shell colors
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
