################################################################################
#
# python-unittest-xml-reporting
#
################################################################################

PYTHON_UNITTEST_XML_REPORTING_VERSION = 3.2.0
PYTHON_UNITTEST_XML_REPORTING_SOURCE = unittest-xml-reporting-$(PYTHON_UNITTEST_XML_REPORTING_VERSION).tar.gz
PYTHON_UNITTEST_XML_REPORTING_SITE = https://files.pythonhosted.org/packages/ed/40/3bf1afc96e93c7322520981ac4593cbb29daa21b48d32746f05ab5563dca
PYTHON_UNITTEST_XML_REPORTING_SETUP_TYPE = setuptools
PYTHON_UNITTEST_XML_REPORTING_LICENSE = BSD-2-Clause
PYTHON_UNITTEST_XML_REPORTING_LICENSE_FILES = LICENSE

$(eval $(python-package))
