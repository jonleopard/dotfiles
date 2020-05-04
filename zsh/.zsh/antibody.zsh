# Using static loading method (https://getantibody.github.io/)
# Assuming you have your plugins defined in bundles.txt
# in your terminal, uncomment the next line, then reload
#antibody bundle < ~/.zsh/bundles.txt > ~/.zsh/bundles.sh

# Note that this will need to be done when adding a new plugin.

# TODO Document how to remove a plugin
# When removing a bundle, run:
# uncomment line 14 then run
# antibody purge [repo-name]
# finally, uncomment line 13, reload shell,

# After installing new plugins, recomment line 4 and reload.
source ~/.zsh/bundles.sh
