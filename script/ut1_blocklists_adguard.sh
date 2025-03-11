#!/bin/bash

# Stel de lokale repository directory in
LOCAL_REPO_DIR="${GITHUB_WORKSPACE}/blocklists-adguard"

# Maak de directory aan als deze nog niet bestaat
mkdir -p "$LOCAL_REPO_DIR"

# Array van de UT1-blocklist URL's
UT1_BLOCKLIST_URLS=(
  "https://dsi.ut-capitole.fr/blacklists/download/adult.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/agressif.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/arjel.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/audio-video.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/bitcoin.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/chat.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/cryptojacking.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/dangerous_material.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/dating.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/ddos.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/dialer.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/doh.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/download.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/educational_games.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/games.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/hacking.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/manga.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/mixed_adult.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/mobile-phone.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/phishing.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/reaffected.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/redirector.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/remote-control.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/sexual_education.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/social_networks.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/strict_redirector.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/strong_redirector.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/tricheur.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/warez.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/vpn.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/webmail.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/gambling.tar.gz"
  "https://dsi.ut-capitole.fr/blacklists/download/drogue.tar.gz"
)

cd $LOCAL_REPO_DIR

# Loop door elke URL
for UT1_BLOCKLIST_URL in ${UT1_BLOCKLIST_URLS[@]}; do
  # Bestandsnaam voor de gedownloade blokkadelijst
  BLOCKLIST_FILE="$LOCAL_REPO_DIR/$(basename $UT1_BLOCKLIST_URL .tar.gz).txt"

  # Download de UT1-blokkadelijst
  wget -O ${BLOCKLIST_FILE}.tar.gz $UT1_BLOCKLIST_URL

  # Pak het tar.gz-bestand uit
  tar -xvzf ${BLOCKLIST_FILE}.tar.gz -C $LOCAL_REPO_DIR

  # Hernoem het 'domain'-bestand naar de naam van de lijst
  mv $LOCAL_REPO_DIR/$(basename $UT1_BLOCKLIST_URL .tar.gz)/domains $BLOCKLIST_FILE

  # Verwijder de uitgepakte map
  rm -r $LOCAL_REPO_DIR/$(basename $UT1_BLOCKLIST_URL .tar.gz)

  # Verwijder het tar.gz-bestand na het uitpakken
  rm ${BLOCKLIST_FILE}.tar.gz

  # Ga naar de lokale repository
  cd $LOCAL_REPO_DIR

  # Add regex for Adguard
  sed -i 's/^/||/; s|$|\^|' $BLOCKLIST_FILE
done


