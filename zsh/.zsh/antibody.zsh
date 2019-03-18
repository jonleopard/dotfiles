# Uncomment 2-3 when adding new plugins.
#source <(antibody init)
#antibody bundle < ~/.zsh/bundles.txt


# After installing new plugins, comment lines 1-2 and uncomment 7-8
source ~/.zsh/bundles.sh
antibody bundle < ~/.zsh/bundles.txt > ~/.zsh/bundles.sh

# Run line 8 in your console, this populates bundles.sh file with paths from
# our bundles.txt file
