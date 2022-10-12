#!/bin/sh
xrandr \
	--output DisplayPort-3 --primary --mode 3840x2160 --pos 3840x2160 --rotate normal  \
	--output DisplayPort-4 --mode 3840x2160 --pos 7680x2160 --rotate normal  \
	--output DisplayPort-5 --mode 3840x2160 --pos 0x2160 --rotate normal  \
	--output DisplayPort-1-0 --mode 3840x2160 --pos 3840x0 --rotate normal  \
	--output DisplayPort-1-1 --mode 3840x2160 --pos 0x0 --rotate normal  \
	--output DisplayPort-1-2 --mode 3840x2160 --pos 7680x0 --rotate normal  \
	--output HDMI-A-1 --off \
	--output HDMI-A-1-0 --off \
	--output DVI-D-1-0 --off

