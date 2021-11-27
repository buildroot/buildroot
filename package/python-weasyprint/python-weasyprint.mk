################################################################################
#
# python-weasyprint
#
################################################################################

PYTHON_WEASYPRINT_VERSION = 53.4
PYTHON_WEASYPRINT_SOURCE = weasyprint-$(PYTHON_WEASYPRINT_VERSION).tar.gz
PYTHON_WEASYPRINT_SITE = https://files.pythonhosted.org/packages/72/25/336e274fde0e48cf9979d44667411fbcfa55d323fd7672068807b6de2f89
PYTHON_WEASYPRINT_SETUP_TYPE = distutils
PYTHON_WEASYPRINT_LICENSE = BSD-3-Clause
PYTHON_WEASYPRINT_LICENSE_FILES = LICENSE

$(eval $(python-package))
