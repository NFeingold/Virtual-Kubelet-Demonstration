^+l::

InputBox, secret, Enter Secret, , 640, 480
if secret =
    Exit
Send, kubectl create secret generic my-secrets --from-literal=hub0-cs='%secret%' && kubectl --namespace kube-system create serviceaccount tiller && kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller && helm init --service-account tiller && cd iot-edge-virtual-kubelet-provider/src/charts/iot-edge-connector/ {Enter}

sleep, 10000 ;

Send, helm install -n hub0 --set rbac.install=true . && cd {Enter}

return 
