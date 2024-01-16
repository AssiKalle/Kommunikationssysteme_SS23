#!/bin/bash

echo -e "Was möchten Sie plotten: \n(1) - Mittelwert\n(2) - Median\n(3) - Solotest"
read choice

# Andere Teile des Skripts...

case "$choice" in
  1)
    awk 'NR > 0 {data[NR]=$1" "$2} END {for(i=0;i<=NR;i++);}' /mnt/experiments/oli_valerius/mittelwert_median/output_data.txt
    gnuplot << EOF
      set terminal png size 800,600
      set output 'mittelwert_median/mittelwert.png'
      set title 'IPerf - Mittelwert'
      set xlabel 'Dämpfung (db)'
      set ylabel 'Throughput (Mbits/sec)'
      set datafile separator ";"
      plot '/mnt/experiments/oli_valerius/mittelwert_median/output_data.txt' using 3:1 with lines title 'Throughput'
EOF
    echo "Das Diagramm wurde in /mittelwert_median/mittelwert.png erstellt."
    ;;

  2)
    awk 'NR > 0 {data[NR]=$1" "$2} END {for(i=0;i<=NR;i++);}' /mnt/experiments/oli_valerius/mittelwert_median/output_data.txt
    gnuplot << EOF
      set terminal png size 800,600
      set output 'mittelwert_median/median.png'
      set title 'IPerf - Median'
      set xlabel 'Dämpfung (db)'
      set ylabel 'Throughput (Mbits/sec)'
      set datafile separator ";"
      plot '/mnt/experiments/oli_valerius/mittelwert_median/output_data.txt' using 3:2 with lines title 'Throughput'
EOF
    echo "Das Diagramm wurde in /mittelwert_median/median.png erstellt."
    ;;

  3)
    awk 'NR > 3 {data[NR]=$3" "$7} END {for(i=4;i<=NR-4;i++) print data[i]}' solotest/iperf_results.txt > solotest/iperf_data.txt

    gnuplot << EOF
      set terminal png size 800,600
      set output 'solotest/iperf_plot.png'
      set title 'Iperf - Solotest'
      set xlabel 'Time (seconds)'
      set ylabel 'Throughput (Mbits/sec)'
      plot 'solotest/iperf_data.txt' with lines title 'Throughput'
EOF

    echo "Das Diagramm wurde in /solotest/iperf_plot.png erstellt."
    ;;
esac
