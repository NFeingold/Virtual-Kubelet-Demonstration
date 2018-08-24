# Setting up an AKS Cluster and IoT Hub with the IoT Edge Virtual Kubelet

This is Part 1 to the full demonstration of a sample deployment to a raspberry pi using Virtual Kubelet and IoT Edge.
I suggest you work in the [Azure Portal](https://portal.azure.com) and follow along with my [YouTube Video](https://www.youtube.com/watch?v=XbkLWmjww8I). Though this video is a little outdated, the process remains the same.

### If you want to automate this process...

I have also created [AutoHotKey Scripts](https://github.com/NFeingold/Virtual-Kubelet-Demonstration/tree/master/Guide/1%20-IoT%20Hub%20and%20AKS/Automation) that will prompt you for variable names, then type everything for you.

I have also created a Shell Script, which I will soon publish as an alternative to the AutoHotKey script. It is currently working, but frequently giving CrashLoopBackOff errors. Working to see why this is.

### Cheat Sheet

I have provided a cheat sheet .txt file if you want the commands but no explanation of what they do. I recomend this sheet only after you've done this example once or twice, as it makes the process a bit faster.

## Part 1: Creating an AKS Cluster and IoT Hub


### Create a Resource Group

```sh
az group create -n <resource group> -l <location>
```

I would recommend using eastus as the location, as this is what is native for the AKS cluster.

### Create an AKS Cluster

```sh
az aks create -n <aks cluster name> -g <resource group> -c <node count, 1> --generate-ssh-keys
```
I recomend making the node count as 1, and to make the AKS cluster name something unique. While the name isn't required to be unique, I have come across a glitch several times when naming an AKS cluster a repeat name that will require a complete deletion of your Azure storage.

The AKS cluster can take a very long time to set up- sometimes above 30 minutes. Be patient. You may want to add ```--no-wait ``` to the end of the previous command (```az aks create```), so you can interact with the command line while the aks cluster is being created.

### Create an IoT Hub

I prefer navigating through the Azure interface when creating my IoT hub, as (for me) it has been more reliable. This can be done by navigating to the IoT Hub menu (which can be found by searching IoT Hub in the search bar in the top right), clicking '+ Add' in the top left, and creating a new hub with an *existing resource group*, being the one you had just created. 

Alternatively, in the command line you can enter:

```sh
az iot hub create -n <iot hub name> -g <resource group> -l <location> --sku <s1>
```
Once again, I suggest you use eastus as the location.

### Connect to the AKS Cluster
```sh
az aks get-credentials -n <aks cluster name> -g <resource group>
```
## Part 2: Implementing the Virtual Kubelet

### Clone the Virtual Kubelet Provider for IoT Edge

```sh
git clone https://github.com/Azure/iot-edge-virtual-kubelet-provider.git
```

### Generate Secrets 

You can find the iot-hub-owner-connection string by first navigating to the IoT Hub you created. From there, in the bar on the left, scroll down to the 'Shared Access Policies' under the settings tab. Now click on the iothubowner bar, which should pop up a window on the right. Near the bottom you will see the primary connection string (the third one down). You can copy it by clicking the blue button to the right of the string.
```sh
kubectl create secret generic my-secrets --from-literal=hub0-cs='<iot-hub-owner-connection-string>'
```

### Download the Virtual Kubelet Provider through Helm
```sh
kubectl --namespace kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller
```
<br/> *wait a second so the tiller has time to initiate* <br/>
```sh
cd iot-edge-virtual-kubelet-provider/src/charts/iot-edge-connector/
helm install -n hub0 --set rbac.install=true .
```
*if you are using the automation and you get the error "cannot find ready tiller pod," wait 10 or so seconds, then run the* ```helm install -n hub0 --set rbac.install=true .``` *command again, until it works*
### Check the results
```sh
kubectl get nodes
kubectl get pods
```

If succesful, you should see the IoT Hub Virtual Kubelet Connector in both nodes and pods.
