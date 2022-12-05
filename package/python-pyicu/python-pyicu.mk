################################################################################
#
# python-pyicu
#
################################################################################

PYTHON_PYICU_VERSION = 2.10.2
PYTHON_PYICU_SOURCE = PyICU-$(PYTHON_PYICU_VERSION).tar.gz
PYTHON_PYICU_SITE = https://files.pythonhosted.org/packages/64/00/a531e119a97e54601f616f5061879ec2d4bb058d225014f9acf94b2970c3
PYTHON_PYICU_LICENSE = MIT
PYTHON_PYICU_LICENSE_FILES = LICENSE
PYTHON_PYICU_DEPENDENCIES = icu
PYTHON_PYICU_SETUP_TYPE = setuptools

$(eval $(python-package))
