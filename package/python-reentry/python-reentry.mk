################################################################################
#
# python-reentry
#
################################################################################

PYTHON_REENTRY_VERSION = 1.3.2
PYTHON_REENTRY_SOURCE = reentry-$(PYTHON_REENTRY_VERSION).tar.gz
PYTHON_REENTRY_SITE = https://files.pythonhosted.org/packages/a0/88/eb0c107c19227a2292ed11711034a3d80c0dc1368d2b3ebeb3fe7b936a8e
PYTHON_REENTRY_SETUP_TYPE = setuptools
PYTHON_REENTRY_LICENSE = MIT
PYTHON_REENTRY_LICENSE_FILES = LICENSE

$(eval $(python-package))
