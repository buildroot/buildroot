################################################################################
#
# python-terminaltables
#
################################################################################

PYTHON_TERMINALTABLES_VERSION = 3.1.10
PYTHON_TERMINALTABLES_SOURCE = terminaltables-$(PYTHON_TERMINALTABLES_VERSION).tar.gz
PYTHON_TERMINALTABLES_SITE = https://files.pythonhosted.org/packages/f5/fc/0b73d782f5ab7feba8d007573a3773c58255f223c5940a7b7085f02153c3
PYTHON_TERMINALTABLES_SETUP_TYPE = poetry
PYTHON_TERMINALTABLES_LICENSE = MIT
PYTHON_TERMINALTABLES_LICENSE_FILES = LICENSE

$(eval $(python-package))
