################################################################################
#
# python-pathspec
#
################################################################################

PYTHON_PATHSPEC_VERSION = 1.0.4
PYTHON_PATHSPEC_SOURCE = pathspec-$(PYTHON_PATHSPEC_VERSION).tar.gz
PYTHON_PATHSPEC_SITE = https://files.pythonhosted.org/packages/fa/36/e27608899f9b8d4dff0617b2d9ab17ca5608956ca44461ac14ac48b44015
PYTHON_PATHSPEC_LICENSE = MPL-2.0
PYTHON_PATHSPEC_LICENSE_FILES = LICENSE
PYTHON_PATHSPEC_SETUP_TYPE = flit

$(eval $(python-package))
$(eval $(host-python-package))
