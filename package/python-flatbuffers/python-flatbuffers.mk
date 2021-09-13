################################################################################
#
# python-flatbuffers
#
################################################################################

PYTHON_FLATBUFFERS_VERSION = 2.0
PYTHON_FLATBUFFERS_SOURCE = flatbuffers-$(PYTHON_FLATBUFFERS_VERSION).tar.gz
PYTHON_FLATBUFFERS_SITE = https://files.pythonhosted.org/packages/10/41/09e9ab2134895b82466fada08b69b800f9a724bc81fcca3d4474ce48ffce
PYTHON_FLATBUFFERS_LICENSE = Apache-2.0
PYTHON_FLATBUFFERS_SETUP_TYPE = setuptools

$(eval $(python-package))
