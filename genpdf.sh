#!/bin/sh
pandoc -r markdown_github -w markdown -o tmp.md HiKeyGettingStarted.md
pandoc -S -o HiKeyGettingStartedGuide.pdf HiKeyGettingStarted.yaml tmp.md

