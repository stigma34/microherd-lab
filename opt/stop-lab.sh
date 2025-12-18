#!/bin/bash

##################################
#                                #
#      microherd autostart       #
#                                #
##################################

NAMESPACE=harvester-public

for w in $(kubectl get vms -n $NAMESPACE -l microherd=worker -o name | cut -d '/' -f2); do
  virtctl stop $w -n $NAMESPACE
done

for vm in $(kubectl get vms -n $NAMESPACE -l microherd=master -o name | cut -d '/' -f2); do
  virtctl stop $vm -n $NAMESPACE
done

virtctl stop rancher -n $NAMESPACE
