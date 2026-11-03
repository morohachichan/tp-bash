#!/bin/bash
set -Eeuo pipefail

REPO_URL="${1:-}"
if [ -z "$REPO_URL" ]; then
    echo "Usage : $0 <url_du_depot>" >&2
    exit 1
fi

WORKDIR="$HOME/ci-workspace"
LOG="$HOME/ci.log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$1] $2" | tee -a "$LOG"
}

trap 'log ERROR "Erreur a la ligne $LINENO"' ERR

update_repo() {
    if [ -d "$WORKDIR/.git" ]; then
        log INFO "Mise a jour du depot (git pull)"
        git -C "$WORKDIR" pull
    else
        log INFO "Clonage du depot"
        git clone "$REPO_URL" "$WORKDIR"
    fi
}

run_tests() {
    log INFO "Test 1 : README present"
    [ -f "$WORKDIR/README.md" ] || { log ERROR "README.md manquant"; return 1; }

    log INFO "Test 2 : syntaxe des scripts .sh"
    for f in "$WORKDIR"/*.sh; do
        [ -e "$f" ] || continue
        bash -n "$f" || { log ERROR "Syntaxe invalide : $f"; return 1; }
    done
}

log INFO "=== Debut du pipeline ==="
update_repo
if run_tests; then
    log INFO "=== PIPELINE REUSSI ==="
    exit 0
else
    log ERROR "=== PIPELINE ECHOUE ==="
    exit 1
fi
