################################################################################
#
# python-varlink
#
################################################################################

PYTHON_VARLINK_VERSION = 32.1.0
PYTHON_VARLINK_SITE = $(call github,varlink,python,$(PYTHON_VARLINK_VERSION))
PYTHON_VARLINK_SETUP_TYPE = setuptools
PYTHON_VARLINK_DEPENDENCIES = host-python-setuptools-scm
PYTHON_VARLINK_LICENSE = Apache-2.0
PYTHON_VARLINK_LICENSE_FILES = LICENSE.txt
PYTHON_VARLINK_ENV = SETUPTOOLS_SCM_PRETEND_VERSION_FOR_VARLINK=$(PYTHON_VARLINK_VERSION)

$(eval $(python-package))
