################################################################################
#
# python-xmljson
#
################################################################################

PYTHON_XMLJSON_VERSION = 0.2.1
PYTHON_XMLJSON_SOURCE = xmljson-$(PYTHON_XMLJSON_VERSION).tar.gz
PYTHON_XMLJSON_SITE = https://files.pythonhosted.org/packages/e8/6f/d9f109ba19be510fd3098bcb72143c67ca6743cedb48ac75aef05ddfe960
PYTHON_XMLJSON_SETUP_TYPE = setuptools
PYTHON_XMLJSON_LICENSE = MIT
PYTHON_XMLJSON_LICENSE_FILES = LICENSE

$(eval $(python-package))
