################################################################################
#
# perl-cgi
#
################################################################################

PERL_CGI_VERSION = 4.72
PERL_CGI_SOURCE = CGI-$(PERL_CGI_VERSION).tar.gz
PERL_CGI_SITE = $(BR2_CPAN_MIRROR)/authors/id/L/LE/LEEJO
PERL_CGI_LICENSE = Artistic-2.0
PERL_CGI_LICENSE_FILES = LICENSE
PERL_CGI_DISTNAME = CGI

$(eval $(perl-package))
