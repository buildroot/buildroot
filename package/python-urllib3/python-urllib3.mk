################################################################################
#
# python-urllib3
#
################################################################################

PYTHON_URLLIB3_VERSION = 2.6.2
PYTHON_URLLIB3_SOURCE = urllib3-$(PYTHON_URLLIB3_VERSION).tar.gz
PYTHON_URLLIB3_SITE = https://files.pythonhosted.org/packages/1e/24/a2a2ed9addd907787d7aa0355ba36a6cadf1768b934c652ea78acbd59dcd
PYTHON_URLLIB3_LICENSE = MIT
PYTHON_URLLIB3_LICENSE_FILES = LICENSE.txt
PYTHON_URLLIB3_CPE_ID_VENDOR = python
PYTHON_URLLIB3_CPE_ID_PRODUCT = urllib3
PYTHON_URLLIB3_SETUP_TYPE = hatch
PYTHON_URLLIB3_DEPENDENCIES = host-python-hatch-vcs
HOST_PYTHON_URLLIB3_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
$(eval $(host-python-package))
