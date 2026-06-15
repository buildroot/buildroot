################################################################################
#
# perl-cgi-session
#
################################################################################

PERL_CGI_SESSION_VERSION = 4.48
PERL_CGI_SESSION_SOURCE = CGI-Session-$(PERL_CGI_SESSION_VERSION).tar.gz
PERL_CGI_SESSION_SITE = $(BR2_CPAN_MIRROR)/authors/id/M/MA/MARKSTOS
PERL_CGI_SESSION_DEPENDENCIES = host-perl-module-build
PERL_CGI_SESSION_LICENSE = Artistic-1.0
PERL_CGI_SESSION_LICENSE_FILES = README
PERL_CGI_SESSION_DISTNAME = CGI-Session

$(eval $(perl-package))
