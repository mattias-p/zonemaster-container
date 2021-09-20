#!/bin/sh
sudo docker build --tag zonemaster/ldns --build-arg version=2.2.0 ./ldns
sudo docker build --tag zonemaster/engine --build-arg version=v4.2.2 ./engine
sudo docker build --tag zonemaster/cli --build-arg version=v3.5.0 ./cli
sudo docker run --rm --read-only --security-opt=no-new-privileges --cap-drop=ALL zonemaster/cli zonemaster.net
