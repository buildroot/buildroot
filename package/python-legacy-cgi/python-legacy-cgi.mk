################################################################################
#
# python-legacy-cgi
#
################################################################################

PYTHON_LEGACY_CGI_VERSION = 2.6.2
PYTHON_LEGACY_CGI_SOURCE = legacy_cgi-$(PYTHON_LEGACY_CGI_VERSION).tar.gz
PYTHON_LEGACY_CGI_SITE = https://files.pythonhosted.org/packages/ad/2e/e1860989bc6cfdecba66db37f2f783636b97a1248ac25fbe864b6e931c22
PYTHON_LEGACY_CGI_SETUP_TYPE = poetry
PYTHON_LEGACY_CGI_LICENSE = PSF-2.0
PYTHON_LEGACY_CGI_LICENSE_FILES = LICENSE

$(eval $(python-package))
