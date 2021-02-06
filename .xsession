before=0
PATH=$PATH:/home/thepei/UserCmd
export GTK_IM_MODULE=fcitx &
export QT_IM_MODULE=fcitx &
export XMODIFIERS=@im=fcitx &
fcitx &
while xsetroot -name "M:$(free -m | awk 'NR==2{print $3}')/$(free -m | awk 'NR==2{print $2}')\
|W:$(cat /sys/class/net/wlp5s0/operstate)\
|E:$(cat /sys/class/net/enp4s0/operstate)\
|B:$(acpi -b | awk '{print $4}' | cut -d"," -f1)\
|L:$(cat /sys/class/backlight/intel_backlight/brightness)\
|V:$(amixer get Master | awk -F'[][]' 'END{ print $4":"$2 }')\
|$(LC_ALL='C' date +'%F[%b %a] %R')"
do
done &
while :
do
	cur=$(acpi -i | awk 'NR==1{print $3}')
	if [ $before != $cur ];
	then
		if [ $cur = "Discharging," ];
		then
			xset s on
			xset +dpms
		else
			xset s off
			xset -dpms
		fi
		before=$cur
	fi
	sleep 2
done &
feh --bg-fill ~/bg/debianBG.png &
numlockx &
exec dwm
