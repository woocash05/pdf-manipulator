# Author           : Lukasz Steciuk ( s203666@student.pg.edu.pl )
# Created On       : 29.04.2025
# Last Modified By : Lukasz Steciuk ( s203666@student.pg.edu.pl )
# Last Modified On : 29.04.2025
# Version          : 1.0
#
# Description      : PDF manipulator: operations on files type PDF
# Opis
#
# Licensed under GPL (see /usr/share/common-licenses/GPL for more details
# or contact # the Free Software Foundation for a copy)

#!/bin/bash

akcja=$(zenity --list --title="Menu" \
  --column="Wybierz opcję" \
  "Połącz pliki PDF" \
  "Rozdziel plik PDF" \
  "Wyjście")

case akcja in
 "Połącz pliki PDF")
  zenity --info --text="Połączenie PDF"
;;
 "Rozdziel plik PDF")
  zenity --info --text="Rozdzelenie PDF"
;;
 "Wyjście")
  echo "Zamknięto"
;;
*)
esac


