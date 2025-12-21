################################################################################
#
# python-pysendfile
#
################################################################################

PYTHON_PYSENDFILE_VERSION = 2.0.1
PYTHON_PYSENDFILE_SOURCE = pysendfile-$(PYTHON_PYSENDFILE_VERSION).tar.gz
PYTHON_PYSENDFILE_SITE = https://files.pythonhosted.org/packages/cd/3f/4aa268afd0252f06b3b487c296a066a01ddd4222a46b7a3748599c8fc8c3
PYTHON_PYSENDFILE_SETUP_TYPE = setuptools
PYTHON_PYSENDFILE_LICENSE = MIT
PYTHON_PYSENDFILE_LICENSE_FILES = LICENSE

$(eval $(python-package))
