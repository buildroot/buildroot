################################################################################
#
# perl-module-runtime
#
################################################################################

PERL_MODULE_RUNTIME_VERSION = 0.018
PERL_MODULE_RUNTIME_SOURCE = Module-Runtime-$(PERL_MODULE_RUNTIME_VERSION).tar.gz
PERL_MODULE_RUNTIME_SITE = $(BR2_CPAN_MIRROR)/authors/id/H/HA/HAARG
PERL_MODULE_RUNTIME_LICENSE = Artistic or GPL-1.0+
PERL_MODULE_RUNTIME_LICENSE_FILES = LICENSE
PERL_MODULE_RUNTIME_DISTNAME = Module-Runtime

$(eval $(perl-package))
