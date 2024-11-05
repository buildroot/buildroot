################################################################################
#
# python-pkgconfig
#
################################################################################

PYTHON_PKGCONFIG_VERSION = 1.5.5
PYTHON_PKGCONFIG_SOURCE = pkgconfig-$(PYTHON_PKGCONFIG_VERSION).tar.gz
PYTHON_PKGCONFIG_SITE = https://files.pythonhosted.org/packages/c4/e0/e05fee8b5425db6f83237128742e7e5ef26219b687ab8f0d41ed0422125e
PYTHON_PKGCONFIG_SETUP_TYPE = poetry
PYTHON_PKGCONFIG_LICENSE = MIT
PYTHON_PKGCONFIG_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
