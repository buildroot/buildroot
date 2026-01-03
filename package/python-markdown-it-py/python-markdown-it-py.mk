################################################################################
#
# python-markdown-it-py
#
################################################################################

PYTHON_MARKDOWN_IT_PY_VERSION = 4.0.0
PYTHON_MARKDOWN_IT_PY_SOURCE = markdown_it_py-$(PYTHON_MARKDOWN_IT_PY_VERSION).tar.gz
PYTHON_MARKDOWN_IT_PY_SITE = https://files.pythonhosted.org/packages/5b/f5/4ec618ed16cc4f8fb3b701563655a69816155e79e24a17b651541804721d
PYTHON_MARKDOWN_IT_PY_SETUP_TYPE = flit
PYTHON_MARKDOWN_IT_PY_LICENSE = MIT
PYTHON_MARKDOWN_IT_PY_LICENSE_FILES = LICENSE LICENSE.markdown-it

$(eval $(python-package))
