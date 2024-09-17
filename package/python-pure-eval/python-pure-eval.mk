################################################################################
#
# python-pure-eval
#
################################################################################

PYTHON_PURE_EVAL_VERSION = 0.2.3
PYTHON_PURE_EVAL_SOURCE = pure_eval-$(PYTHON_PURE_EVAL_VERSION).tar.gz
PYTHON_PURE_EVAL_SITE = https://files.pythonhosted.org/packages/cd/05/0a34433a064256a578f1783a10da6df098ceaa4a57bbeaa96a6c0352786b
PYTHON_PURE_EVAL_SETUP_TYPE = setuptools
PYTHON_PURE_EVAL_LICENSE = MIT
PYTHON_PURE_EVAL_LICENSE_FILES = LICENSE.txt

PYTHON_PURE_EVAL_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
