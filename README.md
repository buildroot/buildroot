Buildroot
=====
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=55UJZHTXW8VTE)

## About
The Metrological buildroot is designed to configure, patch and build a WPEWebKit and all its required dependencies for embedded devices. It can be used as a development platform, for example using the Raspberry Pi 2 (or zero/1), or as a reference platform for integration with additional software components.

The Metrological buildroot includes the WPE package which is hosted here:
https://github.com/WebPlatformForEmbedded/WPEWebKit

The Metrological buildroot and Metrological WebKitForWayland forks contain changes, patches, new functionality that Metrological and partners added to comply to the latest MediaSource, Encrypted Media Extensions changes and new HTML5.x functionality specifically targeted for embedded devices. 

## Getting started

### Installation

Clone this repository:
```
git clone https://github.com/WebPlatformForEmbedded/buildroot.git
```

### Configuration

Select a configuration for your embedded device from the `configs/` directory. For example for the Raspberry Pi 2 device:
```
make raspberrypi2_wpe_defconfig
```
Buildroot provides you a menuconfig option for the first time. Select additional packages if you require or exit and save the config.

**Note** that the `_ml` (Metrological) configurations such as `raspberrypi2_wpe_ml_defconfig` should be considered for internal Metrological use only. Unless you have access to the private repositories required, the build will fail.

### Build
To build:
```
make
```

Once completed the buildroot provides you with an `output/images` directory that contains the kernel image, root filesystem and optionally firmware packages (if RPI is used) to run the complete linux environment and the WPE browser.

For more information on buildroot way of working please see their documentation: https://buildroot.org/downloads/manual/manual.html

## Usage
To launch the browser:
```
wpe <url>
```

Additionally (by default) there is a WebInspector enabled which can be reached at:
```
http://<ip of your target machine>:9998/
```

**Note** This requires a ES6 compatible browser. For example Safari nightly. 

## Supported devices

WPE is verified and being tested by Metrological on the following devices:

 - Raspberry Pi zero, 1 and 2
 - Broadcom chipsets (7430/7435) MIPS and (7252/7445) ARM
 - Intel CE (4100/4200)
 - nVidia Jetson TK1

**Note** that other devices may be supported through buildroot. But mileage may vary when it comes down to video playback and graphics performance.
