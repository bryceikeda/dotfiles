grab() {
    realpath "$1" | tr -d "\n" | xclip -selection clipboard
}

run_docker_cwd() {
    docker run --rm -it -u 1000:1000 -v $(realpath .):/workspace -w /workspace $1
}

run_root_docker_cwd() {
    docker run --rm -it -v $(realpath .):/workspace -w /workspace $1
}
