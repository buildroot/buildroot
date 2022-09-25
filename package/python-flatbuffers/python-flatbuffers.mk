################################################################################
#
# python-flatbuffers
#
################################################################################

PYTHON_FLATBUFFERS_VERSION = 2.0.7
PYTHON_FLATBUFFERS_SOURCE = flatbuffers-$(PYTHON_FLATBUFFERS_VERSION).tar.gz
PYTHON_FLATBUFFERS_SITE = https://files.pythonhosted.org/packages/d1/90/0532e737a11e1dc50e9e352c3ccc97338cb75991f83279c2edbc9234e022
PYTHON_FLATBUFFERS_LICENSE = Apache-2.0
PYTHON_FLATBUFFERS_SETUP_TYPE = setuptools

$(eval $(python-package))
