################################################################################
#
# python-pysensors
#
################################################################################

PYTHON_PYSENSORS_VERSION = 0.0.4
PYTHON_PYSENSORS_SOURCE = PySensors-$(PYTHON_PYSENSORS_VERSION).tar.gz
PYTHON_PYSENSORS_SITE = https://files.pythonhosted.org/packages/76/31/d3383a192f31ce1d79f27ec3d047cca23dd82a1bf0939e774386aba37cf5
PYTHON_PYSENSORS_SETUP_TYPE = setuptools
PYTHON_PYSENSORS_LICENSE = LGPL-2.1

$(eval $(python-package))
