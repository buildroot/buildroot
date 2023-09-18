################################################################################
#
# python-can
#
################################################################################

PYTHON_CAN_VERSION = 4.2.2
PYTHON_CAN_SITE = https://files.pythonhosted.org/packages/dd/f1/327caaf05b6bca594250053058a2adac537a88dfb5c41bb5498cfda9de78
PYTHON_CAN_SETUP_TYPE = setuptools
PYTHON_CAN_LICENSE = LGPL-3.0
PYTHON_CAN_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
