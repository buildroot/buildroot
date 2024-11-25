################################################################################
#
# perl-clone
#
################################################################################

PERL_CLONE_VERSION = 0.47
PERL_CLONE_SOURCE = Clone-$(PERL_CLONE_VERSION).tar.gz
PERL_CLONE_SITE = $(BR2_CPAN_MIRROR)/authors/id/A/AT/ATOOMIC
PERL_CLONE_LICENSE = Artistic or GPL-1.0+
PERL_CLONE_LICENSE_FILES = README.md
PERL_CLONE_DISTNAME = Clone

$(eval $(perl-package))
