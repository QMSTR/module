#!/usr/bin/env bash

set -e

# Logging function
function __log() {
    echo "[$1] $2"
}

function __success() {
    __log "OK" "$1"
}

function __fail() {
    __log "FAIL" "$1"
    exit "$2"
}

# Test address connectivity
function __check_connectivity() {
    wget --spider -q "$1" # check
    local wgetreturn=$? # retrieving wget's return code
    if [[ $wgetreturn -eq 0 ]]; then
        __success "$1 is reachable"
    else
        __fail "$1 is not reachable" ${wgetreturn}
    fi
}

# All DGraph exposed addresses
dgraph_addresses=(
    alpha:8080
    ratel:8000
)

# Checking DGraph addresses
echo "Checking DGraph addresses: " "${dgraph_addresses[@]}"
for dgraph_address in "${dgraph_addresses[@]}"; do
    __check_connectivity "${dgraph_address}"
done

# All tests 
__success "All tests have passed"
