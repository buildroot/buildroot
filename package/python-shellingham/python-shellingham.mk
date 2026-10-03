################################################################################
#
# python-shellingham
#
################################################################################

PYTHON_SHELLINGHAM_VERSION = 1.5.4
PYTHON_SHELLINGHAM_SOURCE = shellingham-$(PYTHON_SHELLINGHAM_VERSION).tar.gz
PYTHON_SHELLINGHAM_SITE = https://files.pythonhosted.org/packages/58/15/8b3609fd3830ef7b27b655beb4b4e9c62313a4e8da8c676e142cc210d58e
PYTHON_SHELLINGHAM_SETUP_TYPE = setuptools
PYTHON_SHELLINGHAM_LICENSE = ISC
PYTHON_SHELLINGHAM_LICENSE_FILES = LICENSE

$(eval $(python-package))
