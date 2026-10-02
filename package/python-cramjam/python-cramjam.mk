################################################################################
#
# python-cramjam
#
################################################################################

PYTHON_CRAMJAM_VERSION = 2.11.0
PYTHON_CRAMJAM_SITE = $(call github,milesgranger,cramjam,v$(PYTHON_CRAMJAM_VERSION))
PYTHON_CRAMJAM_SETUP_TYPE = maturin
PYTHON_CRAMJAM_LICENSE = MIT
PYTHON_CRAMJAM_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
