################################################################################
#
# python-markupsafe
#
################################################################################

PYTHON_MARKUPSAFE_VERSION = 3.0.1
PYTHON_MARKUPSAFE_SOURCE = markupsafe-$(PYTHON_MARKUPSAFE_VERSION).tar.gz
PYTHON_MARKUPSAFE_SITE = https://files.pythonhosted.org/packages/b4/d2/38ff920762f2247c3af5cbbbbc40756f575d9692d381d7c520f45deb9b8f
PYTHON_MARKUPSAFE_SETUP_TYPE = setuptools
PYTHON_MARKUPSAFE_LICENSE = BSD-3-Clause
PYTHON_MARKUPSAFE_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
$(eval $(host-python-package))
