################################################################################
#
# python-mdurl
#
################################################################################

PYTHON_MDURL_VERSION = 0.1.2
PYTHON_MDURL_SOURCE = mdurl-$(PYTHON_MDURL_VERSION).tar.gz
PYTHON_MDURL_SITE = https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90
PYTHON_MDURL_SETUP_TYPE = flit
PYTHON_MDURL_LICENSE = MIT
PYTHON_MDURL_LICENSE_FILES = LICENSE

$(eval $(python-package))
