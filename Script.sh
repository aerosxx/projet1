#!/bin/bash

# Vérifie si Docker est installé
if ! command -v docker &> /dev/null
then
    echo "Docker n'est pas installé sur ce système. Veuillez l'installer."
    exit 1
fi

# Fonction pour démarrer les conteneurs Docker
start_containers() {
   
    docker-compose up -d
}

# Fonction pour arrêter les conteneurs Docker
stop_containers() {
    
    docker-compose down
}

# Vérifie si l'argument passé est "start" ou "stop"
if [ "$1" == "start" ]; then
    start_containers
elif [ "$1" == "stop" ]; then
    stop_containers
else
    echo "Utilisation : $0 [start|stop]"
    exit 1
fi
