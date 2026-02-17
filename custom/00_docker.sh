# Docker Compose Down
dcd() {
    docker compose down "$@"
}

# Docker Compose Up
# Added the -d flag by default as it's the most common use case
dcu() {
    docker compose up -d "$@"
}

# Docker Compose Logs
# Added --follow and --tail to make it actually useful for debugging
dcl() {
    if [ -z "$1" ]; then
        docker compose logs --follow --tail=100
    else
        docker compose logs --follow --tail=100 "$@"
    fi
}
