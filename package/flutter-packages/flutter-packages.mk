################################################################################
#
# flutter-packages
#
################################################################################

FLUTTER_PACKAGES_VERSION = 71e827e7df6833e6942873361f189adcb041d7f1
FLUTTER_PACKAGES_SITE = $(call github,flutter,packages,$(FLUTTER_PACKAGES_VERSION))
FLUTTER_PACKAGES_LICENSE = BSD-3-Clause
FLUTTER_PACKAGES_LICENSE_FILES = LICENSE
FLUTTER_PACKAGES_DL_SUBDIR = flutter-packages

# This default value *is* required, because this file is not a package (it
# does not call any of the *-package macros), so the _SOURCE variable is not
# defined. However, we need a variable for the sub-packages to share the
# same tarball name.
# check-package disable lib_mk.RemoveDefaultPackageSourceVariable
FLUTTER_PACKAGES_SOURCE = flutter-packages-$(FLUTTER_PACKAGES_VERSION).tar.gz

FLUTTER_PACKAGES_DEPENDENCIES = \
	host-flutter-sdk-bin \
	flutter-engine

include $(sort $(wildcard package/flutter-packages/*/*.mk))
