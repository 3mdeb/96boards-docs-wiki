## Introduction
The Reference Platform Kernel(RPK) brings together WIP code that is still under review upstream to provide a single kernel image for 96boards and other Linaro member hardware of interest.

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

## Additional Material
 * [Talk](https://www.youtube.com/watch?v=fW6_eL3U7OQ) about RPK at BKK16 (March 2016)