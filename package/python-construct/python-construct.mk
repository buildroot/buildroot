################################################################################
#
# python-construct
#
################################################################################

PYTHON_CONSTRUCT_VERSION = 2.10.68
PYTHON_CONSTRUCT_SOURCE = construct-$(PYTHON_CONSTRUCT_VERSION).tar.gz
PYTHON_CONSTRUCT_SITE = https://files.pythonhosted.org/packages/e0/b7/a4a032e94bcfdff481f2e6fecd472794d9da09f474a2185ed33b2c7cad64
PYTHON_CONSTRUCT_SETUP_TYPE = setuptools
PYTHON_CONSTRUCT_LICENSE = MIT
PYTHON_CONSTRUCT_LICENSE_FILES = LICENSE

$(eval $(python-package))
