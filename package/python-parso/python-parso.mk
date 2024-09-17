################################################################################
#
# python-parso
#
################################################################################

PYTHON_PARSO_VERSION = 0.8.4
PYTHON_PARSO_SOURCE = parso-$(PYTHON_PARSO_VERSION).tar.gz
PYTHON_PARSO_SITE = https://files.pythonhosted.org/packages/66/94/68e2e17afaa9169cf6412ab0f28623903be73d1b32e208d9e8e541bb086d
PYTHON_PARSO_SETUP_TYPE = setuptools
PYTHON_PARSO_LICENSE = MIT, Python-2.0, BSD-3-Clause (flask theme)
PYTHON_PARSO_LICENSE_FILES = LICENSE.txt docs/_themes/flask/LICENSE test/normalizer_issue_files/LICENSE
PYTHON_PARSO_CPE_ID_VENDOR = parso_project
PYTHON_PARSO_CPE_ID_PRODUCT = parso

$(eval $(python-package))
