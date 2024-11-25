################################################################################
#
# perl-gdgraph
#
################################################################################

PERL_GDGRAPH_VERSION = 1.56
PERL_GDGRAPH_SOURCE = GDGraph-$(PERL_GDGRAPH_VERSION).tar.gz
PERL_GDGRAPH_SITE = $(BR2_CPAN_MIRROR)/authors/id/B/BP/BPS
PERL_GDGRAPH_LICENSE = Artistic or GPL-1.0+ (perl module), GPL-2.0+ (font)
PERL_GDGRAPH_LICENSE_FILES = Dustismo.LICENSE README
PERL_GDGRAPH_DISTNAME = GDGraph

$(eval $(perl-package))
