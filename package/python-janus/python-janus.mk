################################################################################
#
# python-janus
#
################################################################################

PYTHON_JANUS_VERSION = 1.0.0
PYTHON_JANUS_SOURCE = janus-$(PYTHON_JANUS_VERSION).tar.gz
PYTHON_JANUS_SITE = https://files.pythonhosted.org/packages/b8/a8/facab7275d7d3d2032f375843fe46fad1cfa604a108b5a238638d4615bdc
PYTHON_JANUS_SETUP_TYPE = setuptools
PYTHON_JANUS_LICENSE = Apache-2.0
PYTHON_JANUS_LICENSE_FILES = LICENSE

$(eval $(python-package))
