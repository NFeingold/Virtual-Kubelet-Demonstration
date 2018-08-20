# Virtual-Kubelet-Demonstration
A follow along demonstration on setting up Virtual Kubelet for IoT Edge Deployments 

This is a semi-comprehensive beginner-level demonstration of setting up Virtual Kubelet for Edge Deployments.
I will be borrowing content from my other [Github Pages](https://github.com/NFeingold), and referencing many outside documents that I will source.

**When ready, navigate to the "Guide" folder, and select 1**

## Definitions:
  - [Kubernetes](https://kubernetes.io/): Kubernetes (koo-ber-neh-tees) is an open-source system for automating deployments, scaling, and management of containerized applications.” 
    [Here](https://youtu.be/IMOZCDhH7do?t=19s) is a simplified video, explaining what Kubernetes does.
    
  - [IoT Hub](https://docs.microsoft.com/en-us/azure/iot-hub/about-iot-hub):  IoT Hub is a Microsoft Azure service that enables you to receive telemetry data (data collected at remote points) at scale, monitor, and manage IoT devices.
  - [Azure IoT Edge](https://azure.microsoft.com/en-us/services/iot-edge/):  “Azure IoT Edge is a service that builds on top of IoT Hub. This service is meant for customers who want to analyze data on devices, a.k.a. "at the edge", instead of in the cloud. By moving parts of your workload to the edge, your devices can spend less time sending messages to the cloud and react more quickly to changes in status” 
We will be pushing applications onto edge devices, rather than doing work in the cloud. By having the devices do the computing, or storing the data and sending it to the cloud in chunks, the processes being done are sped up and do not require a constant connection to a server. 

  - [Virtual Kubelet](https://github.com/virtual-kubelet/virtual-kubelet): “Virtual Kubelet is an open source Kubernetes kubelet implementation that masquerades as a kubelet for the purposes of connecting Kubernetes to other APIs. This allows the nodes to be backed by other services like… IoT Edge. The primary scenario for VK is enabling the extension of the Kubernetes API into serverless container platforms like ACI, Fargate, and Hyper.sh, though we are open to others.” <br/> <br/>
We will be using Virtual Kubelet, in some sense, as the bridge between Azure IoT Hub and Kubernetes. 

## Why Virtual Kubelet?

Virtual Kubelet will allow us to more easily manage and scale IoT Edge Deployments from inside a Kubernetes environment. <br/>

I highly suggest you read [this short article](https://thenewstack.io/kubernetes-for-edge-computing-the-microsoft-azure-approach/) on the topic. This gives a brief explanation of everything I have spoken about thus far, and succinctly explains the advantages of using virtual kubelet. *(For an even less reading, you can ctrl+f “Virtual Kubelet” and start reading from the first paragraph to mention it)*

## How Can You Do It?

Navigate to the 'Guide' folder. Start with folder 1. You will be met with an in depth guide on how to set up and AKS Cluster, IoT hub, and more. Once you are done with folder 1, move onto folder 2 and so on. 

## Useful Links
- [Kubernetes Glossary](https://kubernetes.io/docs/reference/glossary/?all=true)
- [IoT Edge Virtual Kubelet Provider GitHub](https://github.com/azure/iot-edge-virtual-kubelet-provider)
- [Virtual Kubelet GitHub](https://github.com/virtual-kubelet/virtual-kubelet)
- [What is the IoT Hub?](https://docs.microsoft.com/en-us/azure/iot-hub/about-iot-hub)
- [Kubernetes Integration with Azure IoT Edge Video](https://www.youtube.com/watch?v=p-R2mV7Bxuk)



_Questions? Comments? Concerns? Email me at nfeingold@attunix.com_
