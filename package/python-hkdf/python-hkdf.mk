################################################################################
#
# python-hkdf
#
################################################################################

PYTHON_HKDF_VERSION = 0.0.3
PYTHON_HKDF_SOURCE = hkdf-$(PYTHON_HKDF_VERSION).tar.gz
PYTHON_HKDF_SITE = https://files.pythonhosted.org/packages/c3/be/327e072850db181ce56afd51e26ec7aa5659b18466c709fa5ea2548c935f
PYTHON_HKDF_SETUP_TYPE = setuptools
# No license file in the tree, but
# https://github.com/casebeer/python-hkdf/blob/master/LICENSE shows
# it's BSD-2-Clause. Issue already reported upstream:
# https://github.com/casebeer/python-hkdf/issues/6
PYTHON_HKDF_LICENSE = BSD-2-Clause

$(eval $(python-package))
