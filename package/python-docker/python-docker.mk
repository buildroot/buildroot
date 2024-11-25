################################################################################
#
# python-docker
#
################################################################################

PYTHON_DOCKER_VERSION = 7.1.0
PYTHON_DOCKER_SOURCE = docker-$(PYTHON_DOCKER_VERSION).tar.gz
PYTHON_DOCKER_SITE = https://files.pythonhosted.org/packages/91/9b/4a2ea29aeba62471211598dac5d96825bb49348fa07e906ea930394a83ce
PYTHON_DOCKER_SETUP_TYPE = hatch
PYTHON_DOCKER_LICENSE = Apache-2.0
PYTHON_DOCKER_LICENSE_FILES = LICENSE
PYTHON_DOCKER_CPE_ID_VENDOR = docker
PYTHON_DOCKER_CPE_ID_PRODUCT = docker-py
PYTHON_DOCKER_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
