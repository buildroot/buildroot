################################################################################
#
# python-servestatic
#
################################################################################

PYTHON_SERVESTATIC_VERSION = 4.3.2
PYTHON_SERVESTATIC_SITE = $(call github,Archmonger,ServeStatic,$(PYTHON_SERVESTATIC_VERSION))
PYTHON_SERVESTATIC_SETUP_TYPE = hatch
PYTHON_SERVESTATIC_LICENSE = MIT
PYTHON_SERVESTATIC_LICENSE_FILES = LICENSE.md

$(eval $(python-package))
