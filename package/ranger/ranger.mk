################################################################################
#
# ranger
#
################################################################################

RANGER_VERSION = 1.9.3
RANGER_SITE = https://ranger.github.io
RANGER_SETUP_TYPE = setuptools
RANGER_LICENSE = GPL-3.0
RANGER_LICENSE_FILES = AUTHORS LICENSE

# The ranger script request python to be called with -O (optimize generated
# bytecode slightly; also PYTHONOPTIMIZE=x). This implicitly requires the python
# source files to be present. Therefore, the -O flag is removed when only the .pyc
# files are installed.

define RANGER_DO_NOT_GENERATE_BYTECODE_AT_RUNTIME
	$(SED) 's%/usr/bin/python -O%/usr/bin/python%g' $(@D)/ranger.py
endef

ifeq ($(BR2_PACKAGE_PYTHON3_PYC_ONLY),y)
RANGER_POST_PATCH_HOOKS += RANGER_DO_NOT_GENERATE_BYTECODE_AT_RUNTIME
endif

$(eval $(python-package))
