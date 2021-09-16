#!/bin/sh
sudo docker build -t localhost:5001/zonemaster/engine ./ldns
sudo docker push localhost:5001/zonemaster/ldns
sudo docker build -t localhost:5001/zonemaster/engine ./engine
sudo docker push localhost:5001/zonemaster/engine
sudo docker build -t localhost:5001/zonemaster/cli ./cli
sudo docker push localhost:5001/zonemaster/cli
