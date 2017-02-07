#!/bin/bash

cd $HOME

#git, gcc, make...
xargs -I pkg sudo apt-get --yes install pkg < $HOME/before-dep.txt
apt-get clean 

#bspwm dependencies
xargs -I pkg sudo apt-get --yes install pkg < $HOME/bspwm-dep.txt
apt-get clean

#polybar dependencies
xargs -I pkg sudo apt-get --yes install pkg < $HOME/polybar-dep.txt
apt-get clean

#install bspwm
[ -d $HOME/Downloads ] || mkdir $HOME/Downloads

cd $HOME/Downloads

git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/bspwm.git

cd bspwm
make
make install

[ -d $HOME/.config/bspwm ] || mkdir -p $HOME/.config/bspwm

cp examples/bspwmrc $HOME/.config/bspwm
chmod +x $HOME/.config/bspwm/bspwmrc

cd ../sxhkd
make
make install

[ -d $HOME/.config/sxhkd ] || mkdir $HOME/.config/sxhkd 

cp examples/sxhkdrc $HOME/.config/sxhkd

cd $HOME

[ -f .xinitrc ] || cat > .xinitrc
echo "sxhkd &" >> .xinitrc
echo "urxvt &" >> .xinitrc
echo "exec bspwm" >> .xinitrc 

#install polybar

#install software
