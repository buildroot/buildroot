################################################################################
#
# python-legacy-cgi
#
################################################################################

PYTHON_LEGACY_CGI_VERSION = 2.6.4
PYTHON_LEGACY_CGI_SOURCE = legacy_cgi-$(PYTHON_LEGACY_CGI_VERSION).tar.gz
PYTHON_LEGACY_CGI_SITE = https://files.pythonhosted.org/packages/f4/9c/91c7d2c5ebbdf0a1a510bfa0ddeaa2fbb5b78677df5ac0a0aa51cf7125b0
PYTHON_LEGACY_CGI_SETUP_TYPE = hatch
PYTHON_LEGACY_CGI_LICENSE = PSF-2.0
PYTHON_LEGACY_CGI_LICENSE_FILES = LICENSE

$(eval $(python-package))
