################################################################################
#
# python-weasyprint
#
################################################################################

PYTHON_WEASYPRINT_VERSION = 63.0
PYTHON_WEASYPRINT_SOURCE = weasyprint-$(PYTHON_WEASYPRINT_VERSION).tar.gz
PYTHON_WEASYPRINT_SITE = https://files.pythonhosted.org/packages/78/57/213cd566b7e14130d62babd91c5c5c2b94cbdbcdc0c7a0936a236bc88db0
PYTHON_WEASYPRINT_SETUP_TYPE = flit
PYTHON_WEASYPRINT_LICENSE = BSD-3-Clause
PYTHON_WEASYPRINT_LICENSE_FILES = LICENSE

$(eval $(python-package))
