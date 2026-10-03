################################################################################
#
# circus
#
################################################################################

CIRCUS_VERSION = 0.19.0
CIRCUS_SITE = https://files.pythonhosted.org/packages/94/97/824bfce6949716ea93adcd5ff8aa4c277f40a735d7f644669674ec132ae4
CIRCUS_SETUP_TYPE = flit
CIRCUS_LICENSE = Apache-2.0
CIRCUS_LICENSE_FILES = LICENSE

$(eval $(python-package))
