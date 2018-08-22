# Steps to Automate
In Azure command line:

```sh
vim aksHub.sh
```
Then copy paste the code from the sh file into the new file. This can be done by hitting 'i' then shift+insert. Then hit escape, :, x, enter. 

Next, to run, type:

```sh
chmod +x aksHub.sh
./aksHub.sh
```
To interupt the process at any time, just hit ctrl+c

## If you prefer AutoHotKey over SH...

First download both the .exe files

Run both of the files by double clicking on them <br/>

**These programs just paste text, so before pressing the key commands, click in the terminal or into a notepad, and copy and paste it over**

## Part 1 
#### Pressing Ctrl+Shift+J will prompt you for:
  - Resource Name 
  - Hub Name
  - AKS Cluster Name
  - Number of Nodes

This will paste the following:
```sh
az group create -n <myResource> --location eastus && az iot hub create -n <myHub> -g <myResource> --sku S1 && az aks create -g <myResource> -n <myAKS> -c 1 --generate-ssh-keys && az aks get-credentials -g <myResource> -n <myAKS> && kubectl get nodes 
```
## Part 2
#### Pressing Ctrl+Shit+L will prompt you for:
  - Secret Key
  
This will paste the following:
```sh
kubectl create secret generic my-secrets --from-literal=hub0-cs='<My Secret>' && kubectl --namespace kube-system create serviceaccount tiller && kubectl create clusterrolebinding tiller-cluster-rerrole=cluster-admin --serviceaccount=kube-system:tiller && helm init --service-account tiller && cd iot-edge-virtual-kubelet-provider/src/charts/iot-edge-connector/ && helm install -n hub0 --set rbac.install=true . && cd 
```
**Note:** After the first command runs, wait around 10 seconds and the second half will run. This is giving the Tiller time to get ready. If you get the error 'Could not find ready tiller pod,' then wait 10ish more seconds, and run the last command again (up-arrow, enter). Sometimes this can take up to a minute, so give it time and try several times. 
#

**Please remember to click in the terminal or in notepad before using the key commands**


If you are curious, the code behind these .exe files are available in the 'h-files' folder.
If you would prefer, you can download the .h files rather than the .exe so you can see what you will be running

## Warning

**Windows may prompt you, making sure you want to download and run these .exe files, being that they are from an unknown publisher. To get around this, just click the 'more info' buttons, and click download/run anyway.**

If you want to check the files before running them, you must first download them. Then using file archiving software such as 7-Zip or Winrar, open the archive by right clicking on the .exe files. From there, you can navigate to the .rsrc folder, to the RCDATA folder, then right click the >AUTOHOTKEY SCRIPT<. You can either 'view' or 'open with' and view with a text editor (such as VSCode, or notepad) to see what is going to be run.

## Note

I am aware that Azure provides automation, though it does not currently work with kubernetes. So I made this as an alternative.
I have *only* tested this on Windows Machines, and I do not think they will work elsewhere. If you test it on your machine, let me know the results
