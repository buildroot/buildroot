################################################################################
#
# perl-log-message-simple
#
################################################################################

PERL_LOG_MESSAGE_SIMPLE_VERSION = 0.10
PERL_LOG_MESSAGE_SIMPLE_SOURCE = Log-Message-Simple-$(PERL_LOG_MESSAGE_SIMPLE_VERSION).tar.gz
PERL_LOG_MESSAGE_SIMPLE_SITE = $(BR2_CPAN_MIRROR)/authors/id/B/BI/BINGOS
PERL_LOG_MESSAGE_SIMPLE_LICENSE = Artistic or GPL-1.0+
PERL_LOG_MESSAGE_SIMPLE_LICENSE_FILES = README
PERL_LOG_MESSAGE_SIMPLE_DISTNAME = Log-Message-Simple

$(eval $(perl-package))
