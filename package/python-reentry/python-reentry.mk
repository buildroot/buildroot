################################################################################
#
# python-reentry
#
################################################################################

PYTHON_REENTRY_VERSION = 1.3.3
PYTHON_REENTRY_SOURCE = reentry-$(PYTHON_REENTRY_VERSION).tar.gz
PYTHON_REENTRY_SITE = https://files.pythonhosted.org/packages/95/20/e820a29014f1cb662423d7001dc09a9ea5280083ea300f0c5efe5cae238b
PYTHON_REENTRY_SETUP_TYPE = setuptools
PYTHON_REENTRY_LICENSE = MIT
PYTHON_REENTRY_LICENSE_FILES = LICENSE

$(eval $(python-package))
