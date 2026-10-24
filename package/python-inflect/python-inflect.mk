################################################################################
#
# python-inflect
#
################################################################################

PYTHON_INFLECT_VERSION = 7.6.0
PYTHON_INFLECT_SOURCE = inflect-$(PYTHON_INFLECT_VERSION).tar.gz
PYTHON_INFLECT_SITE = https://files.pythonhosted.org/packages/9b/4e/2836918b501ac34bf42c14dabc039ed83ce8a81bb5711e3ee4f526deedce
PYTHON_INFLECT_SETUP_TYPE = setuptools
PYTHON_INFLECT_LICENSE = MIT
PYTHON_INFLECT_LICENSE_FILES = LICENSE
PYTHON_INFLECT_DEPENDENCIES = \
	host-python-coherent-licensed \
	host-python-setuptools-scm

$(eval $(python-package))
