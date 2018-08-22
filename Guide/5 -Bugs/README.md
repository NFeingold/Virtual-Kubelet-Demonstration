# Common Issues and Solutions

Virtual Kubelet is **still in development** and is **not yet ready for full scale production.** There are a myriad of things that consistently break, and not all necesary features have been published. 

That being said, I still recomend that we work towards understanding and developing for the virtual kubelet because updates to the [Virtual Kubelet github](https://github.com/virtual-kubelet/virtual-kubelet) are being put out almost daily. While the [IoT Edge Connector github](https://github.com/azure/iot-edge-virtual-kubelet-provider) is less frequently updated, nearly every update to the Virtual Kubelet project is a step towards improving the IoT Edge Connector as well.

*A few of these issues may stem from the lack of resources on my end (being that I have a free Azure account with limited capabilites), but I have no way of knowing yet.*

## CrashLoopBackOff

For me, this is error is the *most* frustrating, because generally it is out of your control. This is an error I think may be connected to my lack of resources, but I am unsure. 

A crash loop back off is exactly what it says. The pod will boot, crash, boot, crash, so it 'backs off' and shuts down. This is an issue with the connector. The good news with this is that when a crash loop back off happens, it doesn't effect a deployment that has already been pushed out. Think of the virtual kubelet as a bridge going over a river. If your deployments are the cars, you can send these deployments over. If the bridge falls, the cars that have already made it over the bridge will remain there- just now no more will be able to be sent over until the bridge is repaired. You can see that in this diagram:

![CrashLoopBackOff](https://github.com/NFeingold/Virtual-Kubelet-Demonstration/blob/master/media/CrashLoopBackOff.jpg)<br/>
*original image from [microsoft's azure github](https://github.com/azure/iot-edge-virtual-kubelet-provider), also viewable in the [media](https://github.com/NFeingold/Virtual-Kubelet-Demonstration/tree/master/media) folder*

If the red dots are the new deployment, and the orange the old deployment, you can see that the new deployment is blocked from coming in, but the orange remains unharmed between the devices and cloud. 

### How to fix

If the solution is not urgent, sometimes waiting for 5-10 minutes will give the pod time to figure things out and repair itself.

However, sometimes waiting is not an option. Either you dont want to wait, or its not fixing itself. What you must then do is just delete the connector and reinstall it. To do so, enter the following:

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

Sometimes this has to be repeated 2 or 3 times, and if it *still* doesn't work, I recommend deleting the entire AKS cluster and starting from scratch. If then it still doesn't work, delete the whole resource group and try again. 

## All kubectl commands fail and return random integers

I believe the reason for this to be because you have multiple AKS cluster named the same thing. For some reason, even when you delete the AKS cluster in Azure, it remains saved in Kubernetes (or something like this). Then when you make a new AKS cluster, the pointer tries to go to the old data location and returns junk data. 

I have tried many solutions (even going into Kubernetes and manually deleting all the clusters), and the only one I have found that works is to delete the entire storage account and starting everything fresh. I understand this is incredibly frustrating, especially if you have other data saved on your cloud storage account. If you cannot delete your storage account, I suggest reaching out to an Azure specialist to help you take care of your issue. 

## Im working in the portal and when I type kubectl commands, it says I cannot connect to the server

I very commonly forgot the command ```az aks get-credentials -n <aks cluster> -g <resource group>``` which connects you to where you want. If this doesn't fix your issue (which you can test by doing any kubectl command, such as ```kubectl get nodes```), I would recommend signing out and singing back in, and/or closing your browser. 

## There are way more deployments than I have pushed out

I believe this has something to do with the CrashLoopBackOff. Sometimes you will enter ```kubectl get pods``` and it will return hundreds of pods. Or you can look at 'deployments' under the IoT Hub and see 20+ deployments, despite only pushing out one or two deployments. I would relate this back to some of the 'in development quarks' of Virtual Kubelet. Because the connector is contsantly crashing and booting, I *think* it sends out the deployment update every reboot. There are some ways around this, such as adjusting restart policies, though I don't think this is really worth the effort currently. It would likely result in more errors. For now, just try to get used to an overly cluttered deployment screen. If you are applying updates, remember to update the priority, so you don't get lost in the myriad of deployments that you are likely to ensue. 

If you want to delete all the pods, you can do so by typing the following:
```ssh
kubectl delete deployment tempsensor
```
or for a general use...
```ssh
kubectl delete <resource; pod, deployment, etc.> <name>
```

Now if you type ```kubectl get pods```, it should be clear of all the repeat pods.

## Other errors?

I encountered many *many* bugs and confusing user-end errors. Many of which are not on this page, either because they only happened once or twice, or I just forgot about them. 

If you have any questions, comments, etc., don't hesitate to reach out to me at nfeingold@attunix.com. I am no professional, but I know enough to maybe help!

