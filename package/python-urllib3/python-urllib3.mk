################################################################################
#
# python-urllib3
#
################################################################################

PYTHON_URLLIB3_VERSION = 2.3.0
PYTHON_URLLIB3_SOURCE = urllib3-$(PYTHON_URLLIB3_VERSION).tar.gz
PYTHON_URLLIB3_SITE = https://files.pythonhosted.org/packages/aa/63/e53da845320b757bf29ef6a9062f5c669fe997973f966045cb019c3f4b66
PYTHON_URLLIB3_LICENSE = MIT
PYTHON_URLLIB3_LICENSE_FILES = LICENSE.txt
PYTHON_URLLIB3_CPE_ID_VENDOR = python
PYTHON_URLLIB3_CPE_ID_PRODUCT = urllib3
PYTHON_URLLIB3_SETUP_TYPE = hatch
PYTHON_URLLIB3_DEPENDENCIES = host-python-hatch-vcs
HOST_PYTHON_URLLIB3_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
$(eval $(host-python-package))
