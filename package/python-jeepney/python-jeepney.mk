################################################################################
#
# python-jeepney
#
################################################################################

PYTHON_JEEPNEY_VERSION = 0.8.0
PYTHON_JEEPNEY_SOURCE = jeepney-$(PYTHON_JEEPNEY_VERSION).tar.gz
PYTHON_JEEPNEY_SITE = https://files.pythonhosted.org/packages/d6/f4/154cf374c2daf2020e05c3c6a03c91348d59b23c5366e968feb198306fdf
PYTHON_JEEPNEY_SETUP_TYPE = flit
PYTHON_JEEPNEY_LICENSE = MIT
PYTHON_JEEPNEY_LICENSE_FILES = LICENSE

$(eval $(python-package))
