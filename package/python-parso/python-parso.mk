################################################################################
#
# python-parso
#
################################################################################

PYTHON_PARSO_VERSION = 0.8.6
PYTHON_PARSO_SOURCE = parso-$(PYTHON_PARSO_VERSION).tar.gz
PYTHON_PARSO_SITE = https://files.pythonhosted.org/packages/81/76/a1e769043c0c0c9fe391b702539d594731a4362334cdf4dc25d0c09761e7
PYTHON_PARSO_SETUP_TYPE = setuptools
PYTHON_PARSO_LICENSE = MIT, Python-2.0, BSD-3-Clause (flask theme)
PYTHON_PARSO_LICENSE_FILES = LICENSE.txt docs/_themes/flask/LICENSE test/normalizer_issue_files/LICENSE
PYTHON_PARSO_CPE_ID_VENDOR = parso_project
PYTHON_PARSO_CPE_ID_PRODUCT = parso

$(eval $(python-package))
