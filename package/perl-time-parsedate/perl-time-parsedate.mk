################################################################################
#
# perl-time-parsedate
#
################################################################################

PERL_TIME_PARSEDATE_VERSION = 2026.033
PERL_TIME_PARSEDATE_SOURCE = Time-ParseDate-$(PERL_TIME_PARSEDATE_VERSION).tar.gz
PERL_TIME_PARSEDATE_SITE = $(BR2_CPAN_MIRROR)/authors/id/B/BP/BPS
PERL_TIME_PARSEDATE_LICENSE = Artistic or GPL-1.0+
PERL_TIME_PARSEDATE_LICENSE_FILES = README
PERL_TIME_PARSEDATE_DISTNAME = Time-ParseDate

$(eval $(perl-package))
