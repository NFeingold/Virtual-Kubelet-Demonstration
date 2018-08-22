#!/bin/bash

read -p "Resource Group: " res
read -p "IoT Hub Name: " hub
read -p "AKS Cluster Name: " aks
loc="eatus"
read -p "Node Count: " node


echo "Creating Resourse Group..."
az group create -n $res -l $loc

echo "Creating IoT Hub..."
az iot hub create -n $hub -g $res --sku s1 -l $loc

echo "Creating AKS Cluster..."
az aks create -g $res -n $aks -c $node --generate-ssh-keys

echo "Getting credentials..."
az aks get-credentials -n $aks -g $res

read -p "Please enter IoT Hub Connection String (primary): " secret

secret="'secret'"

kubectl create secret generic my-secrets --from-literal=hub0-cs=$secret

kubectl --namespace kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller
cd
cd iot-edge-virtual-kubelet-provider/src/charts/iot-edge-connector/

echo "Allowing tiller to get ready..."
sleep 30

helm install -n hub0 --set rbac.install=true .

kubectl get nodes
kubectl get pods

echo "If you recieved a warning Could Not Find Ready Tiller, wait a little and manually enter:"
echo " helm install -n hub0 --set rbac.install=true ."