#!/bin/bash

rsync -rv --delete $HOME/wikibackup/ joel@raspi2:/home/joel/wikibackup2/
