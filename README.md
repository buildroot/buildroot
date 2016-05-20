[![Metrological Logo](https://www.metrological.com/images/logo2x.png)](http://www.metrological.com)

Fast, light-weight, WebKit/Wayland based browser for embedded devices.

[![HTML5 Score][html5-image]][html5-url] [ ![MSE Coverage][mse-image] ][mse-url] [![Progressive Coverage][prog-image] ][prog-url]
<!--
[![EME Coverage][eme-image] ][eme-url]
-->

## About
The Metrological buildroot is designed to configure, patch and build a WebKitForWayland (WPE) browser and all its required dependencies for embedded devices. It can be used as a development platform, for example using the Raspberry Pi 2 (or zero/1), or as a reference platform for integration with additional software components.

The Metrological buildroot includes the WPE package which is hosted here:
https://github.com/Metrological/WebKitForWayland

The Metrological buildroot and Metrological WebKitForWayland forks contain changes, patches, new functionality that Metrological and partners added to comply to the latest MediaSource, Encrypted Media Extensions changes and new HTML5.x functionality specifically targeted for embedded devices. 

## Getting started

### Installation

Clone this repository:
```
git clone https://github.com/Metrological/buildroot-wpe.git
```

### Configuration

Select a configuration for your embedded device from the `configs/` directory. For example for the Raspberry Pi 2 device:
```
make raspberrypi2_wpe_defconfig
```
Buildroot provides you a menuconfig option for the first time. Select additional packages if you require or exit and save the config. 

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

## FAQ

A FAQ is avaibale via the [Wiki tab](https://github.com/Metrological/buildroot-wpe/wiki).

## Support

Metrological is able to provide support where needed and when needed in different methods of cooperation. For more information please visit:
https://www.metrological.com/contact.html

[mse-image]: https://img.shields.io/badge/MSE%20coverage-100%-green.svg
[mse-url]: http://yt-dash-mse-test.commondatastorage.googleapis.com/unit-tests/2016.html?enablewebm=false
[eme-image]: https://img.shields.io/badge/EME%20coverage-100%-green.svg
[eme-url]: http://yt-dash-mse-test.commondatastorage.googleapis.com/unit-tests/2015.html?test_type=encryptedmedia-test&command=run&disable_log=true
[html5-image]: https://img.shields.io/badge/HTML5%20score-440-blue.svg
[html5-url]: https://html5test.com/
[prog-image]: https://img.shields.io/badge/Progressive-100%-green.svg
[prog-url]: http://yt-dash-mse-test.commondatastorage.googleapis.com/unit-tests/tip.html
