################################################################################
#
# python-parso
#
################################################################################

PYTHON_PARSO_VERSION = 0.8.2
PYTHON_PARSO_SOURCE = parso-$(PYTHON_PARSO_VERSION).tar.gz
PYTHON_PARSO_SITE = https://files.pythonhosted.org/packages/5e/61/d119e2683138a934550e47fc8ec023eb7f11b194883e9085dca3af5d4951
PYTHON_PARSO_SETUP_TYPE = setuptools
PYTHON_PARSO_LICENSE = MIT, Python-2.0, BSD-3-Clause (flask theme)
PYTHON_PARSO_LICENSE_FILES = LICENSE.txt docs/_themes/flask/LICENSE test/normalizer_issue_files/LICENSE
PYTHON_PARSO_CPE_ID_VENDOR = parso_project
PYTHON_PARSO_CPE_ID_PRODUCT = parso

$(eval $(python-package))
