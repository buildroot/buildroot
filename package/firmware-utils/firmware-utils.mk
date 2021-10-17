################################################################################
#
# firmware-utils
#
################################################################################

FIRMWARE_UTILS_VERSION = 86739f2b3ae9502368b89ef37fa6f31c42aad6f4
FIRMWARE_UTILS_SITE = git://git.openwrt.org/project/firmware-utils.git
FIRMWARE_UTILS_LICENSE = \
	BSD-2-Clause (tplink-safeloader), \
	BSD-3-Clause (seama), \
	GPL-2.0 (add_header, bcmalgo, buffalo-enc, buffalo-lib, buffalo-tag, \
		 buffalo-tftp, dgfirmware, dns313-header, edimax_fw_header, \
		 fix-u-media-header, hcsmakeimage, mkbrncmdline, mkbrnimg, \
		 mkbuffaloimg, mkcameofw, mkcasfw, mkdapimg, mkdapimg2, \
		 mkdhpimg, mkdniimg, mkhilinkfw, mkmerakifw-old, mkmerakifw, \
		 mkplanexfw, mkporayfw, mkrasimage, mkrtn56uimg, mksenaofw, \
		 mksercommfw, mktitanimg, mktplinkfw-lib, mktplinkfw, \
		 mktplinkfw2, mkwrggimg, mkwrgimg, mkzcfw, mkzynfw, \
		 mkzyxelzldfw osbridge-crc, pc1crypt, srec2bin, trx2edips, \
		 uimage_padhdr, wrt400n, zyimage, zytrx), \
	GPL-2.0+ (addpattern, asustrx, bcm4908asus, bcm4908kernel, dgn3500sum, \
		  encode_crc, jcgimage, lzma2eva, makeamitbin, mkchkimg, \
		  mkcsysimg, mkdlinkfw-lib, mkdlinkfw, mkedimaximg, mkfwimage, \
		  mkfwimage2, mkheader_gemtek, mkmylofw, motorola-bin, \
		  nec-enc, oseama, otrx, ptgen, sign_dlink_ru, spw303v, trx, \
		  uimage_sgehdr, xiaomifw, xorimage, zyxbcm), \
	GPL-2.0 OR GPL-3.0 (nand_ecc), \
	GPL-2.0+ OR MIT (lxlfw), \
	UNKNOWN (imagetag, trx2usr)
# No explicit license file. We could use the source files, but that would mean
# we need to use all of them. If we need to do that, we can just as well leave
# it to the integrator to get them from the sources

FIRMWARE_UTILS_DEPENDENCIES = openssl zlib
HOST_FIRMWARE_UTILS_DEPENDENCIES = host-openssl host-zlib

$(eval $(cmake-package))
$(eval $(host-cmake-package))
