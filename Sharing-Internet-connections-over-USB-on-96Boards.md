# Abstract

It is not always possible (nor recommended) to  connect development boards to global wireless networks in highly dense environments:  leaving security issues aside, as the network density increases the reliability of the network typically decreases.  

The following note will explain how to create a local network between a Linux host computer and a Debian based system running on any of the 96Boards hardware platforms. 

The proposed configurations will use the USB host or the USB OTG controllers and Linux’s usbnet driver framework. Besides setting up a local network between the host and the target, it will also show how to share the host’s internet access with the development boards.

# Method 1: USB ethernet adapter. 

_Use Case: when the host accesses the Internet via WIFI._
_Requires an ethernet cable and a USB-to-ethernet adapter._


* Connect your host system to the WIFI network.
* On your host, create a new wired network connection selecting only “Shared Networking”<br />
  Select Network Connections <br />
  Select Add to create a new Ethernet connection  <br />
  Give a name to the connection  <br />
  Select the IPv4 settings tab and choose Shared to other computers method from the drop down menu <br />
  Save the connection <br />
* Plug the USB ethernet adapter to the 96Boards platform.
* Connect the ethernet cable to the laptop network interface.
* From your host system, activate the previously created connection.

The 96Boards platform is now connected to your local network and the host’s Internet connection is being shared.

# Method 2: USB OTG networking.

_Use Case: the host can access the Internet either via WIFI or ETH_
_Requires a USB to microUSB cable_

We use the g_ether driver on the target board to provide networking access over a standard USB cable. Commands coloured in red need to be executed on the target, those in blue on the host.

## Load the USB Ethernet network gadget driver.

Boot the target to a shell prompt and run: <br />
`$ sudo modprobe g_ether`

The serial console should display something like this:

`g_ether gadget: using random self ethernet address` <br />
	`g_ether gadget: using random host ethernet address` <br />
	`usb0: MAC be:b5:85:ef:48:33` <br />
	`usb0: HOST MAC 1a:b2:c3:43:8a:6e` <br />
	`g_ether gadget: Ethernet Gadget, version: Memorial Day 2008` <br />
	`g_ether gadget: g_ether ready` <br />

The usb0 network interface should have been created: check it out by running <br />

`$ ifconfig usb0` <br />

`usb0  	                Link encap:Ethernet  HWaddr BE:B5:85:EF:48:33  `<br />
       			`BROADCAST MULTICAST  MTU:1500  Metric:1`<br />
			`RX packets:0 errors:0 dropped:0 overruns:0 frame:0`<br />
			`TX packets:0 errors:0 dropped:0 overruns:0 carrier:0`<br />
			`collisions:0 txqueuelen:1000 `<br />
			`RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)`<br />

## Connect the 96Boards platform to the host.

Before connecting the target device to the host watch syslog by running the following command on the host:<br />

`$ sudo tail -f /var/log/messages `<br />

Plug the USB cable to the 96Boards platform micro-USB OTG connector and to the host port on the PC. The previously run command should now generate something like this:<br />

`usb 1-4.4.2: new high speed USB device using ehci_hcd and address 47`<br />
	`cdc_subset: probe of 1-4.4.2:1.0 failed with error -22`<br />
	`cdc_subset 1-4.4.2:1.1:usb0:register 'cdc_subset'at usb-0000:00:02.1-4.4.2, Linux Device, 82:13:56:20:b4:cb`<br />
	`usbcore: registered new interface driver cdc_subset`<br />
	`cdc_ether: probe of 1-4.4.2:1.0 failed with error -16`<br />
	`usbcore: registered new interface driver cdc_ether`<br />

Verify that the new usb0 interface exists on the host by running:<br />

`$ ifconfig usb0`<br />

`usb0      Link encap:Ethernet  HWaddr 82:13:56:20:b4:cb  `<br />
          `inet6 addr: fe80::8013:56ff:fe20:b4cb/64 Scope:Link`<br />
          `UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1`<br />
          `RX packets:0 errors:0 dropped:0 overruns:0 frame:0`<br />
          `TX packets:1 errors:0 dropped:0 overruns:0 carrier:0`<br />
          `collisions:0 txqueuelen:1000 `<br />
          `RX bytes:0 (0.0 B)  TX bytes:78 (78.0 B)`<br />

After having connected the usb cable, the target’s device console should have displayed the following:<br />

`g_ether gadget: high speed config #1: CDC Ethernet (ECM)`<br />

## Bridge the network

We will use the network manager applet on the host to create a new connection of ethernet type to be shared with the usb interface. The way the interface is identified is via its MAC address.

* Select Edit Connections
* Select Add to create a new Ethernet connection
* Give a name to the connection
* Select the Ethernet tab and choose the USB mac address from the drop down menu
* Select the IPv4 Settings tab and choose Shared to other computers method from the drop down menu
* Save the connection
* Enable the connection

Execute the following command on the target to get an ip address and update the DNS server:

	$ dhclient usb0

The connection is now ready to use.

If you haven’t done this before, maybe it is the time to resynchronize the board’s package index files to make sure your OS is up-to-date:
	
	$ sudo apt-get update
	$ sudo apt-get upgrade


Note: Windows users wanting to connect to the 96Boards platform via direct USB link, would have to:  
`$sudo modprobe g_ether` <br />
plug the USB cable to the OTG port in the 96Board. <br />
install the Linux RNDIS driver located in the 96Boards kernel tree (Documentation/usb/linux.inf) on the Windows host <br />
And then configure the Windows network as they would usually do.

