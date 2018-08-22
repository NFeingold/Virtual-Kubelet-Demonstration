# Common Issues and Solutions

Virtual Kubelet is **still in development** and is **not yet ready for full scale production.** There are a myriad of things that consistently break, and not all necesary features have been published. 

That being said, I still recomend that we work towards understanding and developing for the virtual kubelet because updates to the [Virtual Kubelet github](https://github.com/virtual-kubelet/virtual-kubelet) are being put out almost daily. While the [IoT Edge Connector github](https://github.com/azure/iot-edge-virtual-kubelet-provider) is less frequently updated, nearly every update to the Virtual Kubelet project is a step towards improving the IoT Edge Connector as well.

*A few of these issues may stem from the lack of resources on my end (being that I have a free Azure account with limited capabilites), but I have no way of knowing yet.*

## CrashLoopBackOff

For me, this is error is the *most* frustrating, because generally it is out of your control. This is an error I think may be connected to my lack of resources, but I am unsure. 

A crash loop back off is exactly what it says. The pod will boot, crash, boot, crash, so it 'backs off' and shuts down. This is an issue with the connector. The good news with this is that when a crash loop back off happens, it doesn't effect a deployment that has already been pushed out. Think of the virtual kubelet as a bridge going over the columbia river. If your deployments are the cars, you can send these deployments over. If the bridge falls, the cars that have already made it over the bridge will remain there- just now no more will be able to be sent over until the bridge is repaired. You can see that in this diagram:

![CrashLoopBackOff](https://github.com/NFeingold/Virtual-Kubelet-Demonstration/blob/master/media/CrashLoopBackOff.jpg)

If the red dots are the new deployment, and the orange the old deployment, you can see that the new deployment is blocked from coming in, but the orange remains unharmed between the devices and cloud. 

### How to fix

Sometimes this process has to be repeated two or three times until it finally works, but overall the process is just to delete the connector and reinstall it. To do so, enter the following:

Delete...
```sh
helm del --purge hub0
```

Verify the pod has been deleted....
```sh 
kubectl get pods
```

Reinstall...
```sh
cd
cd iot-edge-virtual-kubelet-provider/src/charts/iot-edge-connector/
helm install -n hub0 --set rbac.install=true .
```

If you get an error that says something similar to 'no tiller', run the following:

```sh
kubectl --namespace kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller
cd iot-edge-virtual-kubelet-provider/src/charts/iot-edge-connector/
helm install -n hub0 --set rbac.install=true .
```

If you still get get an error that says 'unable to find ready tiller pod', wait 15 or so seconds and run the following:
```sh 
helm install -n hub0 --set-rbac.install=true .
```



