#!/bin/bash
#
## Pre-Schritt
#
## CSV-Datei mit den Testdaten

echo -e "Wofür möchten Sie einen Test starten?: \n(1) - Mittelwert/Median\n(2) - Solotest"
read choice

case "$choice" in
  1)

	csv_file="tables.csv"

	sum=0
	attenuation=0
	while IFS=';' read -r time value _; do
		if [ "$time" != "STOP" ]; then
			sum=$((sum + time))
			attenuation=$value
		fi
	done < "$csv_file"
	sum=$((sum/1000))

	echo "Der Versuch wird nun für $sum Sekunden gestartet.."
	#
	#        # Schritt 1: Starte den Iperf Server
	#
	sudo ip netns exec server iperf3 -s &
	iperf_server_pid=$!
	echo "IPerf Server gestartet.."
	#
	#        # Schritt 2: starte Attenuation
	#
	python attenuator.py -t /mnt/experiments/oli_valerius/tables.csv &
	#
	#        # Schritt 3: Verbinde den Client
	#


	sudo ip netns exec client iperf3 -c 10.10.1.3 -t $sum > /mnt/experiments/oli_valerius/mittelwert_median/data/iperf_result_"$attenuation"_db.txt

	#        # Schritt 4: beenden 

	sudo pkill -f "iperf3 -s"
	;;



  2)
  	csv_file="tables.csv"

	sum=0
	attenuation=0
	while IFS=';' read -r time value _; do
		if [ "$time" != "STOP" ]; then
			sum=$((sum + time))
			attenuation=$value
		fi
	done < "$csv_file"
	sum=$((sum/1000))

	echo "Der Versuch wird nun für $sum Sekunden gestartet.."
	#
	#        # Schritt 1: Starte den Iperf Server
	#
	sudo ip netns exec server iperf3 -s &
	iperf_server_pid=$!
	echo "IPerf Server gestartet.."
	#
	#        # Schritt 2: starte Attenuation
	#
	python attenuator.py -t /mnt/experiments/oli_valerius/tables.csv &
	#
	#        # Schritt 3: Verbinde den Client
	#
    sudo ip netns exec client iperf3 -c 10.10.1.3 -t $sum > /mnt/experiments/oli_valerius/solotest/iperf_results.txt
    sudo pkill -f "iperf3 -s"
	;;


esac