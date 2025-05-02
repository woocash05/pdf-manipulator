#!/bin/bash

file=$(zenity --file-selection --file-filter="*.pdf" --title="Wybierz plik PDF")

if [[ -z "$file" ]]; then
	zenity --error --text="Nie wybrano pliku"
	exit 1
fi

range=$(zenity --entry --title="Zakres" --text="Wprowadź zakres separacji stron np. 1-2,4,6-7")

if [[ ! "$range" =~ ^[0-9]+(-[0-9]+)?(,[0-9]+(-[0-9]+)?)*$ ]]; then
	zenity --error --text="Niepoprawny zakres."
	exit 1
fi

tempFiles=()

process_range() {
	start=$1
	end=$2
	tmpFile="tmp-${start}-${end}.pdf"
	pdfseparate -f "$start" -l "$end" "$file" "tmp-%d.pdf"
	for ((i=start; i<=end; i++)); do
		tempFiles+=("tmp-${i}.pdf")
	done
}

IFS=',' read -ra ranges <<< "$range"

for item in "${ranges[@]}"; do
	if [[ "$item" =~ ^([0-9]+)-([0-9]+)$ ]]; then
		start=${BASH_REMATCH[1]}
		end=${BASH_REMATCH[2]}
		if (( start > end )); then
			zenity --error --text="Niepoprawny zakres: $item (start > end)"
			exit 1
		fi
		process_range "$start" "$end"
	elif [[ "$item" =~ ^[0-9]+$ ]]; then
		process_range "$item" "$item"
	else
		zenity --error --text="Niepoprawny wpis w zakresie: $item"
		exit 1
	fi
done

data=$(date +%Y-%m-%d_%H-%M-%S)
output="$HOME/Pulpit/duzy_projekt-pdfmani/separate-merge_${data}.pdf"

pdfunite "${tempFiles[@]}" "$output"

rm -f "${tempFiles[@]}"

zenity --info --text="Zakończono operację.\nWygenerowano plik:\n$output"
