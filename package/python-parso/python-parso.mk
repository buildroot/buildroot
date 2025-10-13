################################################################################
#
# python-parso
#
################################################################################

PYTHON_PARSO_VERSION = 0.8.5
PYTHON_PARSO_SOURCE = parso-$(PYTHON_PARSO_VERSION).tar.gz
PYTHON_PARSO_SITE = https://files.pythonhosted.org/packages/d4/de/53e0bcf53d13e005bd8c92e7855142494f41171b34c2536b86187474184d
PYTHON_PARSO_SETUP_TYPE = setuptools
PYTHON_PARSO_LICENSE = MIT, Python-2.0, BSD-3-Clause (flask theme)
PYTHON_PARSO_LICENSE_FILES = LICENSE.txt docs/_themes/flask/LICENSE test/normalizer_issue_files/LICENSE
PYTHON_PARSO_CPE_ID_VENDOR = parso_project
PYTHON_PARSO_CPE_ID_PRODUCT = parso

$(eval $(python-package))
