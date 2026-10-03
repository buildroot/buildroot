################################################################################
#
# python-pure-eval
#
################################################################################

PYTHON_PURE_EVAL_VERSION = 0.2.4
PYTHON_PURE_EVAL_SOURCE = pure_eval-$(PYTHON_PURE_EVAL_VERSION).tar.gz
PYTHON_PURE_EVAL_SITE = https://files.pythonhosted.org/packages/da/9f/abfd2959e9261dd5217ca8551d4de211ca6ab26fe9b72cf44731ff6c4442
PYTHON_PURE_EVAL_SETUP_TYPE = setuptools
PYTHON_PURE_EVAL_LICENSE = MIT
PYTHON_PURE_EVAL_LICENSE_FILES = LICENSE.txt

PYTHON_PURE_EVAL_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
