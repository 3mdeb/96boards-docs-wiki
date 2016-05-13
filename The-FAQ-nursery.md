# Meta-topics

_The meta-questions describe the role of this document. The questions in this section should *not* be copied to the forum FAQs._

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

TBD ;-)

**Q: What is the best way to ask questions on the forum?**

Firstly, consider checking to see if anyone else has asked a similar question. I'd recommend using a full search engine since that is more powerful than the search box built into the forum, for example if you use google just add <code>site:96boards.org</code> to limit you search to the forums (and the 96Boards documentation).

Otherwise the best thing to do is to start a new topic and give it a good title. The title appears in the side bar on the forum and gets lots of visibility. A good title will tend to attract better answers.

**Q: Why must I constantly prove that I am not a robot?**

*All* forums have to fight spam and are usually forced to make a choice between the costs of fighting spam reactively (constant clean up) and the cost of fighting spam pro-actively (CAPTCHAs, approvals requires for first few posts).

The CAPTCHA system used here at 96Boards is relatively lightweight, especially compared tests that require you to decode obfuscated text. It asks you to show you are not a robot by clicking on a tick box. Occasionally it will also ask you to solve a picture puzzle. Either way, we believe that this type of CAPTCHA has a good chance of success on the first try and we really hope it doesn't slow you down too much.

**Q: Why the CAPTCHA system refuse me to select pictures?**

???

danielt: I've never seen this but is sounds more like a bug than a FAQ!

## Common technical questions

**Q: Can I use the micro USB cable to power my board?**

Consumer Edition and Enterprise Edition 96Boards do not draw system power from their micro-USB sockets. To read why we decided not to permit this please take a look at:
[96Boards Power Accessories](https://www.96boards.org/products/accessories/power/)

**Q: What type of AC adapter do I need?**

This question is important as using the wrong method to powering the 96Boards risks damage to your board.
Please refer the link to buy appropriate AC adapter with the right DC plug.

[How to select the correct AC adapter](https://www.96boards.org/products/accessories/power/)

## Using Android on 96Boards

**Q: Can I use mouse/keyboard and adb at the same time?**

Very good question, it would be great if it could you the mouse/keyboard and adb at the same time.
The current 96Boards has two USB Type A connectors (the two big regular USB connectors) and one micro USB connector.
To use adb from your host PC, you need to connect the Host PC with micro USB connector.
Unfortunately current specification of 96Boards you need to unplug anything it is connected on the the USB Type A connector, such as, mouse or keyboard and etc, to use micro USB connector for adb.
Using any mouse/keyboard and other USB devices on reguler usage of Android is perfectly fine,
just please remove any USB devices on both Type-A connector before inserting micro USB cable for starting to use adb.

TODO: We need to explain the reasons for this (CE boards with only a single USB controller cannot support OTG at the same time as normal host controller). This matters because Bubblegum-96 does have two USB controllers so on that board it can all be used at once.

# Hikey FAQ

**Q: Which UART to be able to see serial console screen, /dev/ttyAMA0 or AMA3?**

TDB

## Dragonboard 410c FAQ

**Q: Where are the documentations?**

We are finally happy to announce that front page of all the contents of the information of 96Boards are up on our website.

It includes out of box usage to detail technical information and how to install OS with your selection.
[The 96Boards CE Documentation wiki page](https://github.com/96boards/documentation/wiki)

[96Boards Documentation portal (under construction)](http://www.96boards.org/documentation/)

**Q: How to boot after buying the DragonBoard 410c?**

Probably this is the first topic you would like to know. Please refer the instruction to boot your board with HDMI display.

[Getting started with HDMI display](http://www.96boards.org/forums/topic/short-into-to-start-your-dragonboard-410c-with-hdmi-display/)

**Q: How to use serial console on 96Boards?**

The access to the board with serial console is essential for most for the developers. We have made the tutorial describing one of the easiest ways to get started with the serial console.

[Getting started with serial console on Dragonboard 410c](http://www.96boards.org/forums/topic/short-into-to-start-your-dragonboard-410c-with-serial-console/)

**Q: Where to look information about Windows IoT on DragonBoard 410C?**

The DragonBoard 410c offers the selection of Windows IoT. Please refer the link to obtain the information of Windows IoT on DragonBoard 410C.

[How to Setup Windows 10 IoT Core on Dragonboard](http://www.96boards.org/forums/topic/windows-10/)

## Bubblegum-96

**Q: Where is the documentation for the Bubblegum-96?**

We're busy working on it. In the mean take a look at https://github.com/96boards-bubblegum/linaro-adfu-tool to see how to FLASH different operating systems onto your Bubblegum-96. You can also come and join us at http://www.96boards.org/forums/forum/products/bubblegum96/ and ask for what you need.

**Q: Why can I buy the USB type A to USB type A needed to debrick the board?**

It can be difficult to find these cables using a search engines because the cable you need tends to be hidden behind all the USB type A to type B (or micro-B) cables. Often its better just to browse the web site of a specialist cable provider.

To help you save a bit of time we've collected together links to suppliers who appear to sell suitable products. We haven't tested them all ourselves but hope its useful. The list is a bit shorter than we'd like right now so feel free to post links to alternative suppliers on [the forums](http://www.96boards.org/forums/forum/products/bubblegum96/) and we'll try to add them here.

* [Lindy USB type A plug to micro-B socket (UK)](http://www.lindy.co.uk/cables-adapters-c1/usb-c449/usb-2-0-c450/usb-2-0-type-a-male-to-micro-b-female-adapter-p8431/)

# Lemaker Cello

**Q: Why is this section empty?**

The board is still being tested and enabled. Not many people have Cello's on their desks at this point so no questions have been frequently asked!