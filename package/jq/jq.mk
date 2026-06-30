################################################################################
#
# jq
#
################################################################################

JQ_VERSION = 1.8.1
JQ_SITE = https://github.com/jqlang/jq/releases/download/jq-$(JQ_VERSION)
JQ_LICENSE = MIT (code), ICU (decNumber), CC-BY-3.0 (documentation), \
	BSD-2-Clause (strptime)
JQ_LICENSE_FILES = COPYING
JQ_CPE_ID_VENDOR = jqlang
JQ_INSTALL_STAGING = YES

# 0001-fix-out-of-bounds-read-in-jv-parse-sized.patch
JQ_IGNORE_CVES += CVE-2026-39979

# 0002-fix-NUL-truncation-in-the-JSON-parser.patch
JQ_IGNORE_CVES += CVE-2026-33948

# 0003-limit-path-depth-to-prevent-stack-overflow.patch
JQ_IGNORE_CVES += CVE-2026-33947

# 0004-fix-heap-buffer-overflow-in-jvp-string-append-and-jvp-string-copy-replace-bad.patch
JQ_IGNORE_CVES += CVE-2026-32316

# 0005-randomize-hash-seed-to-mitigate-hash-collision-DoS-attacks.patch
JQ_IGNORE_CVES += CVE-2026-40164

# 0006-limit-the-containment-check-depth.patch
JQ_IGNORE_CVES += 8:CVE: CVE-2026-40612

# 0007-fix-NUL-truncation-in-program-files-loaded-with-f.patch
JQ_IGNORE_CVES += CVE-2026-41256

# 0008-fix-signed-int-overflow-in-stack-reallocate.patch
JQ_IGNORE_CVES += CVE-2026-41257

# 0009-reject-numeric-literals-longer-than-DEC-MAX-DIGITS.patch
JQ_IGNORE_CVES += CVE-2026-43894

# 0010-reject-embedded-NUL-bytes-in-module-import-paths.patch
JQ_IGNORE_CVES += CVE-2026-43895

# 0011-limit-recursive-object-merge-depth-to-prevent-stack-overflow.patch
JQ_IGNORE_CVES += CVE-2026-43896

# 0012-detect-circular-module-imports-to-prevent-stack-overflow.patch
JQ_IGNORE_CVES += CVE-2026-44777

# 0013-guard-deep-structural-equality-and-comparison-recursion.patch
JQ_IGNORE_CVES += CVE-2026-47770

# 0014-fix-heap-buffer-overflow-in-raw-file-loading.patch
JQ_IGNORE_CVES += CVE-2026-49839

# 0015-tighten-string-length-bounds-and-propagate-invalid-jv-in-implode.patch
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
