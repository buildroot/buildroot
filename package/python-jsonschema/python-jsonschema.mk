################################################################################
#
# python-jsonschema
#
################################################################################

PYTHON_JSONSCHEMA_VERSION = 4.16.0
PYTHON_JSONSCHEMA_SOURCE = jsonschema-$(PYTHON_JSONSCHEMA_VERSION).tar.gz
PYTHON_JSONSCHEMA_SITE = https://files.pythonhosted.org/packages/cf/54/8923ba38b5145f2359d57e5516715392491d674c83f446cd4cd133eeb4d6
PYTHON_JSONSCHEMA_SETUP_TYPE = pep517
PYTHON_JSONSCHEMA_LICENSE = MIT
PYTHON_JSONSCHEMA_LICENSE_FILES = COPYING json/LICENSE
PYTHON_JSONSCHEMA_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-fancy-pypi-readme \
	host-python-hatch-vcs

$(eval $(python-package))
