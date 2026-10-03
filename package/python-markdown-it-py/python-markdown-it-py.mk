################################################################################
#
# python-markdown-it-py
#
################################################################################

PYTHON_MARKDOWN_IT_PY_VERSION = 4.2.0
PYTHON_MARKDOWN_IT_PY_SOURCE = markdown_it_py-$(PYTHON_MARKDOWN_IT_PY_VERSION).tar.gz
PYTHON_MARKDOWN_IT_PY_SITE = https://files.pythonhosted.org/packages/06/ff/7841249c247aa650a76b9ee4bbaeae59370dc8bfd2f6c01f3630c35eb134
PYTHON_MARKDOWN_IT_PY_SETUP_TYPE = flit
PYTHON_MARKDOWN_IT_PY_LICENSE = MIT
PYTHON_MARKDOWN_IT_PY_LICENSE_FILES = LICENSE LICENSE.markdown-it

$(eval $(python-package))
