################################
# Navigation

mkcd() {
    mkdir -p "$1" && cd "$1"
}

up() {
    local d=""
    local limit=${1:-1}

    for ((i=1;i<=limit;i++)); do
        d+="../"
    done

    cd "$d"
}

croot() {
    cd ~/Projects
}

################################


################################
# Files

swap() {
    local TMP=$(mktemp)

    mv "$1" "$TMP"
    mv "$2" "$1"
    mv "$TMP" "$2"
}

backup() {
    cp "$1" "$1.bak"
}

count() {
    find . -maxdepth 1 | wc -l
}

filesize() {
    du -sh "$1"
}

################################


################################
# Archives

extract() {
    if [[ ! -f "$1" ]]; then
        echo "File not found."
        return 1
    fi

    case "$1" in
        *.tar.bz2) tar -xjf "$1" ;;
        *.tar.gz) tar -xzf "$1" ;;
        *.tar.xz) tar -xJf "$1" ;;
        *.zip) unzip "$1" ;;
        *.rar) unrar x "$1" ;;
        *.7z) 7z x "$1" ;;
        *) echo "Unsupported archive." ;;
    esac
}

################################


################################
# Git

gac(){
    git add .
    git commit -m "$1"
}

gclone() {
    git clone "$1"
    cd "$(basename "$1" .git)"
}

gitclean() {
    git branch --merged | grep -v "\*" | xargs -r git branch -d
}

gbranch() {
    git branch --show-current
}

newrepo() {
    mkdir -p "$1" || return
    cd "$1" || return
    git init
}

gitall() {
    for dir in */.git; do
        (
            cd "${dir%/.git}" || exit
            echo "Updating $(pwd)"
            git pull
        )
    done
}

################################

################################
# Docker

dclean() {
    docker system prune -af
}

dps() {
    docker ps -a
}

dlogs() {
    docker logs -f "$1"
}

################################

################################
# Networking

myip() {
    curl ifconfig.me
    echo
}

localip() {
    ip -4 addr
}

netports() {
    ss -tulpen
}

pingg() {
    ping google.com
}
################################

################################
# Development

serve() {
    python3 -m http.server "${1:-8000}"
}

cpp() {
    g++ "$1" -std=c++20 -Wall -Wextra -Werror
}

cbuild() {
    gcc *.c -Wall -Wextra -Werror
}

makeclean() {
    make clean
    make fclean
}


################################

################################
# Utilities

weather() {
    curl wttr.in
}

timer() {
    sleep "$1"
    notify-send "Done!"
}

stopwatch() {
    local start=$(date +%s)

    read

    local end=$(date +%s)

    echo "$((end-start)) seconds"
}

randpass() {
    openssl rand -base64 "${1:-24}"
}
################################

################################
# Project Helper

new42() {
    mkdir -p ~/Projects/42/"$1"
    cd ~/Projects/42/"$1"
}

newpersonal() {
    mkdir -p ~/Projects/Personal/"$1"
    cd ~/Projects/Personal/"$1"
}

#################################
