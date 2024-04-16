################################################################################
#
# python-docker
#
################################################################################

PYTHON_DOCKER_VERSION = 6.1.3
PYTHON_DOCKER_SOURCE = docker-$(PYTHON_DOCKER_VERSION).tar.gz
PYTHON_DOCKER_SITE = https://files.pythonhosted.org/packages/f0/73/f7c9a14e88e769f38cb7fb45aa88dfd795faa8e18aea11bababf6e068d5e
PYTHON_DOCKER_SETUP_TYPE = setuptools
PYTHON_DOCKER_LICENSE = Apache-2.0
PYTHON_DOCKER_LICENSE_FILES = LICENSE
PYTHON_DOCKER_CPE_ID_VENDOR = docker
PYTHON_DOCKER_CPE_ID_PRODUCT = docker-py
PYTHON_DOCKER_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
