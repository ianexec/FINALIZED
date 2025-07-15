#!/bin/bash

   clear
   echo -e "\e[92;1m install shellbot \e[0m"
   wget https://raw.githubusercontent.com/ianexec/FINALIZED/main/LTbotVPN/SHELLBOT
    unzip SHELLBOT
    mv LTBOTVPN /usr/bin
    chmod +x /usr/bin/LTBOTVPN/*
    # HAPUS EXTRAK
    rm -rf SHELLBOT
      
