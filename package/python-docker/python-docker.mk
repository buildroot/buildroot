################################################################################
#
# python-docker
#
################################################################################

PYTHON_DOCKER_VERSION = 7.2.0
PYTHON_DOCKER_SOURCE = docker-$(PYTHON_DOCKER_VERSION).tar.gz
PYTHON_DOCKER_SITE = https://files.pythonhosted.org/packages/88/7f/731ff914b0255d3d065f45fd4e626d4b8c95dbcbaada049f337a6ac16410
PYTHON_DOCKER_SETUP_TYPE = hatch
PYTHON_DOCKER_LICENSE = Apache-2.0
PYTHON_DOCKER_LICENSE_FILES = LICENSE
PYTHON_DOCKER_CPE_ID_VENDOR = docker
PYTHON_DOCKER_CPE_ID_PRODUCT = docker-py
PYTHON_DOCKER_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
