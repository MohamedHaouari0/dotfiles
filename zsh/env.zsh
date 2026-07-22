################################
# Environment Variables
################################

export EDITOR="vim"
export VISUAL="vim"

export PAGER="bat"

export MANPAGER="most"

export BROWSER="brave"

export TERMINAL="konsole"

export PATH="$HOME/.local/bin:$PATH"

export PATH="$HOME/go/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

################################
# FZF
################################

export FZF_DEFAULT_COMMAND='fd --type f'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_ALT_C_COMMAND='fd --type d'

export FZF_DEFAULT_OPTS='
--height=50%
--layout=reverse
--border
--info=inline
--prompt="❯ "
--pointer="▶"
--marker="✓"
'
