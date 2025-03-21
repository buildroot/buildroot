################################################################################
#
# amazon-ecr-credential-helper
#
################################################################################

AMAZON_ECR_CREDENTIAL_HELPER_VERSION = v0.9.1
AMAZON_ECR_CREDENTIAL_HELPER_SITE = https://github.com/awslabs/amazon-ecr-credential-helper
AMAZON_ECR_CREDENTIAL_HELPER_SITE_METHOD = git

AMAZON_ECR_CREDENTIAL_HELPER_LICENSE = Apache-2.0
AMAZON_ECR_CREDENTIAL_HELPER_LICENSE_FILES = LICENSE

AMAZON_ECR_CREDENTIAL_HELPER_SUBDIR = ecr-login

AMAZON_ECR_CREDENTIAL_HELPER_GOMOD = ./cli
AMAZON_ECR_CREDENTIAL_HELPER_BUILD_TARGETS = docker-credential-ecr-login
AMAZON_ECR_CREDENTIAL_HELPER_INSTALL_BINS = docker-credential-ecr-login

$(eval $(golang-package))
