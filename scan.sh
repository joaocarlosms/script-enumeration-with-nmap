#!/bin/bash

echo -n "ALVO [+] -> "
read alvo

echo -n "TIME 0-5 [+] -> "
read timing

echo "[=] SCANNING PORT TCP: "

sudo nmap -T$timing -sS $alvo > scanning_$alvo.txt

echo "---------------------------------------->" >> scanning_$alvo.txt

echo "[=] SCANNING PORT UDP: "
sudo nmap -T$timing -sU $alvo >> scanning_$alvo.txt

echo "---------------------------------------->" >> scanning_$alvo.txt

ports=$(awk '/^[0-9]+\/tcp/ {print $1} /^[0-9]+\/udp/ {print $1}' scanning_$alvo.txt | cut -d'/' -f1)

port_list=$(echo $ports | tr '\n' ',' | sed 's/,$//')

echo "[=] SCANNING SERVICE: "
sudo nmap -T$timing -sV -p $port_list $alvo >> scanning_$alvo.txt	

echo "---------------------------------------->" >> scanning_$alvo.txt

echo "[=] SCANNING OPERATION SYSTEM: "
sudo nmap -T$timing -O -p $port_list $alvo >> scanning_$alvo.txt 
