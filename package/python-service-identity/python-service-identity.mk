################################################################################
#
# python-service-identity
#
################################################################################

PYTHON_SERVICE_IDENTITY_VERSION = 26.1.0
PYTHON_SERVICE_IDENTITY_SOURCE = service_identity-$(PYTHON_SERVICE_IDENTITY_VERSION).tar.gz
PYTHON_SERVICE_IDENTITY_SITE = https://files.pythonhosted.org/packages/61/87/ad52e2c582c0f0e7f0a1b86950494c38d67422dc0f5ed9044a5fb9569a49
PYTHON_SERVICE_IDENTITY_LICENSE = MIT
PYTHON_SERVICE_IDENTITY_LICENSE_FILES = LICENSE
PYTHON_SERVICE_IDENTITY_SETUP_TYPE = hatch
PYTHON_SERVICE_IDENTITY_DEPENDENCIES = \
	host-python-hatch-vcs \
	host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
