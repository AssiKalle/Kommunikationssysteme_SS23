#!/bin/bash

verzeichnis="/mnt/experiments/oli_valerius/mittelwert_median/data/"
zielverzeichnis="/mnt/experiments/oli_valerius/mittelwert_median/"

# Temporäre Datei erstellen oder leeren
> "$zielverzeichnis/mittelwert_median_temp"

# Durchgehen aller Dateien im Verzeichnis
for datei in "$verzeichnis"*
do
  if [ -f "$datei" ]; then
    echo "Bearbeite Datei: $datei"

    # Ignorieren der ersten 3 und letzten 4 Zeilen, Extrahieren der sechsten Spalte
    mittelwert=$(awk 'NR > 3 {data[NR]=$7" "$7} END {for(i=4;i<=NR-4;i++) sum += data[i]; print sum / 30 }' "$datei")
    # Extrahieren der Zahl aus dem Dateinamen
    zahl=$(echo "$datei" | grep -oE '[0-9]+' | head -n1)
    # Berechnung des Medians
    median=$(awk 'NR > 3 {data[NR]=$7} END {n=asort(data); if (n % 2) print data[(n+1)/2]; else print (data[n/2] + data[n/2+1])/2 }' "$datei")
	echo "Median: $median"
	echo "DB-Wert: $zahl"
    # Ausgabe des Mittelwerts in der Konsole
    echo "Mittelwert: $mittelwert"

    # Zusammenstellen der Zeile für die Ausgabedatei
    zeile="$mittelwert;$median;$zahl"

    # Die Ergebnisse in der temporären Datei anfügen
    echo "$zeile" >> "$zielverzeichnis/mittelwert_median_temp"

    echo "------------------------"
  fi
done

# Das Ergebnis in die endgültige Datei im Verzeichnis "/median" verschieben
sudo mv "$zielverzeichnis/mittelwert_median_temp" "$zielverzeichnis/output_data.txt"
