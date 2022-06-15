################################################################################
#
# python-jsonschema
#
################################################################################

PYTHON_JSONSCHEMA_VERSION = 4.5.1
PYTHON_JSONSCHEMA_SOURCE = jsonschema-$(PYTHON_JSONSCHEMA_VERSION).tar.gz
PYTHON_JSONSCHEMA_SITE = https://files.pythonhosted.org/packages/9e/62/93a54db0e44c4de57868a7d638d7a8abce113c8bc43a20b10b1109b2a517
PYTHON_JSONSCHEMA_SETUP_TYPE = setuptools
PYTHON_JSONSCHEMA_LICENSE = MIT
PYTHON_JSONSCHEMA_LICENSE_FILES = COPYING json/LICENSE

$(eval $(python-package))
