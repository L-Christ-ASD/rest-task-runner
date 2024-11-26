#!/bin/bash


# Crée le répertoire /backup s'il n'existe pas
mkdir -p /backup

# Parcourt chaque répertoire utilisateur dans /home/
for dir in /home/*/; do
    # Extrait le nom de l'utilisateur à partir du chemin du répertoire
    user=$(basename "$dir")
    
    # Crée le nom du fichier de sauvegarde avec la date du jour
    backup_file="/backup/backup_${user}_$(date +%F).zip"
    
    # Compresse récursivement le répertoire utilisateur en un fichier zip
    zip -r "$backup_file" "$dir"
    
    # Applique des permissions restreintes au fichier de sauvegarde
    chmod 600 "$backup_file"
done

echo "Tous les répertoires utilisateurs dans /home/ ont été compressés et stockés dans /backup/ avec des permissions restreintes."

