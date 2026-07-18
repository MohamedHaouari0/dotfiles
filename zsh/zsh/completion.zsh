################################
# Completion
################################

autoload -Uz compinit

# Store completion cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh

# Initialize completion
compinit

# Completion menu
zstyle ':completion:*' menu select

# Colors from LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Case insensitive
zstyle ':completion:*' matcher-list \
    'm:{a-z}={A-Za-z}' \
    'r:|=*' \
    'l:|=*'

# Group completions
zstyle ':completion:*' group-name ''

# Show descriptions
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'

# Process completion
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,comm"

# Directories first
zstyle ':completion:*' file-sort name

zstyle ':completion:*' format '%B%F{blue}Completing:%f%b %d'

zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
