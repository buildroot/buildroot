################################################################################
#
# poke
#
################################################################################

POKE_VERSION = 3.0
POKE_SITE = $(BR2_GNU_MIRROR)/poke
# gnulib license is a mix/mess of public-domain and various GPL and LGPL versions.
POKE_LICENSE = GPL-3.0+, GPL-3.0+ (jitter), gnulib license (gnulib)
POKE_LICENSE_FILES = COPYING jitter/COPYING

# 0001-configure.ac-HELP2MAN-replace-by-false-when-cross-co.patch
POKE_AUTORECONF = YES

POKE_INSTALL_STAGING = YES
POKE_DEPENDENCIES = host-flex host-bison host-pkgconf bdwgc readline

# poke bundle gnulib that doesn't support the case where
# host_os='linux-uclibc'. When cross-compiling, the guessed
# answers are mostly wrong and gnulib will try to replace
# snprintf with rpl_snprintf. This lead to "undefined reference
# to `rpl_snprintf'" errors.
ifeq ($(BR2_TOOLCHAIN_USES_UCLIBC),y)
POKE_CONF_ENV = gl_cv_func_printf_positions=yes \
	gl_cv_func_snprintf_retval_c99=yes \
	gl_cv_func_printf_sizes_c99=yes \
	gl_cv_func_printf_infinite_long_double=yes \
	gl_cv_func_snprintf_retval_c99=yes \
	gl_cv_func_snprintf_truncation_c99=yes \
	gl_cv_func_snprintf_usable=yes \
	gl_cv_func_strerror_0_works=yes \
	gl_cv_header_working_stdint_h=yes \
	gl_cv_func_printf_infinite=yes \
	gl_cv_func_printf_flag_zero=yes \
	gl_cv_func_printf_enomem=yes \
	gl_cv_func_printf_directive_f=yes \
	gl_cv_func_printf_directive_a=yes \
	gl_cv_func_snprintf_directive_n=yes \
	gl_cv_func_vsnprintf_posix=yes \
	gl_cv_func_vsnprintf_zerosize_c99=yes
endif

POKE_CONF_OPTS = \
	--disable-gui \
	--disable-libnbd \
	--with-libreadline-prefix=$(STAGING_DIR)

ifeq ($(BR2_PACKAGE_JSON_C),y)
POKE_DEPENDENCIES += json-c
POKE_CONF_OPTS += --enable-mi
else
POKE_CONF_OPTS += --disable-mi
endif

$(eval $(autotools-package))
