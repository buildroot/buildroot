################################################################################
#
# autossh
#
################################################################################

AUTOSSH_VERSION = 1.4g
AUTOSSH_SITE = http://www.harding.motd.ca/autossh
AUTOSSH_SOURCE = autossh-$(AUTOSSH_VERSION).tgz
AUTOSSH_LICENSE = Modified BSD
AUTOSSH_LICENSE_FILES = autossh.c
# Fix AC_ARG_WITH code generation for --with-ssh
# 0001-configure.ac-fix-__progname-check-with-gcc-14.patch
AUTOSSH_AUTORECONF = YES

AUTOSSH_CONF_OPTS = --with-ssh=/usr/bin/ssh

$(eval $(autotools-package))
