################################################################################
#
# python-markupsafe
#
################################################################################

PYTHON_MARKUPSAFE_VERSION = 2.1.5
PYTHON_MARKUPSAFE_SOURCE = MarkupSafe-$(PYTHON_MARKUPSAFE_VERSION).tar.gz
PYTHON_MARKUPSAFE_SITE = https://files.pythonhosted.org/packages/87/5b/aae44c6655f3801e81aa3eef09dbbf012431987ba564d7231722f68df02d
PYTHON_MARKUPSAFE_SETUP_TYPE = setuptools
PYTHON_MARKUPSAFE_LICENSE = BSD-3-Clause
PYTHON_MARKUPSAFE_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))
$(eval $(host-python-package))
