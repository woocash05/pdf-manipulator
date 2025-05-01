#!/bin/bash

liczba=$(zenity --entry --title="Ile plików?" --text="Określ ile plików zamierzasz połączyć:")

if ! [[ "$liczba" =~ ^[0-9]+$ ]] || [ "$liczba" -lt 2 ]; then
	zenity --error --text="Liczba plików nie może być mniejsza od dwóch!"
	exit 1
fi


declare -a PLIKI

for ((i=1;i<=liczba;i++)); do
	plik=$(zenity --file-selection --title="Wybierz plik PDF nr $i" --file-filter="*.pdf")
	if [ -z "$plik" ]; then
		zenity --error --text="Nie wybrano pliku nr $i. Przerywam."
		exit 1
	fi
	PLIKI+=("$plik")
done

data=$(date +%Y-%m-%d_%H-%M-%S)
output="$HOME/Pulpit/duzy_projekt-pdfmani/merge_${data}.pdf"

pdfunite "${PLIKI[@]}" "$output"

if [ $? -eq 0 ]; then
	zenity --info --text="Pliki połączone jako: $output"
else
	zenity --error --text="Wystąpił błąd podczas łączenia plików."
fi
