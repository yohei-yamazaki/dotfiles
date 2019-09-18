[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# bash_completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi
