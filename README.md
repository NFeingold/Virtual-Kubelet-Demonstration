# Virtual-Kubelet-Demonstration

A follow-along demonstration of using Virtual Kubelet for IoT Edge Deployments

## What you will be doing

We will be sending out a simulated temperature sensor deployment onto a raspberry pi from the Azure IoT Hub

This is a semi-comprehensive, beginner-level set up of Virtual Kubelet for Edge Deployments.
I will be borrowing content from my other [Github Pages](https://github.com/NFeingold), and referencing many outside documents that I will source.

## What you will be learning

- Virtual Kubelet for IoT Edge
- Basics of Azure 
- Basics of IoT Hub/IoT Edge
- Basics of Kubernetes
- Basics of Raspberry Pi

By the end, the hope is that you understand this diagram: <br/>
![Iot-Edge-Connect](https://github.com/NFeingold/Virtual-Kubelet-Demonstration/blob/master/media/iot-edge-connector.png)<br/>
*image provided my [microsoft's azure github](https://github.com/Azure/iot-edge-virtual-kubelet-provider)*

## Kubernetes? IoT Edge? What are those?

If this is your first time hearing some of these words, or you just need a refresher, I recommend navigating to the useful links folder. One of the key links in there is the [Kubernetes Glossary](https://kubernetes.io/docs/reference/glossary/?fundamental=true). The best thing about everything you are about to learn is that there is *amazing* documentation for all of it. If a google search just isn't doing it for you, please refer to the links I have provided.

## Requirements

 [Azure Subscription](https://portal.azure.com) <br/>
 [Raspberry Pi](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)
  - Power Cable (5v micro USB- This will likely come with the Pi)
  - 16+ GB MicroSD Card (And a computer to flash [Raspbian](https://www.raspberrypi.org/downloads/raspbian/))
  
The following peripherals you will only need temporarily, while setting up the Pi:

- USB Wired Keyboard
- Monitor
- Cables necessary to connect Pi to Monitor
- USB Wired Mouse (optional)

You will need to be able to connect the Raspberry Pi to the internet. It has an ethernet port onboard, and some (such as the Raspberry Pi 3) have a wireless chip. 

## Don't have all the requirements?

#### No Keyboard or Monitor?
There are tutorials on how to set up a Raspberry Pi without peripherals (Headless). [Here](https://hackernoon.com/raspberry-pi-headless-install-462ccabd75d0) is an example. I have not personally tested this, as I had peripherals available to me.

#### No Raspberry Pi?
You can also set up a virtual machine running the raspbian operating system (or any OS of your choice) and deploy to that.

#### No Azure Subscription?
You can set one up for free, with a $200 credit if this your first time [Here](https://portal.azure.com). No credit card required

## Getting Started
Navigate to the above folder, "Guide" and select folder 1.
