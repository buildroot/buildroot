################################################################################
#
# host-mender-artifact
#
################################################################################

HOST_MENDER_ARTIFACT_VERSION = 4.1.0
HOST_MENDER_ARTIFACT_SITE = $(call github,mendersoftware,mender-artifact,$(HOST_MENDER_ARTIFACT_VERSION))
HOST_MENDER_ARTIFACT_LICENSE = Apache2.0, BSD-2-Clause, BSD-3-Clause, ISC, MIT, MPL-2.0
# Vendor license paths generated with:
#    awk '{print $2}' LIC_FILES_CHKSUM.sha256 | grep vendor
HOST_MENDER_ARTIFACT_LICENSE_FILES = \
	LICENSE \
	LIC_FILES_CHKSUM.sha256 \
	vendor/github.com/minio/sha256-simd/LICENSE \
	vendor/github.com/mendersoftware/progressbar/LICENSE \
	vendor/google.golang.org/genproto/LICENSE \
	vendor/google.golang.org/genproto/googleapis/api/LICENSE \
	vendor/google.golang.org/genproto/googleapis/rpc/LICENSE \
	vendor/google.golang.org/grpc/LICENSE \
	vendor/cloud.google.com/go/kms/LICENSE \
	vendor/cloud.google.com/go/iam/LICENSE \
	vendor/cloud.google.com/go/compute/metadata/LICENSE \
	vendor/cloud.google.com/go/auth/LICENSE \
	vendor/cloud.google.com/go/auth/oauth2adapt/LICENSE \
	vendor/github.com/mendersoftware/openssl/LICENSE \
	vendor/github.com/googleapis/enterprise-certificate-proxy/LICENSE \
	vendor/github.com/go-jose/go-jose/v3/json/LICENSE \
	vendor/github.com/go-jose/go-jose/v3/LICENSE \
	vendor/github.com/google/s2a-go/LICENSE.md \
	vendor/github.com/Keyfactor/signserver-go-client-sdk/LICENSE \
	vendor/github.com/kylelemons/godebug/LICENSE \
	vendor/go.opentelemetry.io/otel/trace/LICENSE \
	vendor/go.opentelemetry.io/otel/LICENSE \
	vendor/go.opentelemetry.io/otel/metric/LICENSE \
	vendor/go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp/LICENSE \
	vendor/go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc/LICENSE \
	vendor/go.opentelemetry.io/auto/sdk/LICENSE \
	vendor/github.com/go-logr/logr/LICENSE \
	vendor/github.com/go-logr/stdr/LICENSE \
	vendor/github.com/pkg/errors/LICENSE \
	vendor/github.com/pkg/browser/LICENSE \
	vendor/github.com/pmezard/go-difflib/LICENSE \
	vendor/golang.org/x/sys/LICENSE \
	vendor/github.com/klauspost/compress/LICENSE \
	vendor/github.com/russross/blackfriday/v2/LICENSE.txt \
	vendor/golang.org/x/net/LICENSE \
	vendor/golang.org/x/oauth2/LICENSE \
	vendor/golang.org/x/text/LICENSE \
	vendor/golang.org/x/crypto/LICENSE \
	vendor/golang.org/x/time/LICENSE \
	vendor/golang.org/x/sync/LICENSE \
	vendor/google.golang.org/api/LICENSE \
	vendor/google.golang.org/api/internal/third_party/uritemplates/LICENSE \
	vendor/google.golang.org/protobuf/LICENSE \
	vendor/github.com/googleapis/gax-go/v2/LICENSE \
	vendor/github.com/klauspost/compress/internal/snapref/LICENSE \
	vendor/github.com/ulikunitz/xz/LICENSE \
	vendor/github.com/google/uuid/LICENSE \
	vendor/github.com/davecgh/go-spew/LICENSE \
	vendor/github.com/decred/dcrd/dcrec/secp256k1/v4/LICENSE \
	vendor/github.com/stretchr/testify/LICENSE \
	vendor/github.com/urfave/cli/LICENSE \
	vendor/github.com/sirupsen/logrus/LICENSE \
	vendor/github.com/klauspost/pgzip/LICENSE \
	vendor/github.com/cpuguy83/go-md2man/v2/LICENSE.md \
	vendor/gopkg.in/yaml.v3/LICENSE \
	vendor/github.com/mattn/go-isatty/LICENSE \
	vendor/github.com/klauspost/cpuid/v2/LICENSE \
	vendor/github.com/mitchellh/go-homedir/LICENSE \
	vendor/github.com/mitchellh/mapstructure/LICENSE \
	vendor/github.com/ryanuber/go-glob/LICENSE \
	vendor/github.com/cenkalti/backoff/v3/LICENSE \
	vendor/github.com/klauspost/compress/zstd/internal/xxhash/LICENSE.txt \
	vendor/github.com/Azure/azure-sdk-for-go/sdk/internal/LICENSE.txt \
	vendor/github.com/Azure/azure-sdk-for-go/sdk/azidentity/LICENSE.txt \
	vendor/github.com/Azure/azure-sdk-for-go/sdk/security/keyvault/internal/LICENSE.txt \
	vendor/github.com/Azure/azure-sdk-for-go/sdk/security/keyvault/azkeys/LICENSE.txt \
	vendor/github.com/Azure/azure-sdk-for-go/sdk/azcore/LICENSE.txt \
	vendor/github.com/AzureAD/microsoft-authentication-library-for-go/LICENSE \
	vendor/github.com/goccy/go-json/LICENSE \
	vendor/github.com/golang-jwt/jwt/v5/LICENSE \
	vendor/github.com/lestrrat-go/iter/LICENSE \
	vendor/github.com/lestrrat-go/blackmagic/LICENSE \
	vendor/github.com/lestrrat-go/backoff/v2/LICENSE \
	vendor/github.com/lestrrat-go/httpcc/LICENSE \
	vendor/github.com/lestrrat-go/option/LICENSE \
	vendor/github.com/lestrrat-go/jwx/LICENSE \
	vendor/github.com/hashicorp/go-secure-stdlib/strutil/LICENSE \
	vendor/github.com/hashicorp/go-secure-stdlib/parseutil/LICENSE \
	vendor/github.com/hashicorp/errwrap/LICENSE \
	vendor/github.com/hashicorp/hcl/LICENSE \
	vendor/github.com/hashicorp/go-cleanhttp/LICENSE \
	vendor/github.com/hashicorp/go-rootcerts/LICENSE \
	vendor/github.com/hashicorp/go-retryablehttp/LICENSE \
	vendor/github.com/hashicorp/go-sockaddr/LICENSE \
	vendor/github.com/hashicorp/vault/api/LICENSE \
	vendor/github.com/hashicorp/go-multierror/LICENSE \
	vendor/github.com/felixge/httpsnoop/LICENSE.txt

HOST_MENDER_ARTIFACT_DEPENDENCIES = host-pkgconf host-openssl host-xz

ifeq ($(BR2_PACKAGE_HOST_ZSTD),y)
HOST_MENDER_ARTIFACT_DEPENDENCIES += host-zstd
endif

HOST_MENDER_ARTIFACT_GO_ENV += \
	PATH=$(BR_PATH) \
	PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG_LIBDIR="$(HOST_DIR)/lib/pkgconfig:$(HOST_DIR)/share/pkgconfig" \
	PKG_CONFIG_PATH="$(HOST_DIR)/lib/pkgconfig" \
	PKG_CONFIG_SYSROOT_DIR="/"

HOST_MENDER_ARTIFACT_LDFLAGS = -X github.com/mendersoftware/mender-artifact/cli.Version=$(HOST_MENDER_ARTIFACT_VERSION)

HOST_MENDER_ARTIFACT_BIN_NAME = mender-artifact
HOST_MENDER_ARTIFACT_INSTALL_BINS = $(HOST_MENDER_ARTIFACT_BIN_NAME)

$(eval $(host-golang-package))
