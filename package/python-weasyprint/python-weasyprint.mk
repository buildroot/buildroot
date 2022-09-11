################################################################################
#
# python-weasyprint
#
################################################################################

PYTHON_WEASYPRINT_VERSION = 56.1
PYTHON_WEASYPRINT_SOURCE = weasyprint-$(PYTHON_WEASYPRINT_VERSION).tar.gz
PYTHON_WEASYPRINT_SITE = https://files.pythonhosted.org/packages/30/2c/9c29989bf03bb573bd963c2cf167839099bdaff05aff1f0eff2ccbd1b509
PYTHON_WEASYPRINT_SETUP_TYPE = flit
PYTHON_WEASYPRINT_LICENSE = BSD-3-Clause
PYTHON_WEASYPRINT_LICENSE_FILES = LICENSE

$(eval $(python-package))
