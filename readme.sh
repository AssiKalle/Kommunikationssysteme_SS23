#!/bin/bash
echo ""
echo "1. Schritt:"
echo "- in der tables.csv die Zeit, sowie die Dämpfung eintragen"
echo "- Zeit;Dämpfung;Dämpfung;Dämpfung;Dämpfung"
echo "- am Ende \"STOP\" schreiben"
echo "Beispiel:"
echo "1000;30;30;30;30"
echo "STOP"
echo ""
echo "2. Schritt:"
echo "- start_test.sh starten"
echo "- (1) Mittelwert/Median"
echo "- (2) Solotest"
echo ""
echo "3. Schritt -> britfft nur Mittelwert & Median:"
echo "- calc_median_mittelwert.sh starten"
echo ""
echo "4. Schritt:"
echo "- plotten.sh starten"
echo "- (1) Mittelwert"
echo "- (2) Median"
echo "- (3) Solotest"
echo ""
echo "Wo sind die Bilder zu finden?"
echo "Median & Mittelwert -> \"/etc/mnt/experiments/oli_valerius/mittelwert_median/\""
echo "Solotest -> \"/etc/mnt/experiments/oli_valerius/output/\""
echo ""