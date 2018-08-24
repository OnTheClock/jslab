#!/bin/bash

rsync -r --delete $HOME/wikibackup/ joel@raspi2:/home/joel/wikibackup2/
