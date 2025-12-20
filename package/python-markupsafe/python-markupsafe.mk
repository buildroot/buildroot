################################################################################
#
# python-markupsafe
#
################################################################################

PYTHON_MARKUPSAFE_VERSION = 3.0.3
PYTHON_MARKUPSAFE_SOURCE = markupsafe-$(PYTHON_MARKUPSAFE_VERSION).tar.gz
PYTHON_MARKUPSAFE_SITE = https://files.pythonhosted.org/packages/7e/99/7690b6d4034fffd95959cbe0c02de8deb3098cc577c67bb6a24fe5d7caa7
PYTHON_MARKUPSAFE_SETUP_TYPE = setuptools
PYTHON_MARKUPSAFE_LICENSE = BSD-3-Clause
PYTHON_MARKUPSAFE_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
$(eval $(host-python-package))
