################################################################################
#
# perl-log-message
#
################################################################################

PERL_LOG_MESSAGE_VERSION = 0.08
PERL_LOG_MESSAGE_SOURCE = Log-Message-$(PERL_LOG_MESSAGE_VERSION).tar.gz
PERL_LOG_MESSAGE_SITE = $(BR2_CPAN_MIRROR)/authors/id/B/BI/BINGOS
PERL_LOG_MESSAGE_LICENSE = Artistic or GPL-1.0+
PERL_LOG_MESSAGE_LICENSE_FILES = README
PERL_LOG_MESSAGE_DISTNAME = Log-Message

$(eval $(perl-package))
