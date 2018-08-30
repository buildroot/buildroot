# Features / functions of this Buildroot configuration

This file describes the features/functions of the first working Buildroot configuration for the Santa Fe Opera e-libretto program.  The goal is to provide a tight kernel and OS image to run the functionality that we need.

This BuildRoot source is based and mirrored from the [latest official BuildRoot repo]( http://git.buildroot.net/buildroot/).  I've made a new branch derived from the ```2018.05.x``` branch of that repo.  *At the time of this writing, this is the most current stable release of BuildRoot.

The Santa Fe Opera working branch is called ```2018.05.sfe```.  To check it out into a working directory called ```br-sfe```, you'd run the following command:

```
git clone -b 2018.05.sfe git@github.com:santafeopera/buildroot.git br-sfe
```

Type "make" from that ```br-sfe``` directory, and it should make a new compute module image for you that you can burn onto the CM's using dd or something.

## Note on the ```.config``` file

Normally, the ```.config``` file in the base $BR directory is in .gitignore and not stored on the repo.  The intent is that you'd check out the BuildRoot git repo, perform a ```

At the time of writing, the SD Card image size is just under 400MB.  The target's root filesystem has 107M free.  We could make this bigger if our Serf programs get big, but it's unlikely too, really.

# Getting Started
```$BR```  the root of the BuildRoot tree that you checked out from Github.  For my lab machine, it's located at ```~/br/2018-05-v3-sfe```, created by issuing the following command from the ```~/br``` directory.  It was my third version of trying to do this, so that's why the v3, but feel free to use any directory name, obviously.

## Pull the SFO branch from the repo

You must use the ```-b 2018-05-sfe``` option to git clone in order to grab the right source files.

1. Clone the SFO BuildRoot repo:
```
 git clone -b 2018.05.sfe git@github.com:santafeopera/buildroot.git sfe1
```

  This command will clone the proper branch of the repo and put it into the directory called ```sfe1``` relative to your current directory.

2. Create the default "santafeopera" config:
```
cd sfe1
make santafeopera_defconfig
```

3. Create the image file...

  This will take a long time, even on a beefy x86 server.  Close to an hour to build it entirely from source.
```
make
```

4. Burn the image file

  Use the "rpiboot" process to put the Compute Module on an IO Development Kit board into "USB Drive" mode.  That way, it acts just like a USB memory stick.

  Use the standard Linux ```dd``` command to burn the image onto a Compute Module.  Alternatively, look in the directory ```$BR/utils``` for a Python3 script called ```ddwrite```.

  ```ddwrite``` has some convenience and safety functions to make burning a Compute Module safer and easier, with realtime progress reporting. Feel free to put it into your ~/bin directory.

### Customizing the installation

If you want to add more packages, you can do a

```
make menuconfig
```

to use this, you have to have the ```ncurses``` package installed on the host system. To do this on Ubuntu, you'd type:

```
sudo apt-get update && sudo apt-get install ncurses5
```

Once you've added or taken away packages or otherwise changed the configuration, just go back to the buildroot base directory and type ```make```.

#### Buildroot Hygiene

Sometimes, for some changes to be effected, you actually have to clean up the directory and then rebuild prettyu close to scratch.  Examples of this are if you want to delete files from the ROOTFS overlay (located in ```$BR/boards/santafeopera/rootfs_overlay```), and maybe others.

Just do a ```make clean``` and then a ```make``` will rebuild the target system image.

Note, that doing a ```make clean``` will delete the $BR/.config file and any customizations that are not part of the default ```santafeopera``` config.

# Misc Notes

## Networking

* DHCP works
* Hostname is "cm01" but you can change it by editing ```/etc/hostname```
* Bonjour/MDNS/Avahi works, so you can do ```ping cm01.local```
* OpenSSHD (and OpenSSH) are configured.  You can remote login to "cm01".
* Root password is ```asdfasdf```.
* SSH public keys are entered for my local NYC machines.  The place to add to this is in ```$BR/boards/santafeopera/rootfs_overlay/root/.ssh/authorized_keys```.  Then, the next time that you rebuild the kernel, you'll be able to login without a password.

## Misc Utilities Enabled (as requested by Scott)

* GPIO utilities
* RPi.GPIO Python library (WiringPi)
* bash
* ssh
* vim
* awk
* sed
* i2cdetect
    * *Binary works, but not sure if the i2c subsystem is functioning correctly. Haven't tested it out one way or the other.*
* iperf3

## Graphics

* The backlight automatically gets turned on at boot from the script located in ```/usr/local/bin/sfo_backlight```.  If no parameters are provided to the script, then 50% is assumed.

### PyQT5
* PyQt5 works. See the ```/root/pyqt5-test``` directory for a test.
* The QT5 variables defining the screen resolution and size are defined in the file ```/root/.qt5-env.sh``` which is sourced by ```/root/.profile```.

### Cross Compiling C++ Qt5

* There is no compiler on the target Carrier Board system.  All compilation must be done on the x86 HOST Ubuntu machine.

* I haven't looked into cross-compiling a Qt5 C++ program yet.  [This is a good reference page](http://www.jumpnowtek.com/rpi/Raspberry-Pi-Systems-with-Buildroot.html), and specifically, the section on ```Using the Buildroot cross-toolchain``` towards the end of that page.  I've cross compiled a hello world (shell only, not Qt) on my x85 Ubuntu box and it worked well on the CB.

* There's a simple Hello-World C program that is build using the cross compiler that BuildRoot generates.  The C source and makefile are located in ```$BR/board/santafeopera/src/hwc```.

  Note that the compiler that the Makefile uses is the cross-compiler, and it's located at ```$BR/output/host/usr/bin/arm-linux-gcc```.

  All of the cross-compiler libraries, includes and binaries are located in the ```$BR/output/host``` directory, so I suspect that you can just follow the same pattern as in the simple ```hwc``` example.

## Touchscreen

* I have not gotten the touchscreen to work yet.  Haven't really tried.  That's next on my list, most likely after some help from Scott.

# TTD

* Touchscreen, as mentioned above.

* Turns out that ```ZeroMQ``` as well as the multi-cast ```NORM``` protocol have pre-built packages in the latest BuildRoot release (which is the one that this is built on).  I'll be working on getting that right.
Buildroot is a simple, efficient and easy-to-use tool to generate embedded
Linux systems through cross-compilation.


# Original Distribution README

The documentation can be found in docs/manual. You can generate a text
document with 'make manual-text' and read output/docs/manual/manual.text.
Online documentation can be found at http://buildroot.org/docs.html

To build and use the buildroot stuff, do the following:

1) run 'make menuconfig'
2) select the target architecture and the packages you wish to compile
3) run 'make'
4) wait while it compiles
5) find the kernel, bootloader, root filesystem, etc. in output/images

You do not need to be root to build or run buildroot.  Have fun!

Buildroot comes with a basic configuration for a number of boards. Run
'make list-defconfigs' to view the list of provided configurations.

Please feed suggestions, bug reports, insults, and bribes back to the
buildroot mailing list: buildroot@buildroot.org
You can also find us on #buildroot on Freenode IRC.

If you would like to contribute patches, please read
https://buildroot.org/manual.html#submitting-patches
