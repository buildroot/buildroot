################################################################################
#
# python-prompt-toolkit
#
################################################################################

PYTHON_PROMPT_TOOLKIT_VERSION = 3.0.47
PYTHON_PROMPT_TOOLKIT_SOURCE = prompt_toolkit-$(PYTHON_PROMPT_TOOLKIT_VERSION).tar.gz
PYTHON_PROMPT_TOOLKIT_SITE = https://files.pythonhosted.org/packages/47/6d/0279b119dafc74c1220420028d490c4399b790fc1256998666e3a341879f
PYTHON_PROMPT_TOOLKIT_SETUP_TYPE = setuptools
PYTHON_PROMPT_TOOLKIT_LICENSE = BSD-3-Clause
PYTHON_PROMPT_TOOLKIT_LICENSE_FILES = LICENSE

$(eval $(python-package))
