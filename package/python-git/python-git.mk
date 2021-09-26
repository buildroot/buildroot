################################################################################
#
# python-git
#
################################################################################

PYTHON_GIT_VERSION = 3.1.20
PYTHON_GIT_SITE = $(call github,gitpython-developers,GitPython,$(PYTHON_GIT_VERSION))
PYTHON_GIT_LICENSE = BSD-3-Clause
PYTHON_GIT_LICENSE_FILES = LICENSE
PYTHON_GIT_SETUP_TYPE = setuptools

$(eval $(python-package))
