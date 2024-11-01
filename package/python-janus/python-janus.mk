################################################################################
#
# python-janus
#
################################################################################

PYTHON_JANUS_VERSION = 1.1.0
PYTHON_JANUS_SOURCE = janus-$(PYTHON_JANUS_VERSION).tar.gz
PYTHON_JANUS_SITE = https://files.pythonhosted.org/packages/45/50/112a19f28a11b545c4c95de29c50a06fa9381a2432eaabbf9316bbd4e046
PYTHON_JANUS_SETUP_TYPE = setuptools
PYTHON_JANUS_LICENSE = Apache-2.0
PYTHON_JANUS_LICENSE_FILES = LICENSE

$(eval $(python-package))
