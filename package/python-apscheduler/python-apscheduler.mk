################################################################################
#
# python-apscheduler
#
################################################################################

PYTHON_APSCHEDULER_VERSION = 3.11.1
PYTHON_APSCHEDULER_SOURCE = apscheduler-$(PYTHON_APSCHEDULER_VERSION).tar.gz
PYTHON_APSCHEDULER_SITE = https://files.pythonhosted.org/packages/d0/81/192db4f8471de5bc1f0d098783decffb1e6e69c4f8b4bc6711094691950b
PYTHON_APSCHEDULER_SETUP_TYPE = setuptools
PYTHON_APSCHEDULER_DEPENDENCIES = host-python-setuptools-scm
PYTHON_APSCHEDULER_LICENSE = MIT
PYTHON_APSCHEDULER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
