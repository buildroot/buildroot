################################################################################
#
# python-engineio
#
################################################################################

PYTHON_ENGINEIO_VERSION = 4.2.1
PYTHON_ENGINEIO_SITE = https://files.pythonhosted.org/packages/74/1e/33e402011bb2fe33ab12762e5a66d66df1d47302a23e9c5e8310e11b1403
PYTHON_ENGINEIO_SETUP_TYPE = setuptools
PYTHON_ENGINEIO_LICENSE = MIT
PYTHON_ENGINEIO_LICENSE_FILES = LICENSE
PYTHON_ENGINEIO_CPE_ID_VENDOR = python-engineio_project

$(eval $(python-package))
