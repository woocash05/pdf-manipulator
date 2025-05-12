# Author           : Lukasz Steciuk ( s203666@student.pg.edu.pl )
# Created On       : 29.04.2025
# Last Modified By : Lukasz Steciuk ( s203666@student.pg.edu.pl )
# Last Modified On : 12.05.2025
# Version          : 1.0
#
# Description      : PDF manipulator: operations on files type PDF
# Opis
#
# Licensed under GPL (see /usr/share/common-licenses/GPL for more details
# or contact # the Free Software Foundation for a copy)

#!/bin/bash

while true; do
    akcja=$(zenity --list --title="Menu" \
      	    --column="Wybierz opcję" \
  	    "Połącz pliki PDF" \
  	    "Tworzenie dokumentu z wybranych stron plików" \
            "Wyjście")

    case "$akcja" in
	"Połącz pliki PDF")
  	./mergingv2.sh
  	zenity --info --text="Połączenie PDF - zakończono" ;;
 	"Tworzenie dokumentu z wybranych stron plików")
	./separatingv3.sh
  	zenity --info --text="Separacja stron - zakończono" ;;
	"Wyjście")
	break ;;
    *)
    esac
done
