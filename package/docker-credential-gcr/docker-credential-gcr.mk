################################################################################
#
# docker-credential-gcr
#
################################################################################

DOCKER_CREDENTIAL_GCR_VERSION = v2.1.26
DOCKER_CREDENTIAL_GCR_SITE = https://github.com/GoogleCloudPlatform/docker-credential-gcr
DOCKER_CREDENTIAL_GCR_SITE_METHOD = git

DOCKER_CREDENTIAL_GCR_LICENSE = Apache-2.0
DOCKER_CREDENTIAL_GCR_LICENSE_FILES = LICENSE

DOCKER_CREDENTIAL_GCR_GOMOD = github.com/GoogleCloudPlatform/docker-credential-gcr/v2

$(eval $(golang-package))
