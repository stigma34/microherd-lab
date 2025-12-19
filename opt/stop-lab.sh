#!/bin/bash

##################################
#                                #
#      microherd autostart       #
#                                #
##################################

NAMESPACE=harvester-public
KUBECTL=/var/lib/rancher/rke2/bin/kubectl
VIRTCTL=/usr/bin/virtctl

for w in $($KUBECTL get vms -n "$NAMESPACE" -l microherd=worker -o name | cut -d '/' -f2); do
  $VIRTCTL stop "$w" -n "$NAMESPACE"
done

for vm in $($KUBECTL get vms -n "$NAMESPACE" -l microherd=master -o name | cut -d '/' -f2); do
  $VIRTCTL stop "$vm" -n "$NAMESPACE"
done

$VIRTCTL stop rancher -n "$NAMESPACE"
