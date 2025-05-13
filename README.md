# pdfmanipulator

**pdfmanipulator** to proste narzędzie graficzne do łączenia i rozdzielania plików PDF. Skrypt wykorzystuje `bash`, `zenity` oraz `poppler-utils`, umożliwiając użytkownikowi wygodną p>

## Funkcje

- Łączenie plików PDF – wybór wielu plików PDF i ich połączenie w jeden dokument.
- Tworzenie dokumentu z wybranych stron plików – możliwość podania zakresów stron z jednego lub wielu plików i zapisania ich do nowego pliku.
- Graficzny interfejs – oparte na Zenity; okna dialogowe.          

## Wymagania

- bash
- zenity
- pdfseparate i pdfunite (pakiet `poppler-utils`)

## Użycie

Uruchom skrypt główny:

```bash
./pdfmanipulator.sh


