################################################################################
#
# perl-mozilla-ca
#
################################################################################

PERL_MOZILLA_CA_VERSION = 20231213
PERL_MOZILLA_CA_SOURCE = Mozilla-CA-$(PERL_MOZILLA_CA_VERSION).tar.gz
PERL_MOZILLA_CA_SITE = $(BR2_CPAN_MIRROR)/authors/id/L/LW/LWP
PERL_MOZILLA_CA_LICENSE = MPL-2.0
PERL_MOZILLA_CA_LICENSE_FILES = README
PERL_MOZILLA_CA_DISTNAME = Mozilla-CA

$(eval $(perl-package))
