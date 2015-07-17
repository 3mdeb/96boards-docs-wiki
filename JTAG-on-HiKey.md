# OpenOCD JTAG and HiKey

I've been working on getting a open source JTAG debugging solution working on HiKey. This page documents the current status, and how to get this setup and working.

## Soldering on the connector
The first step is to solder on the JTAG connector. The unpopulated header is at J10 on the underside of the circuit board. The connector that you need to buy is a "FTSH-105-01-L-DV". It can be purchased from Farnell here (note the image is for a larger connector).

http://uk.farnell.com/samtec/ftsh-105-01-l-dv/header-1-27mm-smd-10way/dp/1667759﻿

Once the connector is soldered on it should look something like this

![](http://people.linaro.org/~peter.griffin/hikey/hikey_jtag_connector.jpg)

## JTAG device

OpenOCD supports many different JTAG dongles. The one I choose to use was the TinCanTools flyswatter2, which is $89 from http://www.tincantools.com/JTAG/Flyswatter2.html. This is a FTDI based device which is well supported in OpenOCD. The flyswatter2 comes with a variety of cables and adapters. I'm using the standard ARM 20 pin cable. I have then purchased a JTAG (2x10 2.54mm) to SWD (2x5 1.27mm) Cable Adapter Board from AdaFruit.

See http://www.adafruit.com/products/2094?utm_source=contextly&utm_medium=module-related&utm_campaign=129798
and a 10 pin 2x5 1.27mm cable
See http://www.adafruit.com/products/1675?utm_source=contextly&utm_medium=module-related&utm_campaign=129798

Once this is all connected it should look something like this

![](http://people.linaro.org/~peter.griffin/hikey/hikey_jtag_setup.jpg)

## OpenOCD source code
The armv8 code isn't currently merged to mainline, the latest code I've found is on the following gerrit http://openocd.zylin.com/#/c/2523/.

A GIT repo which is based off this gerrit which also includes a includes a hi6220 configuration file can be cloned here

    git clone ssh://git@git.linaro.org:/people/peter.griffin/openocd-code
    git checkout armv8

## Compiling OpenOCD

Install any pre-requisite libraries (e.g. FTDI libs if your JTAG is FTDI based)

    cd openocd-code
    export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig/
    ./configure --enable-ftdi
    make
    make install

## Running OpenOCD
    src/openocd -f ./tcl/interface/ftdi/flyswatter2.cfg -f ./tcl/target/hi6220.cfg

If all goes well you should see trace like the following: -

    Open On-Chip Debugger 0.9.0-dev-00241-gd356c86-dirty (2015-07-10-08:20)
    Licensed under GNU GPL v2
    For bug reports, read
	    http://openocd.sourceforge.net/doc/doxygen/bugs.html
    adapter speed: 10 kHz
    Error: session transport was not selected. Use 'transport select <transport>'
    Info : session transport was not selected, defaulting to JTAG
    jtag_ntrst_delay: 100
    trst_and_srst combined srst_gates_jtag trst_push_pull srst_open_drain connect_deassert_srst
    hi6220.cpu
    Info : clock speed 10 kHz
    Info : JTAG tap: hi6220.dap tap/device found: 0x5ba00477 (mfg: 0x23b, part: 0xba00, ver: 0x5)
    Info : hi6220.cpu: hardware has 6 breakpoints, 4 watchpoints

If you see trace like this

    Open On-Chip Debugger 0.9.0-dev-00241-gd356c86-dirty (2015-07-10-08:20)
    Licensed under GNU GPL v2
    For bug reports, read
	    http://openocd.sourceforge.net/doc/doxygen/bugs.html
    adapter speed: 10 kHz
    Error: session transport was not selected. Use 'transport select <transport>'
    Info : session transport was not selected, defaulting to JTAG
    jtag_ntrst_delay: 100
    trst_and_srst combined srst_gates_jtag trst_push_pull srst_open_drain connect_deassert_srst
    hi6220.cpu
    Info : clock speed 10 kHz
    Error: JTAG scan chain interrogation failed: all ones
    Error: Check JTAG interface, timings, target power, etc.
    Error: Trying to use configured scan chain anyway...
    Error: hi6220.dap: IR capture error; saw 0x0f not 0x01
    Warn : Bypassing JTAG setup events due to errors
    Warn : Invalid ACK 0x7 in JTAG-DP transaction

Check the following: -
* Soldering of the JTAG connector
* The cables are plugged in securely
* The board is correctly powered.

## Using OpenOCD Telnet interface
Once openocd has connected to the target you can connect via the telnet interface.

    telnet localhost 4444
    Trying 127.0.0.1...
    Connected to localhost.
    Escape character is '^]'.
    Open On-Chip Debugger
    > halt
    number of cache level 2
    cache l2 present :not supported
    hi6220.cpu cluster 0 core 0 multi core
    target state: halted
    target halted in ARM64 state due to debug-request, current mode: EL2H
    cpsr: 0x800003c9 pc: 0x3ef7e908
    MMU: disabled, D-Cache: disabled, I-Cache: disabled

## What works?

### Dumping the processor registers (whilst sat at u-boot prompt)

    > reg
    ===== arm v8 registers
    (0) r0 (/64): 0x0000000000000090 (dirty)
    (1) r1 (/64): 0x00000000F8015000
    (2) r2 (/64): 0x000000003EF9C000
    (3) r3 (/64): 0x0000000000000018
    (4) r4 (/64): 0x000000003EFA3B88
    (5) r5 (/64): 0x0000000000000100
    (6) r6 (/64): 0x0000000000000000
    (7) r7 (/64): 0x0000000000000001
    (8) r8 (/64): 0x000000003EF9BC50
    (9) r9 (/64): 0x0000000009F61000
    (10) r10 (/64): 0x000000003E75C468
    (11) r11 (/64): 0x000000003EF8F000
    (12) r12 (/64): 0x000000000000000F
    (13) r13 (/64): 0x0000000000000000
    (14) r14 (/64): 0x0000000000000000
    (15) r15 (/64): 0x0000000000000000
    (16) r16 (/64): 0x0000000000000000
    (17) r17 (/64): 0x0000000000000000
    (18) r18 (/64): 0x000000003E75EE38
    (19) r19 (/64): 0x000000003EFBACF0
    (20) r20 (/64): 0x000000003EFBACF0
    (21) r21 (/64): 0x0000000000000009
    (22) r22 (/64): 0x000000003EF99799
    (23) r23 (/64): 0x000000003EF90C00
    (24) r24 (/64): 0x000000003EFBA000
    (25) r25 (/64): 0x0000000000000000
    (26) r26 (/64): 0x0000000000000001
    (27) r27 (/64): 0x0000000000000000
    (28) r28 (/64): 0x000000003EF8E000
    (29) r29 (/64): 0x000000003E75EBE0
    (30) r30 (/64): 0x000000003EF77798
    (31) sp (/64): 0x000000003E75EBE0
    (32) pc (/64): 0x000000003EF7E908
    (33) xPSR (/64): 0x00000000800003C9

### Setting a breakpoint

    > bp 0x35000000 4 hw
    breakpoint set at 0x        35000000
    > resume

and in u-boot

    INFO:    BL3-1: Preparing for EL3 exit to normal world
    INFO:    BL3-1: Next image address = 0x35000000
    INFO:    BL3-1: Next image spsr = 0x3c9
    U-Boot 2015.04-00007-g1b3d379-dirty (May 27 2015 - 10:18:16) hikey_aemv8a
    DRAM:  1008 MiB
    MMC:   sd_card_detect: SD card present
    HiKey DWMMC: 0, HiKey DWMMC: 1
    In:    serial
    Out:   serial
    Err:   serial
    Net:   Net Initialization Skipped
    No ethernet found.
    Hit any key to stop autoboot:  0 
    # go 0x35000000
    ## Starting application at 0x35000000 ...

you can see in OpenOCD telnet we hit the breakpoint

    target state: halted
    target halted in ARM64 state due to breakpoint, current mode: EL2H
    cpsr: 0x600003c9 pc: 0x35000000
    MMU: disabled, D-Cache: disabled, I-Cache: disabled

now remove the breakpoint so we can try single stepping

    rbp 0x35000000
    
### Single stepping u-boot

    > step
    target state: halted
    target halted in ARM64 state due to breakpoint, current mode: EL2H
    cpsr: 0x600003c9 pc: 0x35000028
    MMU: disabled, D-Cache: disabled, I-Cache: disabled
    timeout waiting for target halt
    in procedure 'step'
    > step
    target state: halted
    target halted in ARM64 state due to breakpoint, current mode: EL2H
    cpsr: 0x600003c9 pc: 0x3500002c
    MMU: disabled, D-Cache: disabled, I-Cache: disabled
    timeout waiting for target halt
    in procedure 'step'
    > step
    target state: halted
    target halted in ARM64 state due to breakpoint, current mode: EL2H
    cpsr: 0x600003c9 pc: 0x35000030
    MMU: disabled, D-Cache: disabled, I-Cache: disabled
    timeout waiting for target halt
    in procedure 'step'
    <snip>
    > step
    target state: halted
    target halted in ARM64 state due to breakpoint, current mode: EL2H
    cpsr: 0x600003c9 pc: 0x35000074
    MMU: disabled, D-Cache: disabled, I-Cache: disabled
    timeout waiting for target halt
    in procedure 'step'
    > step
    target state: halted
    target halted in ARM64 state due to breakpoint, current mode: EL2H
    cpsr: 0x600003c9 pc: 0x35000084
    MMU: disabled, D-Cache: disabled, I-Cache: disabled
    timeout waiting for target halt
    in procedure 'step'
    > step
    target state: halted
    target halted in ARM64 state due to breakpoint, current mode: EL2H
    cpsr: 0x600003c9 pc: 0x35000090
    MMU: disabled, D-Cache: disabled, I-Cache: disabled
    timeout waiting for target halt
    in procedure 'step'

We can validate the last few single steps, with a disassembly of the u-boot binary to validate what happened

    35000078:   d518c000        msr     vbar_el1, x0
    3500007c:   d2a00600        mov     x0, #0x300000                   // #3145728
    35000080:   d5181040        msr     cpacr_el1, x0
    35000084:   94000003        bl      35000090 <apply_core_errata>

### Writing to memory

    > halt
    number of cache level 2
    cache l2 present :not supported
    hi6220.cpu cluster 0 core 0 multi core
    target state: halted
    target halted in ARM64 state due to debug-request, current mode: EL2H
    cpsr: 0x800003c9 pc: 0x3ef7e908
    MMU: disabled, D-Cache: disabled, I-Cache: disabled
    > mww 0x36000000 0xdeadbeef
    > resume

and then validate with u-boot
    # md 0x36000000
    36000000: deadbeef 555555d5 5c355555 5575555d    .....UUUUU5\]UuU

## What isn't working

Read memory access currently aren't working

    > mdw 0x35000000 1
    abort occurred - dscr = 0x0704725b
    error
    in procedure 'mdw'

DSCR is documented in H9.2.41 (page of 5155) of the ARM ARM. The cumulative error flag is set.



