################################################################################
#
# python-legacy-cgi
#
################################################################################

PYTHON_LEGACY_CGI_VERSION = 2.6.1
PYTHON_LEGACY_CGI_SOURCE = legacy_cgi-$(PYTHON_LEGACY_CGI_VERSION).tar.gz
PYTHON_LEGACY_CGI_SITE = https://files.pythonhosted.org/packages/48/96/ff14ad0f759f2297a2e61db9c5384d248a6b38c6c1d4452c07d7419676a2
PYTHON_LEGACY_CGI_SETUP_TYPE = poetry
PYTHON_LEGACY_CGI_LICENSE = PSF-2.0
PYTHON_LEGACY_CGI_LICENSE_FILES = LICENSE

$(eval $(python-package))
