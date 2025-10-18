################################################################################
#
# python-pyfatfs
#
################################################################################

PYTHON_PYFATFS_VERSION = 1.1.0
PYTHON_PYFATFS_SOURCE = pyfatfs-$(PYTHON_PYFATFS_VERSION).tar.gz
PYTHON_PYFATFS_SITE = https://files.pythonhosted.org/packages/44/3f/d08f1dbc44a7eef9c7fb355b83423fbd15bb3e487c250479a2c179cb39bf
PYTHON_PYFATFS_LICENSE = MIT
PYTHON_PYFATFS_LICENSE_FILES = LICENSE
PYTHON_PYFATFS_SETUP_TYPE = setuptools
# host-python-fs is not a build time dependency, but is needed at
# runtime for host-python-pyfatfs to work
HOST_PYTHON_PYFATFS_DEPENDENCIES = host-python-setuptools-scm host-python-fs

$(eval $(host-python-package))
