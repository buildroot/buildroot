################################################################################
#
# host-mender-artifact
#
################################################################################

HOST_MENDER_ARTIFACT_VERSION = 3.8.0
HOST_MENDER_ARTIFACT_SITE = $(call github,mendersoftware,mender-artifact,$(HOST_MENDER_ARTIFACT_VERSION))
HOST_MENDER_ARTIFACT_LICENSE = Apache2.0, BSD-2-Clause, BSD-3-Clause, ISC, MIT, MPL-2.0
HOST_MENDER_ARTIFACT_LICENSE_FILES = \
	LICENSE \
	LIC_FILES_CHKSUM.sha256 \
	vendor/github.com/minio/sha256-simd/LICENSE \
	vendor/github.com/mendersoftware/progressbar/LICENSE \
	vendor/google.golang.org/genproto/LICENSE \
	vendor/google.golang.org/grpc/LICENSE \
	vendor/google.golang.org/appengine/LICENSE \
	vendor/cloud.google.com/go/LICENSE \
	vendor/cloud.google.com/go/kms/LICENSE \
	vendor/cloud.google.com/go/iam/LICENSE \
	vendor/cloud.google.com/go/compute/LICENSE \
	vendor/go.opencensus.io/LICENSE \
	vendor/github.com/golang/groupcache/LICENSE \
	vendor/gopkg.in/square/go-jose.v2/LICENSE \
	vendor/github.com/oklog/run/LICENSE \
	vendor/github.com/pkg/errors/LICENSE \
	vendor/github.com/pmezard/go-difflib/LICENSE \
	vendor/golang.org/x/sys/LICENSE \
	vendor/github.com/remyoudompheng/go-liblzma/LICENSE \
	vendor/github.com/klauspost/compress/LICENSE \
	vendor/github.com/russross/blackfriday/v2/LICENSE.txt \
	vendor/github.com/google/go-cmp/LICENSE \
	vendor/golang.org/x/net/LICENSE \
	vendor/golang.org/x/oauth2/LICENSE \
	vendor/golang.org/x/text/LICENSE \
	vendor/golang.org/x/crypto/LICENSE \
	vendor/golang.org/x/time/LICENSE \
	vendor/google.golang.org/api/LICENSE \
	vendor/google.golang.org/api/internal/third_party/uritemplates/LICENSE \
	vendor/google.golang.org/protobuf/LICENSE \
	vendor/github.com/golang/protobuf/LICENSE \
	vendor/github.com/googleapis/gax-go/v2/LICENSE \
	vendor/github.com/golang/snappy/LICENSE \
	vendor/gopkg.in/square/go-jose.v2/json/LICENSE \
	vendor/github.com/pierrec/lz4/LICENSE \
	vendor/github.com/davecgh/go-spew/LICENSE \
	vendor/github.com/stretchr/testify/LICENSE \
	vendor/github.com/urfave/cli/LICENSE \
	vendor/github.com/sirupsen/logrus/LICENSE \
	vendor/github.com/klauspost/pgzip/LICENSE \
	vendor/github.com/cpuguy83/go-md2man/v2/LICENSE.md \
	vendor/github.com/shurcooL/sanitized_anchor_name/LICENSE \
	vendor/gopkg.in/yaml.v3/LICENSE \
	vendor/github.com/mattn/go-isatty/LICENSE \
	vendor/github.com/klauspost/cpuid/v2/LICENSE \
	vendor/go.uber.org/atomic/LICENSE.txt \
	vendor/github.com/mitchellh/go-homedir/LICENSE \
	vendor/github.com/mitchellh/go-testing-interface/LICENSE \
	vendor/github.com/mitchellh/mapstructure/LICENSE \
	vendor/github.com/mitchellh/copystructure/LICENSE \
	vendor/github.com/mitchellh/reflectwalk/LICENSE \
	vendor/github.com/ryanuber/go-glob/LICENSE \
	vendor/github.com/mattn/go-colorable/LICENSE \
	vendor/github.com/fatih/color/LICENSE.md \
	vendor/github.com/armon/go-radix/LICENSE \
	vendor/github.com/armon/go-metrics/LICENSE \
	vendor/github.com/cenkalti/backoff/v3/LICENSE \
	vendor/github.com/hashicorp/go-hclog/LICENSE \
	vendor/github.com/hashicorp/go-secure-stdlib/strutil/LICENSE \
	vendor/github.com/hashicorp/go-secure-stdlib/parseutil/LICENSE \
	vendor/github.com/hashicorp/errwrap/LICENSE \
	vendor/github.com/hashicorp/hcl/LICENSE \
	vendor/github.com/hashicorp/go-cleanhttp/LICENSE \
	vendor/github.com/hashicorp/go-version/LICENSE \
	vendor/github.com/hashicorp/go-rootcerts/LICENSE \
	vendor/github.com/hashicorp/go-retryablehttp/LICENSE \
	vendor/github.com/hashicorp/go-uuid/LICENSE \
	vendor/github.com/hashicorp/go-plugin/LICENSE \
	vendor/github.com/hashicorp/go-sockaddr/LICENSE \
	vendor/github.com/hashicorp/vault/sdk/LICENSE \
	vendor/github.com/hashicorp/vault/api/LICENSE \
	vendor/github.com/hashicorp/yamux/LICENSE \
	vendor/github.com/hashicorp/go-immutable-radix/LICENSE \
	vendor/github.com/hashicorp/go-multierror/LICENSE \
	vendor/github.com/hashicorp/golang-lru/LICENSE

HOST_MENDER_ARTIFACT_DEPENDENCIES = host-xz

HOST_MENDER_ARTIFACT_LDFLAGS = -X github.com/mendersoftware/mender-artifact/cli.Version=$(HOST_MENDER_ARTIFACT_VERSION)

HOST_MENDER_ARTIFACT_BIN_NAME = mender-artifact
HOST_MENDER_ARTIFACT_INSTALL_BINS = $(HOST_MENDER_ARTIFACT_BIN_NAME)

$(eval $(host-golang-package))
