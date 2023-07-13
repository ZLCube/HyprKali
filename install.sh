#!/bin/bash

if [ "$(whoami)" == "root" ]; then
    exit 1
fi

ruta=$(pwd)

#Creamos una carpeta llamada HyprSource en descargas

mkdir ~/Downloads/HyprSource

#Copiamos la libreria a HyprSource

cp $ruta/libliftoff-master.tar.gz ~/Downloads/HyprSource

#Instalamos las dependencias bprincipales de hyprland 

sudo apt-get install -y meson wget build-essential ninja-build cmake-extras cmake gettext gettext-base fontconfig libfontconfig-dev libffi-dev libxml2-dev libdrm-dev libxkbcommon-x11-dev libxkbregistry-dev libxkbcommon-dev libpixman-1-dev libudev-dev libseat-dev seatd libxcb-dri3-dev libvulkan-dev libvulkan-volk-dev  vulkan-validationlayers-dev libvkfft-dev libgulkan-dev libegl-dev libgles2 libegl1-mesa-dev glslang-tools libinput-bin libinput-dev libxcb-composite0-dev libavutil-dev libavcodec-dev libavformat-dev libxcb-ewmh2 libxcb-ewmh-dev libxcb-present-dev libxcb-icccm4-dev libxcb-render-util0-dev libxcb-res0-dev libxcb-xinput-dev xdg-desktop-portal-wlr hwdata libliftoff-dev libwlroots-dev

cd ~/Downloads && sudo apt-get install -y nala

sudo nala install -y meson wget build-essential ninja-build cmake-extras cmake gettext gettext-base fontconfig libfontconfig-dev libffi-dev libxml2-dev libdrm-dev libxkbcommon-x11-dev libxkbregistry-dev libxkbcommon-dev libpixman-1-dev libudev-dev libseat-dev seatd libxcb-dri3-dev libvulkan-dev libvulkan-volk-dev  vulkan-validationlayers-dev libvkfft-dev libgulkan-dev libegl-dev libgles2 libegl1-mesa-dev glslang-tools libinput-bin libinput-dev libxcb-composite0-dev libavutil-dev libavcodec-dev libavformat-dev libxcb-ewmh2 libxcb-ewmh-dev libxcb-present-dev libxcb-icccm4-dev libxcb-render-util0-dev libxcb-res0-dev libxcb-xinput-dev libpango1.0-dev xdg-desktop-portal-wlr

#Instalamos mas dependencias de hyprland

cd ~/Downloads/HyprSource && wget https://github.com/hyprwm/Hyprland/releases/download/v0.24.1/source-v0.24.1.tar.gz && tar -xvf source-v0.24.1.tar.gz && rm -r source-v0.24.1.tar.gz

wget https://gitlab.freedesktop.org/wayland/wayland-protocols/-/releases/1.31/downloads/wayland-protocols-1.31.tar.xz && tar -xvJf wayland-protocols-1.31.tar.xz && rm -r wayland-protocols-1.31.tar.xz

wget https://gitlab.freedesktop.org/wayland/wayland/-/releases/1.22.0/downloads/wayland-1.22.0.tar.xz && tar -xvJf wayland-1.22.0.tar.xz && rm -r wayland-1.22.0.tar.xz

wget https://gitlab.freedesktop.org/emersion/libdisplay-info/-/releases/0.1.1/downloads/libdisplay-info-0.1.1.tar.xz && tar -xvJf libdisplay-info-0.1.1.tar.xz && rm -r libdisplay-info-0.1.1.tar.xz

tar -zxvf libliftoff-master.tar.gz && rm -r libliftoff-master.tar.gz

#Compilamos los paquetes instalados 

cd libliftoff-master && meson setup build/ && ninja -C build/ && cd ..

cd wayland-1.22.0 && mkdir build && cd build/ && meson setup .. --prefix=/usr --buildtype=release -Ddocumentation=false && ninja && sudo ninja install && cd ../.. 

cd wayland-protocols-1.31 && mkdir build && cd build/ && meson setup --prefix=/usr --buildtype=release && ninja && sudo ninja install && cd ../..

cd libdisplay-info-0.1.1 && mkdir build && cd build && meson setup --prefix=/usr --buildtype=release && ninja && sudo ninja install && cd ../..

#Ahora instalamos hyprland

chmod a+rw hyprland-source/ && cd hyprland-source 
sed -i 's/\/usr\/local/\/usr/g' config.mk
sudo make install



