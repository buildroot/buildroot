# help: http://www.dre.vanderbilt.edu/~schmidt/DOC_ROOT/ACE/ACE-INSTALL.html#unix

# create a platform macros file
include $(ACE_ROOT)/include/makeinclude/platform_linux.GNU

# disable RPATH
install_rpath = 0

# set the installation prefix
INSTALL_PREFIX = /usr

# fix link error with ARM EABI tools
# http://list.isis.vanderbilt.edu/pipermail/ace-users/2008-January/002742.html
no_hidden_visibility = 1
