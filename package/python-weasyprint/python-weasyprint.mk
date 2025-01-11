################################################################################
#
# python-weasyprint
#
################################################################################

PYTHON_WEASYPRINT_VERSION = 63.1
PYTHON_WEASYPRINT_SOURCE = weasyprint-$(PYTHON_WEASYPRINT_VERSION).tar.gz
PYTHON_WEASYPRINT_SITE = https://files.pythonhosted.org/packages/2b/f0/1ac7d241b8cabaaf047278ef67b64869473a4e0a2218a1cbc0a6ffb0d8fd
PYTHON_WEASYPRINT_SETUP_TYPE = flit
PYTHON_WEASYPRINT_LICENSE = BSD-3-Clause
PYTHON_WEASYPRINT_LICENSE_FILES = LICENSE

$(eval $(python-package))
