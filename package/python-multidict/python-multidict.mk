################################################################################
#
# python-multidict
#
################################################################################

PYTHON_MULTIDICT_VERSION = 7.1.0
PYTHON_MULTIDICT_SOURCE = multidict-$(PYTHON_MULTIDICT_VERSION).tar.gz
PYTHON_MULTIDICT_SITE = https://files.pythonhosted.org/packages/f9/79/84ddb5ba16c4eb2c69c71db76ae3c579fe546e511f7170c7e27eedbab7c1
PYTHON_MULTIDICT_SETUP_TYPE = setuptools
PYTHON_MULTIDICT_LICENSE = Apache-2.0
PYTHON_MULTIDICT_LICENSE_FILES = LICENSE

$(eval $(python-package))
