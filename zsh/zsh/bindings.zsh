################################
# Keybindings
################################

bindkey -e

# Ctrl + Left
bindkey "^[[1;5D" backward-word

# Ctrl + Right
bindkey "^[[1;5C" forward-word

# Home
bindkey "^[[H" beginning-of-line

# End
bindkey "^[[F" end-of-line

# Delete
bindkey "^[[3~" delete-char

# Ctrl + Backspace
bindkey '^H' backward-kill-word

# Ctrl + U
bindkey '^U' backward-kill-line

# Ctrl + K
bindkey '^K' kill-line

# Ctrl + R
bindkey '^R' history-incremental-search-backward
