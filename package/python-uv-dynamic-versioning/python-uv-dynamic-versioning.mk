################################################################################
#
# python-uv-dynamic-versioning
#
################################################################################

PYTHON_UV_DYNAMIC_VERSIONING_VERSION = 0.14.1
PYTHON_UV_DYNAMIC_VERSIONING_SOURCE = uv_dynamic_versioning-$(PYTHON_UV_DYNAMIC_VERSIONING_VERSION).tar.gz
PYTHON_UV_DYNAMIC_VERSIONING_SITE = https://files.pythonhosted.org/packages/6f/c8/fa500ee29af69cfeeea5ff6d6597919f1989b2e3f1a236c3006bdb21d320
PYTHON_UV_DYNAMIC_VERSIONING_SETUP_TYPE = hatch
PYTHON_UV_DYNAMIC_VERSIONING_LICENSE = MIT
PYTHON_UV_DYNAMIC_VERSIONING_LICENSE_FILES = LICENSE
HOST_PYTHON_UV_DYNAMIC_VERSIONING_DEPENDENCIES = \
	host-python-dunamai \
	host-python-jinja2 \
	host-python-tomlkit

$(eval $(host-python-package))
