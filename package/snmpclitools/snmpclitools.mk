################################################################################
#
# snmpclitools
#
################################################################################

SNMPCLITOOLS_VERSION = 0.7.2
SNMPCLITOOLS_SITE = https://files.pythonhosted.org/packages/b7/64/947b1cad405ba175c03385a4936b930b1fda7ce65e9da5bef5d64a5439fb
SNMPCLITOOLS_SETUP_TYPE = poetry
SNMPCLITOOLS_LICENSE = BSD-2-Clause
SNMPCLITOOLS_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))
