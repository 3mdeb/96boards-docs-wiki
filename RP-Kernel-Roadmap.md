## Introduction
The Reference Platform Kernel(RPK) brings together WIP code that is still under review upstream to provide a single kernel image for 96boards and other Linaro member hardware of interest.

The kernel tree is managed similar to linux-next, in that topic branches adding support for various platforms and new kernel features are merged on top of a (close-to-mainline) vanilla kernel. See the [table](#kernel-version-table) below for a roadmap of proposed kernel versions for future releases.

## Why is RPK needed?
 1. To allow engineers to focus on new features instead of spending time on HW enablement
 1. To find integration problems early
 1. To make it easy to measure the delta between an upstream kernel and what is needed to get a platform working

## Kernel Version Table
| RPB Release | Kernel Version | LEG | LHG | LNG | LMG |
|---|---|---|---|---|---|
|16.03   |4.4   | Y | - | - | - |
|16.06   |4.4   | Y | Y | Y | ? |
|16.09   |4.6?  | S | ? | ? | ? |
|16.12   |4.8?  | Y | ? | ? | ? |

     - Not supported
     ? Undecided
     S Skipped (e.g. LEG follows a 6-month cycle)
     Y Supported (features and platforms)

## Development Branches

## FAQ
 1. How is this different from linux-linaro?  
    RPK has a lot of similarities to linux-linaro. However, RPK focuses on code that is being actively reviewed upstream. If code isn't going upstream, then it doesn't belong in RPK. RPK will drop any code that shows no progress upstream.
 1. Will you support an LTS kernel for 'X' years?  
    No. RPK's main focus is on engineers and teams that need to get their code upstream as a requirement to get distribution support (e.g. LEG) or that need to work on tip to get new features accepted into the kernel (e.g. core engineering teams such at KWG, PMWG). We don't have resources to maintain a long-term kernel. Please talk to the LSK team for a long-term kernel

## Additional Material
 * [Talk](https://www.youtube.com/watch?v=fW6_eL3U7OQ) about RPK at BKK16 (March 2016)