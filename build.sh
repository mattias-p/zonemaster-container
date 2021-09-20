#!/bin/sh
sudo docker build -t zonemaster/ldns ./ldns
sudo docker build -t zonemaster/engine ./engine
sudo docker build -t zonemaster/cli ./cli
