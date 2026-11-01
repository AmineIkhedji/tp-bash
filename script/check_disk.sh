
#!/bin/bash

# Définir le seuil (80% par défaut)
SEUIL=${1:-80}

# Récupérer le pourcentage d'espace disque utilisé sur /
UTILISATION=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

# Afficher le résultat
echo "Espace disque utilisé : ${UTILISATION}%"
echo "Seuil fixé : ${SEUIL}%"

# Vérifier si le seuil est dépassé
if [ "$UTILISATION" -ge "$SEUIL" ]; then
    echo "ALERTE : l'espace disque utilisé dépasse ou atteint le seuil !"
    exit 1
else
    echo "OK : l'espace disque est suffisant."
    exit 0
fi
