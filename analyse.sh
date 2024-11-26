#!/bin/bash 

echo "Analyse en cours..."

# Vérifiez si le répertoire /analyses existe, sinon créez-le
if [ ! -d "/analyses" ]; then 
  echo "Création du répertoire /analyses"
  mkdir /analyses 
fi

echo "Exécution de grep..."
grep -i "error\|connection closed" /var/log/auth.log /var/log/syslog > "/analyses/warning-$(date +%A)"
grep_exit_status=$?

if [ $grep_exit_status -eq 0 ]; then
  echo "Grep terminé avec succès."
else
  echo "Grep a échoué avec le statut de sortie $grep_exit_status."
fi

