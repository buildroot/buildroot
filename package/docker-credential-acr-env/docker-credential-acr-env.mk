################################################################################
#
# docker-credential-acr-env
#
################################################################################

DOCKER_CREDENTIAL_ACR_ENV_VERSION = 0.7.0
DOCKER_CREDENTIAL_ACR_ENV_SITE = https://github.com/chrismellard/docker-credential-acr-env
DOCKER_CREDENTIAL_ACR_ENV_SITE_METHOD = git

DOCKER_CREDENTIAL_ACR_ENV_LICENSE = Apache-2.0
DOCKER_CREDENTIAL_ACR_ENV_LICENSE_FILES = LICENSE

$(eval $(golang-package))
