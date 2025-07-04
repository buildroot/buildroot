################################################################################
#
# clpeak
#
################################################################################

CLPEAK_VERSION = 1.1.5
CLPEAK_SITE = $(call github,krrishnarraj,clpeak,$(CLPEAK_VERSION))
CLPEAK_LICENSE = Apache-2.0
CLPEAK_LICENSE_FILES = LICENSE
CLPEAK_DEPENDENCIES = libopencl opencl-clhpp

$(eval $(cmake-package))
