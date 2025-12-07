################################################################################
#
# linux-serial-test
#
################################################################################

LINUX_SERIAL_TEST_VERSION = e3461097252e51fc527839884e77449cfd976701
LINUX_SERIAL_TEST_SITE = $(call github,cbrake,linux-serial-test,$(LINUX_SERIAL_TEST_VERSION))
LINUX_SERIAL_TEST_LICENSE = MIT
LINUX_SERIAL_TEST_LICENSE_FILES = LICENSES/MIT

$(eval $(cmake-package))
