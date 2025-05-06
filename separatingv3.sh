#!/bin/bash

numFiles=$(zenity --entry --title="Liczba plików" --text="Na ilu plikach PDF chcesz pracować?")

if ! [[ "$numFiles" =~ ^[1-9][0-9]*$ ]]; then
    zenity --error --text="Nieprawidłowa liczba."
    exit 1
fi

tempFiles=()

process_range() {
    local file="$1"
    local start="$2"
    local end="$3"
    pdfseparate -f "$start" -l "$end" "$file" "tmp-%d.pdf"
    for ((i=start; i<=end; i++)); do
        tempFiles+=("tmp-${i}.pdf")
    done
}

for ((n=1; n<=numFiles; n++)); do
    file=$(zenity --file-selection --file-filter="*.pdf" --title="Wybierz plik PDF ($n z $numFiles)")
    
    if [[ -z "$file" ]]; then
        zenity --error --text="Nie wybrano pliku PDF nr $n."
        exit 1
    fi

    range=$(zenity --entry --title="Zakres dla pliku $n" --text="Podaj zakres stron (np. 1-3,5,7-8)")

    if [[ ! "$range" =~ ^[0-9]+(-[0-9]+)?(,[0-9]+(-[0-9]+)?)*$ ]]; then
        zenity --error --text="Niepoprawny zakres dla pliku $n."
        exit 1
    fi

    IFS=',' read -ra ranges <<< "$range"

    for item in "${ranges[@]}"; do
        if [[ "$item" =~ ^([0-9]+)-([0-9]+)$ ]]; then
            start=${BASH_REMATCH[1]}
            end=${BASH_REMATCH[2]}
            if (( start > end )); then
                zenity --error --text="Zakres nieprawidłowy ($item): początek > koniec"
                exit 1
            fi
            process_range "$file" "$start" "$end"
        elif [[ "$item" =~ ^[0-9]+$ ]]; then
            process_range "$file" "$item" "$item"
        else
            zenity --error --text="Niepoprawny wpis w zakresie: $item"
            exit 1
        fi
    done
done

data=$(date +%Y-%m-%d_%H-%M-%S)
output="$HOME/Pulpit/duzy_projekt-pdfmani/separate-merge_${data}.pdf"

pdfunite "${tempFiles[@]}" "$output"

rm -f "${tempFiles[@]}"

zenity --info --text="Zakończono operację.\nWygenerowano plik:\n$output"
