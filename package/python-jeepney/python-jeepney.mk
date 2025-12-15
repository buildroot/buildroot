################################################################################
#
# python-jeepney
#
################################################################################

PYTHON_JEEPNEY_VERSION = 0.9.0
PYTHON_JEEPNEY_SOURCE = jeepney-$(PYTHON_JEEPNEY_VERSION).tar.gz
PYTHON_JEEPNEY_SITE = https://files.pythonhosted.org/packages/7b/6f/357efd7602486741aa73ffc0617fb310a29b588ed0fd69c2399acbb85b0c
PYTHON_JEEPNEY_SETUP_TYPE = flit
PYTHON_JEEPNEY_LICENSE = MIT
PYTHON_JEEPNEY_LICENSE_FILES = LICENSE

$(eval $(python-package))
