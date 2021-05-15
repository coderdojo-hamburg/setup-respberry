#!/bin/bash



cd ./shell/
i=0
s=1
#Alle installations dateien zum array hinzufügen so dass sie für den dialog richtig sind.
for f in *.sh   
do
    files[i]="$f"
    files[i+1]=""
    files[i+2]="OFF"
    ((i+=3))
    ((s++))
done

#Terminal größen für die richtige dialog größe berechnen.
WIDTH=$(tput cols)
HEIGHT=$(tput lines)

HEIGHT=$(($HEIGHT-8))
WIDTH=$(($WIDTH-8))

#Dialog für die auswahl von den installierbaren packeten
INSTALLATIONS=$(whiptail --backtitle "Installationen Auswählen" --title "Instalationen Auswählen" \
    --checklist "Bitte wähle alle Installationen aus die durchgeführt werden sollen." $HEIGHT $WIDTH $(($HEIGHT/2)) "${files[@]}" 3>&1 1>&2 2>&3)

#Nochmal bestätigen lassen.
if ! (whiptail --title "Bestätigung" --yesno "Folgende Installationen werden ausgeführt:\n$INSTALLATIONS" 8 78); then
    exit
fi
echo "Für die installation werden root-rechte benötigt."

#Alle ausgewählten installations dateien als root ausführen.
for file in $INSTALLATIONS
do
    eval "sudo ./$file"
done
exit