################################################################################
#
# jq
#
################################################################################

JQ_VERSION = 1.7.1
JQ_SITE = https://github.com/jqlang/jq/releases/download/jq-$(JQ_VERSION)
JQ_LICENSE = MIT (code), ICU (decNumber), CC-BY-3.0 (documentation)
JQ_LICENSE_FILES = COPYING
JQ_CPE_ID_VENDOR = jqlang
JQ_INSTALL_STAGING = YES

# 0001-CVE-2024-23337.patch
JQ_IGNORE_CVES += CVE-2024-23337

# 0002-CVE-2024-53427.patch
JQ_IGNORE_CVES += CVE-2024-53427

# 0003-CVE-2025-48060.patch
JQ_IGNORE_CVES += CVE-2025-48060

# 0004-fix-out-of-bounds-read-in-jv-parse-sized.patch
JQ_IGNORE_CVES += CVE-2026-39979

# 0005-fix-NUL-truncation-in-the-JSON-parser.patch
JQ_IGNORE_CVES += CVE-2026-33948

# 0006-limit-path-depth-to-prevent-stack-overflow.patch
JQ_IGNORE_CVES += CVE-2026-33947

# 0007-fix-heap-buffer-overflow-in-jvp-string-append-and-jvp-string-copy-replace-bad.patch
JQ_IGNORE_CVES += CVE-2026-32316

# 0008-randomize-hash-seed-to-mitigate-hash-collision-DoS-attacks.patch
JQ_IGNORE_CVES += CVE-2026-40164

# 0009-limit-the-containment-check-depth.patch
JQ_IGNORE_CVES += CVE-2026-40612

# 0010-fix-NUL-truncation-in-program-files-loaded-with-f.patch
JQ_IGNORE_CVES += CVE-2026-41256

# 0011-fix-signed-int-overflow-in-stack-reallocate.patch
JQ_IGNORE_CVES += CVE-2026-41257

# 0012-reject-numeric-literals-longer-than-DEC-MAX-DIGITS.patch
JQ_IGNORE_CVES += CVE-2026-43894

# 0013-limit-recursive-object-merge-depth-to-prevent-stack-overflow.patch
JQ_IGNORE_CVES += CVE-2026-43896

# 0014-detect-circular-module-imports-to-prevent-stack-overflow.patch
JQ_IGNORE_CVES += CVE-2026-44777

# 0015-fix-heap-buffer-overflow-in-raw-file-loading.patch
JQ_IGNORE_CVES += CVE-2026-49839

# 0016-tighten-string-length-bounds-and-propagate-invalid-jv-in-implode.patch
JQ_IGNORE_CVES += CVE-2026-54679

# uses c99 specific features
JQ_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) -std=c99"
HOST_JQ_CONF_ENV += CFLAGS="$(HOST_CFLAGS) -std=c99"

HOST_JQ_CONF_OPTS += --without-oniguruma

ifeq ($(BR2_PACKAGE_ONIGURUMA),y)
JQ_DEPENDENCIES += oniguruma
JQ_CONF_OPTS += --with-oniguruma
else
JQ_CONF_OPTS += --without-oniguruma
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))
