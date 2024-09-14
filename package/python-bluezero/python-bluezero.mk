################################################################################
#
# python-bluezero
#
################################################################################

PYTHON_BLUEZERO_VERSION = 0.9.0
PYTHON_BLUEZERO_SOURCE = bluezero-$(PYTHON_BLUEZERO_VERSION).tar.gz
PYTHON_BLUEZERO_SITE = https://files.pythonhosted.org/packages/7b/9c/bfb3e1f92dd39bf3de8fc483a102bfae763fbf156177b77ed96b8a38bbb1
PYTHON_BLUEZERO_SETUP_TYPE = setuptools
PYTHON_BLUEZERO_LICENSE = MIT
PYTHON_BLUEZERO_LICENSE_FILES = LICENSE

$(eval $(python-package))
