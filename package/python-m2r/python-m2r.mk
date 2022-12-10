################################################################################
#
# python-m2r
#
################################################################################

PYTHON_M2R_VERSION = 0.3.1
PYTHON_M2R_SOURCE = m2r-$(PYTHON_M2R_VERSION).tar.gz
PYTHON_M2R_SITE = https://files.pythonhosted.org/packages/94/65/fd40fbdc608298e760affb95869c3baed237dfe5649d62da1eaa1deca8f3
PYTHON_M2R_SETUP_TYPE = setuptools
PYTHON_M2R_LICENSE = MIT
PYTHON_M2R_LICENSE_FILES = LICENSE
HOST_PYTHON_M2R_DEPENDENCIES = host-python-docutils host-python-mistune

$(eval $(python-package))
$(eval $(host-python-package))
