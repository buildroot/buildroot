################################################################################
#
# python-twisted
#
################################################################################

# When bumping this package, make sure to also verify if the
# python-treq package still works and to update its hash,
# as they share the same version/site variables.
PYTHON_TWISTED_VERSION = 22.2.0
PYTHON_TWISTED_SOURCE = Twisted-$(PYTHON_TWISTED_VERSION).tar.gz
PYTHON_TWISTED_SITE = https://files.pythonhosted.org/packages/40/8b/56e8870d412c550b3ff2d6714ee212c7e80a6634f4e720c3a26a983e7b46
PYTHON_TWISTED_SETUP_TYPE = setuptools
PYTHON_TWISTED_LICENSE = MIT
PYTHON_TWISTED_LICENSE_FILES = LICENSE
PYTHON_TWISTED_CPE_ID_VENDOR = twistedmatrix
PYTHON_TWISTED_CPE_ID_PRODUCT = twisted
PYTHON_TWISTED_DEPENDENCIES = python-incremental host-python-incremental

$(eval $(python-package))
