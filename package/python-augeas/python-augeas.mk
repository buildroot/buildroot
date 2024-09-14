################################################################################
#
# python-augeas
#
################################################################################

PYTHON_AUGEAS_VERSION = 1.2.0
PYTHON_AUGEAS_SITE = $(call github,hercules-team,python-augeas,v$(PYTHON_AUGEAS_VERSION))
PYTHON_AUGEAS_SETUP_TYPE = setuptools
PYTHON_AUGEAS_LICENSE = LGPL-2.1+
PYTHON_AUGEAS_LICENSE_FILES = COPYING
PYTHON_AUGEAS_DEPENDENCIES = augeas host-python-cffi host-pkgconf
# This will tell python-augeas to not call xml2-config, and instead
# use pkg-config to find libxml2. libxml2 is an indirect dependency of
# augeas, which is why it's not in our dependencies. It's odd that
# python-augeas searches for libxml2, but that's what it
# does. Question asked in the pull request at
# https://github.com/hercules-team/python-augeas/pull/49.
PYTHON_AUGEAS_ENV = XML2_CONFIG=/bin/false

$(eval $(python-package))
