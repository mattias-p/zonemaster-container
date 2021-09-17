#!/bin/sh
sudo docker build -t zonemaster/ldns:alpine ./ldns
sudo docker build -t zonemaster/engine:alpine ./engine
sudo docker build -t zonemaster/cli:alpine ./cli
