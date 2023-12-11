#!/usr/bin/zsh

blank='00000000'
white='ECEFF4'
black='2E3440'
blue='5E81AC'
pale_blue='81A1C1'
green='A3BE8C'
red='D08770'

i3lock \
	--color=$black \
	--inside-color=$blank \
	--insidever-color=$blank \
	--insidewrong-color=$blank \
	--ring-color=$blue \
	--ringver-color=$green \
	--ringwrong-color=$red \
	--keyhl-color=$pale_blue \
	--bshl-color=$pale_blue \
	--line-color=$black \
	--separator-color=$blank \
	--radius=200 \
	--ring-width=10 \
	--verif-text='' \
	--wrong-text='' \
	--noinput-text='' \
	--lock-text='' \
	--lockfailed-text='' \
	--clock \
	--force-clock \
	--indicator \
	--time-color=$white \
	--date-color=$blank \
	--time-str="%H:%M"
