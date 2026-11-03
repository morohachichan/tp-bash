# REPONSES.md : Questions de réflexion

## Exercice 2.1 : chmod 644
chmod 644 donne rw-r--r-- : le propriétaire peut lire et écrire, le groupe et les autres peuvent seulement lire. Le fichier n'est pas exécutable par son propriétaire, car il n'y a pas de droit x.

## Exercice 2.2 : guillemets autour de "$UTILISATION"
Les guillemets gardent la valeur en un seul argument, même si la variable est vide. Sans eux, un $UTILISATION vide donne [ -ge 80 ], ce qui provoque une erreur de syntaxe.

## Exercice 2.3 : sans set -Eeuo pipefail
Si tar échoue, le script continue à tort : il affiche « Sauvegarde créée » alors qu'aucune archive valide n'existe. Avec set -Eeuo pipefail, il s'arrête dès la première erreur et renvoie un code non nul.

## Exercice 2.4 : chemins absolus avec cron
Cron s'exécute dans un environnement minimal (répertoire courant = dossier personnel, PATH réduit). Un chemin relatif pointerait donc au mauvais endroit. Un chemin absolu désigne toujours le même emplacement.

## Exercice 2.5 : vrai pipeline CI
Étapes à ajouter : déclenchement automatique à chaque push, lint, build, vrais tests, analyse de sécurité, artefact, déploiement, notification.

Points de défaillance (codes de retour distincts) : clone en échec (réseau, authentification), tests en échec, build en échec, déploiement en échec, timeout, disque plein. L'outil de CI lit ces codes pour arrêter le pipeline (par exemple, ne pas déployer si les tests échouent).
