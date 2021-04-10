#!/bin/bash

info()  { echo -e "\\033[1;36m[INFO]\\033[0m  $*"; }
fatal() { echo -e "\\033[1;31m[FATAL]\\033[0m  $*"; exit 1 ; }

arch=$(uname -m)
ngrok=$(command -v ngrok)
neo=$(command -v neofetch)

command_exists () {

  command -v "${1}" >/dev/null 2>&1
}


neo () {
  if [ "$neo" == "/usr/bin/neofetch" ] ; then
    info "Dependencia cumplida :D"
  else
    info "Dependencia incumplida..."
    sudo apt install neofetch -y
    clear
  fi
}

check_os () {

  info "Detectando SO..."
  sleep 2

  OS=$(uname)
  readonly OS
  info "Sistema Operativo: $OS"
  sleep 2
  if [ "${OS}" = "Linux" ] ; then
    info "Iniciando instalación en Linux..."
    sleep 2
    install_linux
  else
    fatal "No soporto el sistema: $OS"
  fi
}


install_linux () {

  info "Detectando distro linux..."

  Distro=''
  if [ -d $PREFIX/include/ ] ; then
    Distro='Termux'
  elif [ -f /etc/os-release ] ; then
    DISTRO_ID=$(grep ^ID= /etc/os-release | cut -d= -f2-)
    if [ "${DISTRO_ID}" = 'kali' ] ; then
      Distro='Kali'
    elif [ "${DISTRO_ID}" = 'debian' ] ; then
      Distro='Debian'
    elif [ "${DISTRO_ID}" = 'arch' ] || [ "${DISTRO_ID}" = 'archarm' ] ; then
      Distro='Arch'
    elif [ "${DISTRO_ID}" = 'parrot' ] ; then
      Distro="Parrot"
    elif [ "${DISTRO_ID}" = "ubuntu" ] ; then
      Distro="Ubuntu"
    fi
  fi

  if [ -z "${Distro}" ] ; then
    fatal "No soporto tu distro del sistema ${OS}"
  fi

  readonly Distro
  sleep 2
  info "Distro Linux: ${Distro}"
  sleep 2
  neofetch --ascii_distro $Distro
  echo
  info "Instalando en ${Distro} paquetes necesarios..."
  sleep 3
  if [ "${Distro}" = "Debian" ] || [ "${Distro}" = "Kali" ] || [ "${Distro}" = "Ubuntu" ] || [ "${Distro}" = "Parrot" ] ; then
    apt-get update && sudo apt-get upgrade -y
    apt-get install curl git wget php openssh-server net-tools python3 python3-pip unzip -y
    clear
    config
    sleep 2
    clear
  elif [ "${Distro}" = "Arch" ]; then
    pacman -Syu # Update System...
    pacman -S curl git wget php python3 python-pip openssh unzip #dependences
    clear
    config
    sleep 2
    clear
  elif [ "${Distro}" = "Termux" ]; then
    pkg update && pkg upgrade -y
    termux-setup-storage
    pkg install -y curl wget php openssh python
    clear
    config
    sleep 2
    clear
  fi
}


config () {
if [ "$ngrok" == "/usr/bin/ngrok" ] ; then
  info "Ngrok ya instalado..."
  cat /root/.ngrok2/ngrok.yml > depen/cerberus.yml
  cat depen/config.yml >> depen/cerberus.yml
elif [ -f $PREFIX/bin/ngrok ] ; then
  info "Ngrok ya instalado..."
  cat /root/.ngrok2/ngrok.yml > depen/cerberus.yml
  cat depen/config.yml >> depen/cerberus.yml
else
  info "Ngrok no está instalado. Instalando..."
  ngrok_install
fi
}


finish () {
  echo
  info "Instalación completada!"
  echo
  info "Ejecuta: \\033[1;32m python3 cerberus.py -h\\033[0m  para iniciar ;)"
  echo
}


ngrok_install() {

if [ "${Distro}" = "Debian" ] || [ "${Distro}" = "Kali" ] || [ "${Distro}" = "Ubuntu" ] || [ "${Distro}" = "Parrot" ] ; then
    ngrok-kali
elif [ "${Distro}" = "Termux" ] ; then
    ngrok-t
else
    fatal "Instalación de ngrok en ${Distro} aún no soportada"
fi
}

ngrok-kali() {
if [ $arch == 'aarch64' ] ; then
clear
info "Instalando ngrok en ${Distro}...\\033[0m"
sleep 5
wget "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm64.tgz"
tar -xvzf  "ngrok-stable-linux-arm64.tgz"
rm ngrok-stable-linux-arm64.tgz
chmod 777 ngrok
cp ngrok /usr/bin/
sleep 5
echo -e "\033[92m[•] \033[93mEscribe tu authtoken de ngrok y pulsa ENTER... "
read -r token
$token
sleep 3
cat $HOME/.ngrok2/ngrok.yml > depen/cerberus.yml
cat depen/config.yml >> depen/cerberus.yml
info "Ngrok Listo!... "
sleep 2
clear
elif [ $arch == 'x86_64' ] ; then
info "Instalando ngrok en ${Distro}...\\033[0m"
sleep 5
wget "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip"
unzip ngrok-stable-linux-amd64.zip
rm ngrok-stable-linux-amd64.zip
chmod 777 ngrok
cp ngrok /usr/bin/
sleep 5
echo -e "\033[92m[•] \033[93mEscribe tu authtoken de ngrok y pulsa ENTER... "
read -r token
$token
sleep 1
cat /root/.ngrok2/ngrok.yml > depen/cerberus.yml
cat depen/config.yml >> depen/cerberus.yml
info "Ngrok Listo!... "
sleep 2
elif [ $arch == 'i386' ] ; then
info "Instalando ngrok en ${Distro}...\\033[0m"
sleep 5
wget "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip"
unzip ngrok-stable-linux-386.zip
rm ngrok-stable-linux-386.zip
chmod 777 ngrok
cp ngrok /usr/bin/
sleep 5
echo -e "\033[92m[•] \033[93mEscribe tu authtoken de ngrok y pulsa ENTER... "
read -r token
$token
sleep 1
cat /root/.ngrok2/ngrok.yml > depen/cerberus.yml
cat depen/config.yml >> depen/cerberus.yml
info "Ngrok Listo!... "
sleep 2
else
else
info "Instalando ngrok en ${Distro}...\\033[0m"
sleep 5
mv depen/ngrok .
chmod 777 ngrok
cp ngrok /usr/bin/
sleep 5
echo -e "\033[92m[•] \033[93mEscribe tu authtoken de ngrok y pulsa ENTER... "
read -r token
$token
sleep 1
cat $HOME/.ngrok2/ngrok.yml > depen/cerberus.yml
cat depen/config.yml >> depen/cerberus.yml
info "Ngrok Listo!... "
sleep 2
fi
}


ngrok-t() {
if [ $arch == 'aarch64' ] ; then
clear
info "Instalando ngrok en ${Distro}...\\033[0m"
sleep 5
wget "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm64.tgz"
tar -xvzf  "ngrok-stable-linux-arm64.tgz"
rm ngrok-stable-linux-arm64.tgz
chmod 777 ngrok
mv ngrok $PREFIX/bin/
cp $PREFIX/bin/ngrok .
sleep 5
echo -e "\033[92m[•] \033[93mEscribe tu authtoken de ngrok y pulsa ENTER... "
read -r token
$token
sleep 3
cat $HOME/.ngrok2/ngrok.yml > depen/cerberus.yml
cat depen/config.yml >> depen/cerberus.yml
info "Ngrok Listo!... "
sleep 2
else
clear
info "Instalando ngrok en ${Distro}...\\033[0m"
sleep 5
mv depen/ngrok .
chmod 777 ngrok
cp ngrok $PREFIX/bin/
sleep 5
echo -e "\033[92m[•] \033[93mEscribe tu authtoken de ngrok y pulsa ENTER... "
read -r token
$token
sleep 1
cat $HOME/.ngrok2/ngrok.yml > depen/cerberus.yml
cat depen/config.yml >> depen/cerberus.yml
info "Ngrok Listo!... "
sleep 2
fi
}



main () {
  clear
  neo
  check_os
  finish
}

main "$@"
