################################################################################
#
# python-outcome
#
################################################################################

PYTHON_OUTCOME_VERSION = 1.2.0
PYTHON_OUTCOME_SOURCE = outcome-$(PYTHON_OUTCOME_VERSION).tar.gz
PYTHON_OUTCOME_SITE = https://files.pythonhosted.org/packages/dd/91/741e1626e89fdc3664169e16300c59eefa4b23540cc6d6c70450f885098f
PYTHON_OUTCOME_SETUP_TYPE = setuptools
PYTHON_OUTCOME_LICENSE = Apache-2.0 or MIT
PYTHON_OUTCOME_LICENSE_FILES = LICENSE LICENSE.APACHE2 LICENSE.MIT

$(eval $(python-package))
