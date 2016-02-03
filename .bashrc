#!/usr/bin/env bash
# Cases where this file could be loaded:
# 1. Non-login interactive shell
# 2. Remote shell (over SSH or similar)
[ -n "$PS1" ] && source ~/.bash_profile;
