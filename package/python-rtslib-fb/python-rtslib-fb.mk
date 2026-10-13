################################################################################
#
# python-rtslib-fb
#
################################################################################

# When upgrading the version, be sure to also upgrade
# python-configshell-fb and targetcli-fb at the same time.
PYTHON_RTSLIB_FB_VERSION = 2.2.4
PYTHON_RTSLIB_FB_SOURCE = rtslib_fb-$(PYTHON_RTSLIB_FB_VERSION).tar.gz
PYTHON_RTSLIB_FB_SITE = https://files.pythonhosted.org/packages/79/32/030eaf69d4f19cac2345a6fab1f18118355f7c9c83d6d84f758b00bbd3d9
PYTHON_RTSLIB_FB_LICENSE = Apache-2.0
PYTHON_RTSLIB_FB_LICENSE_FILES = COPYING
PYTHON_RTSLIB_FB_SETUP_TYPE = hatch
PYTHON_RTSLIB_FB_DEPENDENCIES = host-python-hatch-vcs

# The PyPI archive omits the compatibility symlink included in Git.
define PYTHON_RTSLIB_FB_RESTORE_COMPAT_SYMLINK
	ln -s rtslib $(@D)/rtslib_fb
endef
PYTHON_RTSLIB_FB_POST_EXTRACT_HOOKS += PYTHON_RTSLIB_FB_RESTORE_COMPAT_SYMLINK

$(eval $(python-package))
