################################################################################
#
# python-docker
#
################################################################################

PYTHON_DOCKER_VERSION = 6.0.1
PYTHON_DOCKER_SOURCE = docker-$(PYTHON_DOCKER_VERSION).tar.gz
PYTHON_DOCKER_SITE = https://files.pythonhosted.org/packages/79/26/6609b51ecb418e12d1534d00b888ce7e108f38b47dc6cd589598d5c6aaa2
PYTHON_DOCKER_SETUP_TYPE = setuptools
PYTHON_DOCKER_LICENSE = Apache-2.0
PYTHON_DOCKER_LICENSE_FILES = LICENSE
PYTHON_DOCKER_CPE_ID_VENDOR = docker
PYTHON_DOCKER_CPE_ID_PRODUCT = docker-py
PYTHON_DOCKER_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
