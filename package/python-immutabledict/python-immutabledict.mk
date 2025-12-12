################################################################################
#
# python-immutabledict
#
################################################################################

PYTHON_IMMUTABLEDICT_VERSION = 4.2.2
PYTHON_IMMUTABLEDICT_SOURCE = immutabledict-$(PYTHON_IMMUTABLEDICT_VERSION).tar.gz
PYTHON_IMMUTABLEDICT_SITE = https://files.pythonhosted.org/packages/ce/12/1da8e1a9050d0603ba65fb1796ed8860a705b906701c96e77f85cc7490be
PYTHON_IMMUTABLEDICT_SETUP_TYPE = poetry
PYTHON_IMMUTABLEDICT_LICENSE = MIT
PYTHON_IMMUTABLEDICT_LICENSE_FILES = LICENSE

$(eval $(python-package))
