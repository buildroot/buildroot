################################################################################
#
# python-git
#
################################################################################

PYTHON_GIT_VERSION = 3.2.0
PYTHON_GIT_SOURCE = gitpython-$(PYTHON_GIT_VERSION).tar.gz
PYTHON_GIT_SITE = https://files.pythonhosted.org/packages/6e/2d/6f6e649818da44d4499604802c89329b8d9799687a124e3a5e467a643336
PYTHON_GIT_LICENSE = BSD-3-Clause
PYTHON_GIT_LICENSE_FILES = LICENSE
PYTHON_GIT_SETUP_TYPE = setuptools

$(eval $(python-package))
