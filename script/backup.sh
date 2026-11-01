
#!/bin/bash

# Activer la gestion stricte des erreurs
set -Eeuo pipefail

# Récupérer le dossier à sauvegarder
DOSSIER="${1:-}"

# Définir le dossier de destination
DESTINATION="./backups"

# Vérifier si un dossier a été fourni
if [ -z "$DOSSIER" ]; then
    echo "Erreur : veuillez indiquer un dossier à sauvegarder." >&2
    exit 1
fi

# Vérifier si le dossier existe
if [ ! -d "$DOSSIER" ]; then
    echo "Erreur : le dossier '$DOSSIER' n'existe pas." >&2
    exit 1
fi

# Créer le dossier de sauvegarde
mkdir -p "$DESTINATION"

# Générer la date et l'heure
DATE=$(date +%Y-%m-%d_%H-%M-%S)

# Créer le nom de l'archive
ARCHIVE="$DESTINATION/backup_$DATE.tar.gz"

# Créer l'archive
tar -czf "$ARCHIVE" "$DOSSIER"

echo "Sauvegarde créée : $ARCHIVE"

# Supprimer les sauvegardes de plus de 7 jours
for fichier in "$DESTINATION"/*.tar.gz; do

    # Vérifier si des archives existent
    [ -e "$fichier" ] || continue

    # Supprimer les anciennes sauvegardes
    find "$fichier" -type f -mtime +7 -print -delete

done

echo "Nettoyage des anciennes sauvegardes terminé."

exit 0
