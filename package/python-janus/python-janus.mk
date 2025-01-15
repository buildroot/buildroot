################################################################################
#
# python-janus
#
################################################################################

PYTHON_JANUS_VERSION = 2.0.0
PYTHON_JANUS_SOURCE = janus-$(PYTHON_JANUS_VERSION).tar.gz
PYTHON_JANUS_SITE = https://files.pythonhosted.org/packages/d8/7f/69884b6618be4baf6ebcacc716ee8680a842428a19f403db6d1c0bb990aa
PYTHON_JANUS_SETUP_TYPE = setuptools
PYTHON_JANUS_LICENSE = Apache-2.0
PYTHON_JANUS_LICENSE_FILES = LICENSE

$(eval $(python-package))
