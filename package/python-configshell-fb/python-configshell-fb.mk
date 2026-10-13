################################################################################
#
# python-configshell-fb
#
################################################################################

# When upgrading the version, be sure to also upgrade python-rtslib-fb
# and targetcli-fb at the same time.
PYTHON_CONFIGSHELL_FB_VERSION = 2.0.3
PYTHON_CONFIGSHELL_FB_SOURCE = configshell_fb-$(PYTHON_CONFIGSHELL_FB_VERSION).tar.gz
PYTHON_CONFIGSHELL_FB_SITE = https://files.pythonhosted.org/packages/5c/cd/3575aae7d0302c3a9d7a9999870475c289209a2f5b633a682c94f9dfc08c
PYTHON_CONFIGSHELL_FB_LICENSE = Apache-2.0
PYTHON_CONFIGSHELL_FB_LICENSE_FILES = COPYING
PYTHON_CONFIGSHELL_FB_SETUP_TYPE = hatch
PYTHON_CONFIGSHELL_FB_DEPENDENCIES = host-python-hatch-vcs

# The PyPI archive omits the compatibility symlink included in Git.
define PYTHON_CONFIGSHELL_FB_RESTORE_COMPAT_SYMLINK
	ln -s configshell $(@D)/configshell_fb
endef
PYTHON_CONFIGSHELL_FB_POST_EXTRACT_HOOKS += PYTHON_CONFIGSHELL_FB_RESTORE_COMPAT_SYMLINK

$(eval $(python-package))
