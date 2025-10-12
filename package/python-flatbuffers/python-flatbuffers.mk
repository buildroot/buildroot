################################################################################
#
# python-flatbuffers
#
################################################################################

PYTHON_FLATBUFFERS_VERSION = 25.9.23
PYTHON_FLATBUFFERS_SOURCE = flatbuffers-$(PYTHON_FLATBUFFERS_VERSION).tar.gz
PYTHON_FLATBUFFERS_SITE = https://files.pythonhosted.org/packages/9d/1f/3ee70b0a55137442038f2a33469cc5fddd7e0ad2abf83d7497c18a2b6923
PYTHON_FLATBUFFERS_LICENSE = Apache-2.0
PYTHON_FLATBUFFERS_SETUP_TYPE = setuptools

$(eval $(python-package))
