################################################################################
#
# python-parso
#
################################################################################

PYTHON_PARSO_VERSION = 0.8.7
PYTHON_PARSO_SOURCE = parso-$(PYTHON_PARSO_VERSION).tar.gz
PYTHON_PARSO_SITE = https://files.pythonhosted.org/packages/30/4b/90c937815137d43ce71ba043cd3566221e9df6b9c805f24b5d138c9d40a7
PYTHON_PARSO_SETUP_TYPE = setuptools
PYTHON_PARSO_LICENSE = MIT, Python-2.0, BSD-3-Clause (flask theme)
PYTHON_PARSO_LICENSE_FILES = LICENSE.txt docs/_themes/flask/LICENSE test/normalizer_issue_files/LICENSE
PYTHON_PARSO_CPE_ID_VENDOR = parso_project
PYTHON_PARSO_CPE_ID_PRODUCT = parso

$(eval $(python-package))
