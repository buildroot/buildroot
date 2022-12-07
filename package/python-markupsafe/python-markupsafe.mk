################################################################################
#
# python-markupsafe
#
################################################################################

PYTHON_MARKUPSAFE_VERSION = 2.1.1
PYTHON_MARKUPSAFE_SOURCE = MarkupSafe-$(PYTHON_MARKUPSAFE_VERSION).tar.gz
PYTHON_MARKUPSAFE_SITE = https://files.pythonhosted.org/packages/1d/97/2288fe498044284f39ab8950703e88abbac2abbdf65524d576157af70556
PYTHON_MARKUPSAFE_SETUP_TYPE = setuptools
PYTHON_MARKUPSAFE_LICENSE = BSD-3-Clause
PYTHON_MARKUPSAFE_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))
$(eval $(host-python-package))
