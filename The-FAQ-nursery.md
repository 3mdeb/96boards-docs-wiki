# Meta-topics

_The meta-questions describe the role of this document. The questions in this section should *not* be copied to the forum FAQs._

**Q: Can I edit this document?**

Sure. The only things you really need to know is that:

1. If you want your changes to go live immediately then you need to contact Akira (@mcd500). We haven't fully automated the flow from the nursery to the forums so we need the ping for anything urgent.

2. If the question does not yet have an adequate answer, perhaps because you're still thinking about it or because you want to encourage someone else to write one, then make sure to add '(DRAFT)' somewhere in the question. Draft questions are never copied to the forum. 

**Q: What is the FAQ nursery?**

One meaning of nursery is to describe a business that grows young plants until they are strong enough to be sold in a garden centre. In the same way that a nursery nurtures immature plants until they are ready to face the world, the FAQ nursery allows FAQs to be collaboratively edited (in markdown format) whilst they are not ready to be shared on the forum.

The nursery is, by design, not the place to come for complete (or even coherent) answers. It is a place to come to write, propose and savagely edit our frequently-asked-questions.

**Q: How should I phrase questions?**

FAQs are presented as questions and answers and it is important that the question is a question, rather than a title. It should read as a full English sentence that requests information.

**Q: What is the right tone (of language) for answers?**

A FAQ is *not* documentation and need not adopt the formal approach commonly found in technical documentation. Instead answers in a FAQ should adopt the more informal tone we expect to find on the forum. 

# General

## How to use the forum 

**Q: I'm new here. What should I read first?**

The blog post "96Boards Out of box experience guide – part 1/2" are the best place to start on 96Boards.

* [96Boards Out of box experience guide – part 1](http://www.96boards.org/blog/96boards-box-experience-guide-1/)

* [96Boards Out of box experience guide – part 1](http://www.96boards.org/blog/96boards-box-experience-guide-2/)

**Q: What is the best way to ask questions on the forum?**

Firstly, consider checking to see if anyone else has asked a similar question. I'd recommend using a full search engine since that is more powerful than the search box built into the forum, for example if you use google just add <code>site:96boards.org your search words</code> to limit you search to the forums (and the 96Boards documentation).

This is the way to search from the mailing list. <code>site:lists.96boards.org your search words</code>

Otherwise the best thing to do is to start a new topic and give it a good title. The title appears in the side bar on the forum and gets lots of visibility. A good title will tend to attract better answers.

**Q: Is there a mailing list for 96Boards? Is the discussion in the mailing list saved somewhere?**

Yes, we have setup a mailing list for advanced software developers working on open source software on 96Boards.

* [Subscribing mailing list](https://lists.96boards.org/mailman/listinfo/dev)

* [Archive of the mailing list](https://lists.96boards.org/pipermail/dev/)

**Q: Why must I constantly prove that I am not a robot?**

*All* forums have to fight spam and are usually forced to make a choice between the costs of fighting spam reactively (constant clean up) and the cost of fighting spam pro-actively (CAPTCHAs, approvals requires for first few posts).

The CAPTCHA system used here at 96Boards is relatively lightweight, especially compared tests that require you to decode obfuscated text. It asks you to show you are not a robot by clicking on a tick box. Occasionally it will also ask you to solve a picture puzzle. Either way, we believe that this type of CAPTCHA has a good chance of success on the first try and we really hope it doesn't slow you down too much.

**Q: Why does CAPTCHA system refuse to let me to select pictures?**

The CAPTCHA system is provide for us by Google. Sometimes regions or companies block Google services at the firewall. We are considering to use other system but at the moment, to access the forum you need to have access to Google products.

Also we have received reports that the CAPTCHA system may occasionally become out-of-sync with the forum itself if the user has been logged into the forum long time. We're aware of the problem but is hard to reproduce and so it's taking a while to get it fixed. As a workaround try logging out, closing your web browser and reconnecting to the forum again.

# Common technical questions

**Q: Can I use the micro USB cable to power my board?**

Consumer Edition and Enterprise Edition 96Boards do not draw system power from their micro-USB sockets. To read why we decided not to permit this please take a look at:

* [96Boards Power Accessories](https://www.96boards.org/products/accessories/power/)

**Q: What type of AC adapter do I need?**

This question is important as using the wrong method to powering the 96Boards risks damage to your board.
Please refer the link to buy appropriate AC adapter with the right DC plug.

* [How to select the correct AC adapter](https://www.96boards.org/products/accessories/power/)

**Q: How to turn on the 96Boards, where is the power button?**

This is a good question since most of the regular PC has a power button to turn on/off power supply which is controlled by the motherboard.

The way to turn on all of the current 96Boards is just plug in your AC adapter to the DC jack and it will automatically start booting the bootloader and OS.

There is no power LED on the 96Boards, so there will be no indication if the 96Boards has been powered or not at the glance.

It starts to boot the bootloader but please wait for some time until screen shows up on the HDMI display.

If you have connected the serial console, watching the boot messages are also good indication of booting.

There are 4 LED between the two USB Type A connector and some of them will start flushing after OS has booted.

# Using Android on 96Boards

**Q: Can I use mouse/keyboard and adb at the same time?**

Very good question, it would be great if it could you the mouse/keyboard and adb at the same time.
The current 96Boards has two USB Type A connectors (the two big regular USB connectors) and one micro USB connector.
To use adb from your host PC, you need to connect the Host PC with micro USB connector.

Not all SoC used on the 96Boards have more than one USB OTG ports. The Dragonboard 410C and HiKey are sharing one USB port with switch between USB Type-A ports and micro USB ports. With this design it is not possible to use both USB Type-A connector and micro USB connector at the same time.

You need to unplug anything it is connected on the the USB Type A connector, such as, mouse or keyboard and etc, to use micro USB connector for adb.

Using any mouse/keyboard and other USB devices on regular usage of Android is perfectly fine,
just please remove any USB devices on both Type-A connector before inserting micro USB cable for starting to use adb.

# Hikey FAQ

**Q: What is the difference between the J15 and J601 boot mode pins?**

There are two versions of the Hikey, one is produced by LeMaker and the other by CircuitCo.

The boot mode pins are marked J601 on the LeMaker HiKey and located on the edge of the boards close to LS connector.
On the CircuitCo Hikey these pins are marked J15 and are located at almost the same location. You might need magnifier to see them since they are printed on the board very small.

The J15 and J601 are identical in function, it is only the silk screen that differs between the two boards.

This jumper pins are used to select the boot-time behaviour of the HiKey and are usually used to FLASH the bootloader. The pinout it the same regardless of the board manufacturer:

<pre>
Name          | Link     | State
------------- | -------- | ------
Auto Power up | Link 1-2 | closed
Boot Select   | Link 3-4 | closed
GPIO3-1       | Link 5-6 | open
</pre>

**Q: Which UART to be able to see serial console screen, /dev/ttyAMA0 or AMA3?**

This is the same topic of regarding between UART0 and UART3.

There are pins on the HiKey printed as J801 on LeMaker and J16 on CircuitCo. Both are the same UART port for the HiKey.

The J16-J801 is connected on UART0 on the SoC of the HiKey and we were assigning the UART0 for sending and receiving data of serial console. The UART0 is recognized by the HiKey as the /dev/ttyAMA0.

The initial images of bootloader and kernel were built to use UART0 for the serial console.

However, to be able of users of 96Boards to use the serial console feature across the different 96Boards, we have decided to use UART3 on LS connector for the serial console instead of the UART0 port. The UART3 is recognized by the HiKey as the /dev/ttyAMA3.

The images from 15.11 release, the UART3 (/dev/ttyAMA3) works as the serial console.

Please refer the link bellow to use the serial console on HiKey.

* [Using serial console](http://www.96boards.org/forums/topic/short-intro-to-start-your-hikey-with-serial-console/)

**Q: Is this it? There are no other frequently-asked-questions?**

This is all we've come up with for the HiKey. However if you browse over to [the General forum](http://www.96boards.org/forums/forum/general/) you'll find a FAQ covering questions of a general nature. That includes questions about the 96Boards project, as well as technical questions whose answers apply to more than one board.

# Dragonboard 410c FAQ

**Q: Where should I look for documentation?**

There's a wealth of documentation for the Dragonboard 410c. So much that it is quite possible that need a bit of help finding which document is the best one for you to read! If you can't find what you're looking for, feel free to ask on the forum. Usually someone will come along with a "hello" and a link!. However... if you're in a hurry let us offer you some ideas:

* [DragonBoard 410c Documentation (at 96boards.org)](http://www.96boards.org/products/ce/dragonboard410c/docs/). This is a great starting point for hunting down board manuals, schematics and all the other documentation we require 96Boards vendors to put together (and, in the case of DragonBoard, a whole lot more besides).
* [DragonBoard 410c Tools and Resources by Qualcomm](https://developer.qualcomm.com/hardware/dragonboard-410c/tools). This is Qualcomm's own page about the board. It contains several documents not found in this site and, if Windows 10 IoT is your thing then this is where you go to get it.
* [96Boards CE documentation wiki page](https://github.com/96boards/documentation/wiki). This is a great task-focused (e.g. I want to install Android) approach to documentation for 96Boards. Eventually we'll see this merged into the main 96Boards documentation (below).
* [96Boards documentation portal (under construction)](http://www.96boards.org/documentation/). We want to get better at documentation for the all of the 96Boards! As part of that we've been working on one URL to point developers and users at. This is it and it will be awesome... but only when we've finished it.

**Q: How to boot after buying the DragonBoard 410c?**

Probably this is the first topic you would like to know. Please refer the instruction to boot your board with HDMI display.

* [Getting started with HDMI display](http://www.96boards.org/forums/topic/short-into-to-start-your-dragonboard-410c-with-hdmi-display/)

**Q: How to use serial console on 96Boards?**

The access to the board with serial console is essential for most for the developers. We have made the tutorial describing one of the easiest ways to get started with the serial console.

* [Getting started with serial console on Dragonboard 410c](http://www.96boards.org/forums/topic/short-into-to-start-your-dragonboard-410c-with-serial-console/)

**Q: What is the best source of information about Windows 10 IoT for DragonBoard 410c?**

Please refer the link to obtain the information of Windows IoT on DragonBoard 410C.

* [How to Setup Windows 10 IoT Core on Dragonboard](http://www.96boards.org/forums/topic/windows-10/)

**Q: How do I use GPS with the debian-derived software images?**

We've been looking at GPS in the debian-based images, and it's now working "in the lab". It's not yet integrated into the builds (not even the snapshot builds) but we have posted instructions on the forum. Our goal is to have everything merged into our build by the end of June. The final solution may be slightly different, but the steps posted to the forum are known to work...

* http://www.96boards.org/forums/topic/gps-software/#post-14390

**Q: Is this it? There are no other frequently-asked-questions?**

This is all we've come up with for the DragonBoard 410c. However if you browse over to [the General forum](http://www.96boards.org/forums/forum/general/) you'll find a FAQ covering questions of a general nature. That includes questions about the 96Boards project, as well as technical questions whose answers apply to more than one board.

# Bubblegum-96 FAQ

**Q: Where is the documentation for the Bubblegum-96?**

We're busy working on it. In the mean take a look at https://github.com/96boards-bubblegum/linaro-adfu-tool to see how to FLASH different operating systems onto your Bubblegum-96. You can also come and join us at http://www.96boards.org/forums/forum/products/bubblegum96/ and ask for what you need.

**Q: Why can I buy the USB type A to USB type A needed to debrick the board?**

It can be difficult to find these cables using a search engines because the cable you need tends to be hidden behind all the USB type A to type B (or micro-B) cables. Often its better just to browse the web site of a specialist cable provider.

To help you save a bit of time we've collected together links to suppliers who appear to sell suitable products. We haven't tested them all ourselves but hope its useful. The list is a bit shorter than we'd like right now so feel free to post links to alternative suppliers on [the forums](http://www.96boards.org/forums/forum/products/bubblegum96/) and we'll try to add them here.

* [Lindy USB type A plug to micro-B socket (UK)](http://www.lindy.co.uk/cables-adapters-c1/usb-c449/usb-2-0-c450/usb-2-0-type-a-male-to-micro-b-female-adapter-p8431/)

**Q: Is this it? There are no other frequently-asked-questions?**

This is all we've come up with for the Bubblegum-96. However if you browse over to [the General forum](http://www.96boards.org/forums/forum/general/) you'll find a FAQ covering questions of a general nature. That includes questions about the 96Boards project, as well as technical questions whose answers apply to more than one board.

# Lemaker Cello

**Q: Why is this section empty?**

The board is still being tested and enabled. Not many people have Cello's on their desks at this point so no questions have been frequently asked!