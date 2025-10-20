################################################################################
#
# python3
#
################################################################################

PYTHON3_VERSION_MAJOR = 3.12
PYTHON3_VERSION = $(PYTHON3_VERSION_MAJOR).12
PYTHON3_SOURCE = Python-$(PYTHON3_VERSION).tar.xz
PYTHON3_SITE = https://python.org/ftp/python/$(PYTHON3_VERSION)
PYTHON3_LICENSE = Python-2.0, others
PYTHON3_LICENSE_FILES = LICENSE
PYTHON3_CPE_ID_VENDOR = python
PYTHON3_CPE_ID_PRODUCT = python

# 0013-tarfile-now-validates-archives-to-ensure-member-offsets-are-non-negative.patch
PYTHON3_IGNORE_CVES += CVE-2025-8194

# This host Python is installed in $(HOST_DIR), as it is needed when
# cross-compiling third-party Python modules.

HOST_PYTHON3_CONF_OPTS += \
	--without-ensurepip \
	--without-cxx-main \
	--disable-sqlite3 \
	--disable-tk \
	--with-expat=system \
	--disable-test-modules \
	--disable-idle3

# Make sure that LD_LIBRARY_PATH overrides -rpath.
# This is needed because libpython may be installed at the same time that
# python is called.
# TODO: nis and ossaudiodev modules will be dropped in 3.13: https://peps.python.org/pep-0594/
HOST_PYTHON3_CONF_ENV += \
	LDFLAGS="$(HOST_LDFLAGS) -Wl,--enable-new-dtags" \
	py_cv_module_unicodedata=yes \
	py_cv_module__codecs_cn=n/a \
	py_cv_module__codecs_hk=n/a \
	py_cv_module__codecs_iso2022=n/a \
	py_cv_module__codecs_jp=n/a \
	py_cv_module__codecs_kr=n/a \
	py_cv_module__codecs_tw=n/a \
	py_cv_module__uuid=n/a \
	py_cv_module_nis=n/a \
	py_cv_module_ossaudiodev=n/a

PYTHON3_DEPENDENCIES = host-python3 libffi

HOST_PYTHON3_DEPENDENCIES = \
	host-autoconf-archive \
	host-expat \
	host-libffi \
	host-pkgconf \
	host-zlib

ifeq ($(BR2_PACKAGE_HOST_PYTHON3_BZIP2),y)
HOST_PYTHON3_DEPENDENCIES += host-bzip2
else
HOST_PYTHON3_CONF_ENV += py_cv_module__bz2=n/a
endif

ifeq ($(BR2_PACKAGE_HOST_PYTHON3_XZ),y)
HOST_PYTHON3_DEPENDENCIES += host-xz
else
HOST_PYTHON3_CONF_ENV += py_cv_module__lzma=n/a
endif

ifeq ($(BR2_PACKAGE_HOST_PYTHON3_CURSES),y)
HOST_PYTHON3_DEPENDENCIES += host-ncurses
else
HOST_PYTHON3_CONF_OPTS += --disable-curses
endif

ifeq ($(BR2_PACKAGE_HOST_PYTHON3_SSL),y)
HOST_PYTHON3_DEPENDENCIES += host-openssl
else
HOST_PYTHON3_CONF_ENV += \
	py_cv_module__hashlib=n/a \
	py_cv_module__ssl=n/a
endif

PYTHON3_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_PYTHON3_2TO3),y)
PYTHON3_CONF_OPTS += --enable-lib2to3
else
PYTHON3_CONF_OPTS += --disable-lib2to3
endif

ifeq ($(BR2_PACKAGE_PYTHON3_BERKELEYDB),y)
PYTHON3_DEPENDENCIES += berkeleydb
else
PYTHON3_CONF_ENV += py_cv_module__dbm=n/a
endif

ifeq ($(BR2_PACKAGE_PYTHON3_READLINE),y)
PYTHON3_CONF_OPTS += --with-readline
PYTHON3_DEPENDENCIES += readline
else
PYTHON3_CONF_OPTS += --without-readline
endif

ifeq ($(BR2_PACKAGE_PYTHON3_CURSES),y)
PYTHON3_DEPENDENCIES += ncurses
else
PYTHON3_CONF_OPTS += --disable-curses
endif

ifeq ($(BR2_PACKAGE_PYTHON3_DECIMAL),y)
PYTHON3_DEPENDENCIES += mpdecimal
PYTHON3_CONF_OPTS += --with-system-libmpdec
else
PYTHON3_CONF_ENV += py_cv_module__decimal=n/a
endif

ifeq ($(BR2_PACKAGE_PYTHON3_PYEXPAT),y)
PYTHON3_DEPENDENCIES += expat
PYTHON3_CONF_OPTS += --with-expat=system
else
PYTHON3_CONF_OPTS += --with-expat=none
endif

ifeq ($(BR2_PACKAGE_PYTHON3_SQLITE),y)
PYTHON3_DEPENDENCIES += sqlite
else
PYTHON3_CONF_OPTS += --disable-sqlite3
endif

ifeq ($(BR2_PACKAGE_PYTHON3_SSL),y)
PYTHON3_DEPENDENCIES += openssl
PYTHON3_CONF_OPTS += --with-openssl=$(STAGING_DIR)/usr
else
PYTHON3_CONF_ENV += \
	py_cv_module__hashlib=n/a \
	py_cv_module__ssl=n/a
endif

ifneq ($(BR2_PACKAGE_PYTHON3_CODECSCJK),y)
PYTHON3_CONF_ENV += \
	py_cv_module__codecs_cn=n/a \
	py_cv_module__codecs_hk=n/a \
	py_cv_module__codecs_iso2022=n/a \
	py_cv_module__codecs_jp=n/a \
	py_cv_module__codecs_kr=n/a \
	py_cv_module__codecs_tw=n/a
endif

ifneq ($(BR2_PACKAGE_PYTHON3_UNICODEDATA),y)
PYTHON3_CONF_ENV += py_cv_module_unicodedata=n/a
endif

# Disable auto-detection of uuid.h (util-linux)
# which would add _uuid module support, instead
# default to the pure python implementation
PYTHON3_CONF_ENV += py_cv_module__uuid=n/a

ifeq ($(BR2_PACKAGE_PYTHON3_BZIP2),y)
PYTHON3_DEPENDENCIES += bzip2
else
PYTHON3_CONF_ENV += py_cv_module__bz2=n/a
endif

ifeq ($(BR2_PACKAGE_PYTHON3_XZ),y)
PYTHON3_DEPENDENCIES += xz
else
PYTHON3_CONF_ENV += py_cv_module__lzma=n/a
endif

ifeq ($(BR2_PACKAGE_PYTHON3_ZLIB),y)
PYTHON3_DEPENDENCIES += zlib
else
PYTHON3_CONF_ENV += py_cv_module_zlib=n/a
endif

ifneq ($(BR2_PACKAGE_PYTHON3_OSSAUDIODEV),y)
PYTHON3_CONF_ENV += py_cv_module_ossaudiodev=n/a
endif

PYTHON3_CONF_ENV += \
	ac_cv_have_long_long_format=yes \
	ac_cv_file__dev_ptmx=yes \
	ac_cv_file__dev_ptc=yes \
	ac_cv_working_tzset=yes \
	py_cv_module_nis=n/a

# GCC is always compliant with IEEE754
ifeq ($(BR2_ENDIAN),"LITTLE")
PYTHON3_CONF_ENV += ac_cv_little_endian_double=yes
else
PYTHON3_CONF_ENV += ac_cv_big_endian_double=yes
endif

ifeq ($(BR2_PACKAGE_GETTEXT_PROVIDES_LIBINTL),y)
PYTHON3_DEPENDENCIES += gettext
endif

PYTHON3_CONF_OPTS += \
	--without-ensurepip \
	--without-cxx-main \
	--with-build-python=$(HOST_DIR)/bin/python3 \
	--with-system-ffi \
	--disable-pydoc \
	--disable-test-modules \
	--disable-tk \
	--disable-idle3 \
	--disable-pyc-build

#
# Remove useless files. In the config/ directory, only the Makefile
# and the pyconfig.h files are needed at runtime.
#
define PYTHON3_REMOVE_USELESS_FILES
	rm -f $(TARGET_DIR)/usr/bin/python$(PYTHON3_VERSION_MAJOR)-config
	rm -f $(TARGET_DIR)/usr/bin/python3-config
	find $(TARGET_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)/config-$(PYTHON3_VERSION_MAJOR)*/ \
		-depth -type f -not -name Makefile -exec rm -rf {} \;
	find $(TARGET_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)/ -depth -type d \
		-name __pycache__ -exec rm -rf {} \;
endef

PYTHON3_POST_INSTALL_TARGET_HOOKS += PYTHON3_REMOVE_USELESS_FILES

#
# Make sure libpython gets stripped out on target
#
define PYTHON3_ENSURE_LIBPYTHON_STRIPPED
	chmod u+w $(TARGET_DIR)/usr/lib/libpython$(PYTHON3_VERSION_MAJOR)*.so
endef

PYTHON3_POST_INSTALL_TARGET_HOOKS += PYTHON3_ENSURE_LIBPYTHON_STRIPPED

PYTHON3_AUTORECONF = YES
PYTHON3_AUTORECONF_OPTS = --include=$(HOST_DIR)/share/autoconf-archive

define PYTHON3_INSTALL_SYMLINK
	ln -fs python3 $(TARGET_DIR)/usr/bin/python
endef

PYTHON3_POST_INSTALL_TARGET_HOOKS += PYTHON3_INSTALL_SYMLINK

define HOST_PYTHON3_INSTALL_SYMLINK
	ln -fs python3 $(HOST_DIR)/bin/python
	ln -fs python3-config $(HOST_DIR)/bin/python-config
endef

HOST_PYTHON3_POST_INSTALL_HOOKS += HOST_PYTHON3_INSTALL_SYMLINK

# Provided to other packages
PYTHON3_PATH = $(STAGING_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)/

# Support for socket.AF_BLUETOOTH
ifeq ($(BR2_PACKAGE_BLUEZ5_UTILS_HEADERS),y)
PYTHON3_DEPENDENCIES += bluez5_utils-headers
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))

ifeq ($(BR2_REPRODUCIBLE),y)
define PYTHON3_FIX_TIME
	find $(TARGET_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR) -name '*.py' -print0 | \
		xargs -0 --no-run-if-empty touch -d @$(SOURCE_DATE_EPOCH)
endef
endif

define PYTHON3_CREATE_PYC_FILES
	$(PYTHON3_FIX_TIME)
	PYTHONPATH="$(PYTHON3_PATH)" \
	$(HOST_DIR)/bin/python$(PYTHON3_VERSION_MAJOR) \
		$(PYTHON3_DIR)/Lib/compileall.py \
		$(if $(VERBOSE),,-q) \
		$(if $(BR2_PACKAGE_PYTHON3_PYC_ONLY),-b) \
		-s $(TARGET_DIR) \
		-p / \
		$(TARGET_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)
endef

ifeq ($(BR2_PACKAGE_PYTHON3_PYC_ONLY)$(BR2_PACKAGE_PYTHON3_PY_PYC),y)
PYTHON3_TARGET_FINALIZE_HOOKS += PYTHON3_CREATE_PYC_FILES
endif

ifeq ($(BR2_PACKAGE_PYTHON3_PYC_ONLY),y)
define PYTHON3_REMOVE_PY_FILES
	find $(TARGET_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR) -name '*.py' \
		$(if $(strip $(KEEP_PYTHON_PY_FILES)),-not \( $(call finddirclauses,$(TARGET_DIR),$(KEEP_PYTHON_PY_FILES)) \) ) \
		-print0 | \
		xargs -0 --no-run-if-empty rm -f
endef
PYTHON3_TARGET_FINALIZE_HOOKS += PYTHON3_REMOVE_PY_FILES
endif

# Normally, *.pyc files should not have been compiled, but just in
# case, we make sure we remove all of them.
ifeq ($(BR2_PACKAGE_PYTHON3_PY_ONLY),y)
define PYTHON3_REMOVE_PYC_FILES
	find $(TARGET_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR) -name '*.pyc' -print0 | \
		xargs -0 --no-run-if-empty rm -f
endef
PYTHON3_TARGET_FINALIZE_HOOKS += PYTHON3_REMOVE_PYC_FILES
endif

# In all cases, we don't want to keep the optimized .opt-1.pyc and
# .opt-2.pyc files, since they can't work without their non-optimized
# variant.
define PYTHON3_REMOVE_OPTIMIZED_PYC_FILES
	find $(TARGET_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR) -name '*.opt-1.pyc' -print0 -o -name '*.opt-2.pyc' -print0 | \
		xargs -0 --no-run-if-empty rm -f
endef
PYTHON3_TARGET_FINALIZE_HOOKS += PYTHON3_REMOVE_OPTIMIZED_PYC_FILES
