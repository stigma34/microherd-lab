#!/bin/bash

##################################
#                                #
#      microherd autostart       #
#                                #
##################################

### Define vars

NAMESPACE=harvester-public
KUBECONF=/root/microherd.yaml

### Start control-plane

for vm in $(kubectl get vms -n $NAMESPACE -l microherd=master -o name | cut -d '/' -f2); do
  virtctl start $vm -n $NAMESPACE
done

### Wait for API server to come up

until kubectl --kubeconfig=$KUBECONF cluster-info > /dev/null 2>&1; do
  sleep 5
done

### Wait for control-plane to be READY

kubectl --kubeconfig=$KUBECONF wait --for=condition=ready node -l node-role.kubernetes.io/control-plane --timeout=600s

### Start the workers

for w in $(kubectl get vms -n $NAMESPACE -l microherd=worker -o name | cut -d '/' -f2); do
  virtctl start $w -n $NAMESPACE
done

### 1m sleep to allow cluster to come up without sharing the load with Rancher

sleep 60

### Start rancher VM

virtctl start rancher -n $NAMESPACE
