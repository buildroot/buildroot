################################################################################
#
# perl-www-robotrules
#
################################################################################

PERL_WWW_ROBOTRULES_VERSION = 6.03
PERL_WWW_ROBOTRULES_SOURCE = WWW-RobotRules-$(PERL_WWW_ROBOTRULES_VERSION).tar.gz
PERL_WWW_ROBOTRULES_SITE = $(BR2_CPAN_MIRROR)/authors/id/O/OA/OALDERS
PERL_WWW_ROBOTRULES_LICENSE = Artistic or GPL-1.0+
PERL_WWW_ROBOTRULES_LICENSE_FILES = LICENSE
PERL_WWW_ROBOTRULES_DISTNAME = WWW-RobotRules

$(eval $(perl-package))
