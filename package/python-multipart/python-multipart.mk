################################################################################
#
# python-multipart
#
################################################################################

PYTHON_MULTIPART_VERSION = 0.0.17
PYTHON_MULTIPART_SOURCE = python_multipart-$(PYTHON_MULTIPART_VERSION).tar.gz
PYTHON_MULTIPART_SITE = https://files.pythonhosted.org/packages/40/22/edea41c2d4a22e666c0c7db7acdcbf7bc8c1c1f7d3b3ca246ec982fec612
PYTHON_MULTIPART_SETUP_TYPE = hatch
PYTHON_MULTIPART_LICENSE = Apache-2.0
PYTHON_MULTIPART_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
