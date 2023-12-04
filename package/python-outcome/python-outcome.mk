################################################################################
#
# python-outcome
#
################################################################################

PYTHON_OUTCOME_VERSION = 1.3.0.post0
PYTHON_OUTCOME_SOURCE = outcome-$(PYTHON_OUTCOME_VERSION).tar.gz
PYTHON_OUTCOME_SITE = https://files.pythonhosted.org/packages/98/df/77698abfac98571e65ffeb0c1fba8ffd692ab8458d617a0eed7d9a8d38f2
PYTHON_OUTCOME_SETUP_TYPE = setuptools
PYTHON_OUTCOME_LICENSE = Apache-2.0 or MIT
PYTHON_OUTCOME_LICENSE_FILES = LICENSE LICENSE.APACHE2 LICENSE.MIT

$(eval $(python-package))
