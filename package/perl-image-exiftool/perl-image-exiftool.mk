################################################################################
#
# perl-image-exiftool
#
################################################################################

PERL_IMAGE_EXIFTOOL_VERSION = 12.50
PERL_IMAGE_EXIFTOOL_SOURCE = Image-ExifTool-$(PERL_IMAGE_EXIFTOOL_VERSION).tar.gz
PERL_IMAGE_EXIFTOOL_SITE = $(BR2_CPAN_MIRROR)/authors/id/E/EX/EXIFTOOL
PERL_IMAGE_EXIFTOOL_LICENSE = Artistic or GPL-1.0+
PERL_IMAGE_EXIFTOOL_LICENSE_FILES = README
PERL_IMAGE_EXIFTOOL_DISTNAME = Image-ExifTool

$(eval $(perl-package))
