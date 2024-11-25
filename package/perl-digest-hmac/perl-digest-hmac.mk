################################################################################
#
# perl-digest-hmac
#
################################################################################

PERL_DIGEST_HMAC_VERSION = 1.05
PERL_DIGEST_HMAC_SOURCE = Digest-HMAC-$(PERL_DIGEST_HMAC_VERSION).tar.gz
PERL_DIGEST_HMAC_SITE = $(BR2_CPAN_MIRROR)/authors/id/A/AR/ARODLAND
PERL_DIGEST_HMAC_LICENSE = Artistic or GPL-1.0+
PERL_DIGEST_HMAC_LICENSE_FILES = LICENSE
PERL_DIGEST_HMAC_DISTNAME = Digest-HMAC

$(eval $(perl-package))
