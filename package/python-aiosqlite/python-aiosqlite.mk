################################################################################
#
# python-aiosqlite
#
################################################################################

PYTHON_AIOSQLITE_VERSION = 0.20.0
PYTHON_AIOSQLITE_SOURCE = aiosqlite-$(PYTHON_AIOSQLITE_VERSION).tar.gz
PYTHON_AIOSQLITE_SITE = https://files.pythonhosted.org/packages/0d/3a/22ff5415bf4d296c1e92b07fd746ad42c96781f13295a074d58e77747848
PYTHON_AIOSQLITE_SETUP_TYPE = flit
PYTHON_AIOSQLITE_LICENSE = MIT
PYTHON_AIOSQLITE_LICENSE_FILES = LICENSE

$(eval $(python-package))
