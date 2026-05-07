#!/usr/bin/env zsh

blank='00000000'
white='ECEFF4'
black='2E3440'
blue='5E81AC'
pale_blue='81A1C1'
green='A3BE8C'
red='D08770'

swaylock \
  --daemonize \
  --color $black \
  --indicator-radius 200 \
  --indicator-thickness 10 \
  --inside-color 00000000 \
  --inside-ver-color 00000000 \
  --inside-wrong-color 00000000 \
  --ring-color $blue \
  --ring-ver-color $green \
  --ring-wrong-color $red \
  --key-hl-color $pale_blue \
  --bs-hl-color $pale_blue \
  --separator-color 00000000 \
  --line-color 00000000 \
  --text-clear-color 00000000 \
  --text-ver-color 00000000 \
  --text-wrong-color 00000000
