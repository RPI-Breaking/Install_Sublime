#!/bin/bash

cd ~
mkdir Temporary_Installing
cd Temporary_Installing

#if [ "$INSTALLEDSUB" = yes ]
#then

echo "Installing Dependancies"
sudo apt-get -qq --yes install qemu binfmt-support qemu-user-static debootstrap schroot
echo "Making the actual chroot"
sudo mkdir -p /x86
sudo debootstrap --variant=buildd --arch=i386 --foreign stretch /x86
sudo cp /usr/bin/qemu-i386-static /x86/usr/bin






echo "[x86]" > x86_temp
cat <<EOT >> x86_temp
type=directory
description=An x86 environment
directory=/x86
users=pi
root-users=root
preserve-environment=false
profile=default
EOT
sudo cp x86_temp /etc/schroot/chroot.d/
sudo mv /etc/schroot/chroot.d/x86_temp /etc/schroot/chroot.d/x86
rm x86_temp


sudo cat > sources.list << "EOF"
#deb http://debootstrap.invalid/ stretch main


deb http://deb.debian.org/debian stretch main
deb-src http://deb.debian.org/debian stretch main

deb http://deb.debian.org/debian-security/ stretch/updates main
deb-src http://deb.debian.org/debian-security/ stretch/updates main

deb http://deb.debian.org/debian stretch-updates main
deb-src http://deb.debian.org/debian stretch-updates main
EOF
sudo mkdir /x86/etc/apt
sudo mv sources.list /x86/etc/apt/


cat > .bashrc << "EOF"
#!/bin/bash

export DISPLAY=:0.0
#export LC_ALL=C

#echo $LANG


if [ "$LANG" = en_CA.UTF-8 ]
then
        subl
        echo ""
        echo "~~~~~~~~~~~~~~~~~~Opening Sublime~~~~~~~~~~~~~~~~~~"
        echo "If you quit this terminal window, sublime will quit"
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo ""
else
        export LANG=en_CA.UTF-8
        export LC_ALL=C
        echo ""
        echo "~~~~~~~~~~x86 Environment Opened~~~~~~~~~~"
        echo "           Type exit to quit"
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo ""
fi
EOF
sudo cp .bashrc /x86/root/
rm .bashrc



sudo cat <<"EOC" >> ~/.bashrc
### CHROOT CODE ###
if [ $(uname -m) = 'i686' ]
then

        export DISPLAY=:0.0
        #export LC_ALL=C
        #echo $LANG

        if [ "$LANG" = en_CA.UTF-8 ]
        then
                subl
                echo ""
                echo "~~~~~~~~~~~~~~~~~~Opening Sublime~~~~~~~~~~~~~~~~~~"
                echo "     Sorry, but you must open sublime in sudo"
                echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                echo ""
                exit
        else
                export LANG=en_CA.UTF-8
                export LC_ALL=C
                echo ""
                echo "~~~~~~~~~~x86 Environment Opened~~~~~~~~~~"
                echo "           Type exit to quit"
                echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                echo ""
        fi

else
        alias sublime="sudo schroot -c x86 -p"
        alias x86="schroot -c x86"
        alias rx86="sudo schroot -c x86"
fi

EOC










echo "Installing apt"
sudo mkdir installing_files
cd installing_files
sudo wget http://ftp.ca.debian.org/debian/pool/main/a/apt/apt_1.4.8_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/a/adduser/adduser_3.115_all.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/d/debconf/debconf_1.5.61_all.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/p/perl/perl-base_5.24.1-3+deb9u4_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/s/shadow/passwd_4.4-4.1_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/a/audit/libaudit1_2.6.7-2_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/a/audit/libaudit-common_2.6.7-2_all.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/libc/libcap-ng/libcap-ng0_0.7.7-3+b1_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/p/pam/libpam-modules_1.1.8-3.6_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/d/db5.3/libdb5.3_5.3.28-12+deb9u1_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/p/pam/libpam-modules-bin_1.1.8-3.6_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/p/pam/libpam0g_1.1.8-3.6_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/libs/libselinux/libselinux1_2.6-3+b3_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/p/pcre3/libpcre3_8.39-3_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/g/glibc/multiarch-support_2.24-11+deb9u3_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/libs/libsemanage/libsemanage1_2.6-2_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/b/bzip2/libbz2-1.0_1.0.6-8.1_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/libs/libsemanage/libsemanage-common_2.6-2_all.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/libs/libsepol/libsepol1_2.6-2_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/u/ustr/libustr-1.0-1_1.0.4-6_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/d/debian-archive-keyring/debian-archive-keyring_2017.5_all.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/g/gnupg2/gpgv_2.1.18-8~deb9u2_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/libg/libgcrypt20/libgcrypt20_1.7.6-2+deb9u3_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/libg/libgpg-error/libgpg-error0_1.26-2_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/z/zlib/zlib1g_1.2.8.dfsg-5_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/i/init-system-helpers/init-system-helpers_1.48_all.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/a/apt/libapt-pkg5.0_1.4.8_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/l/lz4/liblz4-1_0.0~r131-2+b1_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/x/xz-utils/liblzma5_5.2.2-1.2+b1_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/g/glibc/libc6_2.24-11+deb9u3_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/g/gcc-6/libgcc1_6.3.0-18+deb9u1_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/g/gcc-6/gcc-6-base_6.3.0-18+deb9u1_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/g/gcc-6/libstdc++6_6.3.0-18+deb9u1_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/a/apt/libapt-inst2.0_1.4.8_i386.deb
sudo wget http://ftp.ca.debian.org/debian/pool/main/a/apt/apt-utils_1.4.8_i386.deb
sudo schroot -c x86 -- dpkg -i --ignore-depends=apt *.deb

sudo sh -c 'echo "#! /bin/sh" > /x86/var/lib/dpkg/info/apt.postinst'
sudo schroot -c x86 -- dpkg --configure -a

sudo apt-get install x11-xserver-utils
xhost +

echo "INSTALLING SUBLIME DEPENDANCIES"
sudo schroot -c x86 -- apt-get update
sudo schroot -c x86 -- apt-get --fix-broken --yes install
sudo schroot -c x86 -- apt-get --yes install libc6:i386 libstdc++6:i386 libglib2.0-0:i386 libx11-6:i386 libpangocairo-1.0-0:i386 libgtk2.0-0:i386 wget sudo nano locales
sudo sh -c "echo '#! /bin/sh' > /x86/var/lib/dpkg/info/locales.postinst"
sudo schroot -c x86 -- dpkg --configure -a

sudo schroot -c x86 -- localedef -i en_CA -f UTF-8 en_CA.UTF-8
sudo schroot -c x86 -- echo LANG="en_CA.UTF-8" > /etc/locale.conf


echo "INSTALLING SUBLIME"
sudo wget https://download.sublimetext.com/sublime-text_build-3126_i386.deb
sudo schroot -c x86 -- dpkg -i sublime-text_build-3126_i386.deb
#fi

sudo mkdir /sublime/

sudo sh -c 'echo "#! /bin/bash" > /sublime/launch.sh'
sudo sh -c 'echo "sudo schroot -c x86 -p" >> /sublime/launch.sh'
sudo chmod a+x /sublime/launch.sh
sudo wget https://www.sublimetext.com/images/icon.png
sudo cp icon.png /sublime/

cat > sublime.desktop << "EOR"
[Desktop Entry]
Encoding=UTF-8
Exec=/sublime/launch.sh
Icon=/sublime/icon.png
Type=Application
Terminal=true
Name=Sublime
GenericName=sublime
StartupNotify=false
Categories=Development
EOR
sudo cp sublime.desktop /usr/share/applications/
rm sublime.desktop


#cd /x86/opt/sublime_text/Packages/
#sudo git clone git://github.com/kemayo/sublime-text-2-git.git Git
#sudo git clone https://github.com/alienhard/SublimeAllAutocomplete


echo "DONE"



cd ~
sudo rm -r /home/pi/Temporary_Installing
