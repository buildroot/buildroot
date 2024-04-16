################################################################################
#
# python-pure-eval
#
################################################################################

PYTHON_PURE_EVAL_VERSION = 0.2.2
PYTHON_PURE_EVAL_SOURCE = pure_eval-$(PYTHON_PURE_EVAL_VERSION).tar.gz
PYTHON_PURE_EVAL_SITE = https://files.pythonhosted.org/packages/97/5a/0bc937c25d3ce4e0a74335222aee05455d6afa2888032185f8ab50cdf6fd
PYTHON_PURE_EVAL_SETUP_TYPE = setuptools
PYTHON_PURE_EVAL_LICENSE = MIT
PYTHON_PURE_EVAL_LICENSE_FILES = LICENSE.txt

PYTHON_PURE_EVAL_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
