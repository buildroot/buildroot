################################################################################
#
# python-weasyprint
#
################################################################################

PYTHON_WEASYPRINT_VERSION = 57.1
PYTHON_WEASYPRINT_SOURCE = weasyprint-$(PYTHON_WEASYPRINT_VERSION).tar.gz
PYTHON_WEASYPRINT_SITE = https://files.pythonhosted.org/packages/32/3f/d305dc714c119e5b11c0ea1ecff9741407b6da90d6b684859d3b3e586692
PYTHON_WEASYPRINT_SETUP_TYPE = flit
PYTHON_WEASYPRINT_LICENSE = BSD-3-Clause
PYTHON_WEASYPRINT_LICENSE_FILES = LICENSE

$(eval $(python-package))
