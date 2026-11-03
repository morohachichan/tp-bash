#!/bin/bash
set -Eeuo pipefail

DOSSIER="${1:-./data}"
DEST="${2:-./backups}"

if [ ! -d "$DOSSIER" ]; then
    echo "Erreur : le dossier '$DOSSIER' n'existe pas" >&2
    exit 1
fi

mkdir -p "$DEST"
HORODATAGE=$(date +%Y-%m-%d_%H-%M-%S)
ARCHIVE="$DEST/backup_${HORODATAGE}.tar.gz"

tar -czf "$ARCHIVE" "$DOSSIER"
echo "$(date '+%F %T') Sauvegarde creee : $ARCHIVE"

# Delete backups older than 7 days
for fichier in "$DEST"/backup_*.tar.gz; do
    [ -e "$fichier" ] || continue
    if [ -n "$(find "$fichier" -mtime +7)" ]; then
        rm -f "$fichier"
        echo "$(date '+%F %T') Supprime (ancien) : $fichier"
    fi
done
