################################################################################
#
# perl-mime-base32
#
################################################################################

PERL_MIME_BASE32_VERSION = 1.303
PERL_MIME_BASE32_SOURCE = MIME-Base32-$(PERL_MIME_BASE32_VERSION).tar.gz
PERL_MIME_BASE32_SITE = $(BR2_CPAN_MIRROR)/authors/id/R/RE/REHSACK
PERL_MIME_BASE32_LICENSE = Artistic or GPL-1.0+
PERL_MIME_BASE32_LICENSE_FILES = ARTISTIC-1.0 GPL-1 LICENSE
PERL_MIME_BASE32_DISTNAME = MIME-Base32

$(eval $(perl-package))
