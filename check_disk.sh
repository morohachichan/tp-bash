#!/bin/bash
SEUIL="${1:-80}"
UTILISATION=$( df / | awk 'NR==2 {print $5}' | tr -d '%')
if [ "$UTILISATION" -ge "$SEUIL" ]; then
 echo "ALERTE : disque a ${UTILISATION}% (seuil : $(SEUIL)%)"
exit 1
else 
 echo "OK : disque a ${UTILISATION}ù (seuil : $(SEUIL)%)"
exit 0
fi
