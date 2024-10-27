################################################################################
#
# python-service-identity
#
################################################################################

PYTHON_SERVICE_IDENTITY_VERSION = 24.2.0
PYTHON_SERVICE_IDENTITY_SOURCE = service_identity-$(PYTHON_SERVICE_IDENTITY_VERSION).tar.gz
PYTHON_SERVICE_IDENTITY_SITE = https://files.pythonhosted.org/packages/07/a5/dfc752b979067947261dbbf2543470c58efe735c3c1301dd870ef27830ee
PYTHON_SERVICE_IDENTITY_LICENSE = MIT
PYTHON_SERVICE_IDENTITY_LICENSE_FILES = LICENSE
PYTHON_SERVICE_IDENTITY_SETUP_TYPE = hatch
PYTHON_SERVICE_IDENTITY_DEPENDENCIES = \
	host-python-hatch-vcs \
	host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
