################################################################################
#
# This file contains the download helpers for the various package
# infrastructures. It is used to handle downloads from HTTP servers,
# FTP servers, Git repositories, Subversion repositories, Mercurial
# repositories, Bazaar repositories, and SCP servers.
#
################################################################################

# Version of the format of the archives we generate in the corresponding
# download backend and post-process:
BR_FMT_VERSION_git = -git4
BR_FMT_VERSION_svn = -svn5
BR_FMT_VERSION_go = -go2
BR_FMT_VERSION_cargo = -cargo2

DL_WRAPPER = support/download/dl-wrapper

# DL_DIR may have been set already from the environment
ifeq ($(origin DL_DIR),undefined)
DL_DIR ?= $(call qstrip,$(BR2_DL_DIR))
ifeq ($(DL_DIR),)
DL_DIR := $(TOPDIR)/dl
endif
else
# Restore the BR2_DL_DIR that was overridden by the .config file
BR2_DL_DIR = $(DL_DIR)
endif

# ensure it exists and a absolute path, dereferencing symlinks
DL_DIR := $(shell mkdir -p $(DL_DIR) && cd $(DL_DIR) >/dev/null && pwd -P)

#
# URI scheme helper functions
# Example URIs:
# * http://www.example.com/dir/file
# * scp://www.example.com:dir/file (with domainseparator :)
#
# geturischeme: http
geturischeme = $(firstword $(subst ://, ,$(call qstrip,$(1))))
# getschemeplusuri: git|parameter+http://example.com
getschemeplusuri = $(call geturischeme,$(1))$(if $(2),\|$(2))+$(1)
# stripurischeme: www.example.com/dir/file
stripurischeme = $(lastword $(subst ://, ,$(call qstrip,$(1))))
# domain: www.example.com
domain = $(firstword $(subst $(call domainseparator,$(2)), ,$(call stripurischeme,$(1))))
# notdomain: dir/file
notdomain = $(patsubst $(call domain,$(1),$(2))$(call domainseparator,$(2))%,%,$(call stripurischeme,$(1)))
#
# default domainseparator is /, specify alternative value as first argument
domainseparator = $(if $(1),$(1),/)

# github(user,package,version): returns site of GitHub repository
github = https://github.com/$(1)/$(2)/archive/$(3)

# gitlab(user,package,version): returns site of Gitlab-generated tarball
gitlab = https://gitlab.com/$(1)/$(2)/-/archive/$(3)

# Expressly do not check hashes for those files
BR_NO_CHECK_HASH_FOR =

################################################################################
# DOWNLOAD_URIS - List the candidates URIs where to get the package from:
# 1) BR2_PRIMARY_SITE if enabled
# 2) Download site, unless BR2_PRIMARY_SITE_ONLY is set
# 3) BR2_BACKUP_SITE if enabled, unless BR2_PRIMARY_SITE_ONLY is set
#
# Argument 1 is the source location
# Argument 2 is the upper-case package name
#
################################################################################

ifneq ($(call qstrip,$(BR2_PRIMARY_SITE)),)
DOWNLOAD_URIS += \
	$(call getschemeplusuri,$(call qstrip,$(BR2_PRIMARY_SITE)/$($(2)_DL_SUBDIR)),urlencode) \
	$(call getschemeplusuri,$(call qstrip,$(BR2_PRIMARY_SITE)),urlencode)
endif

ifeq ($(BR2_PRIMARY_SITE_ONLY),)
DOWNLOAD_URIS += \
	$(patsubst %/,%,$(dir $(call qstrip,$(1))))
ifneq ($(call qstrip,$(BR2_BACKUP_SITE)),)
DOWNLOAD_URIS += \
	$(call getschemeplusuri,$(call qstrip,$(BR2_BACKUP_SITE)/$($(2)_DL_SUBDIR)),urlencode) \
	$(call getschemeplusuri,$(call qstrip,$(BR2_BACKUP_SITE)),urlencode)
endif
endif

################################################################################
# DOWNLOAD -- Download helper. Will call DL_WRAPPER which will try to download
# source from the list returned by DOWNLOAD_URIS.
#
# Argument 1 is the source location
# Argument 2 is a space-separated list of optional arguments
#
################################################################################

# Restore the user's original umask during the whole download, in case he has
# provisions set to share the download directory with his group (or others).
ifneq ($(BR_ORIG_UMASK),)
DOWNLOAD_SET_UMASK = umask $(BR_ORIG_UMASK);
endif

define DOWNLOAD
	$(Q)$(DOWNLOAD_SET_UMASK) mkdir -p $($(PKG)_DL_DIR)
	$(Q)$(DOWNLOAD_SET_UMASK) $(EXTRA_ENV) \
	$($(PKG)_DL_ENV) \
	TAR="$(TAR)" \
	BZR="$(call qstrip,$(BR2_BZR))" \
	CURL="$(call qstrip,$(BR2_CURL))" \
	CVS="$(call qstrip,$(BR2_CVS))" \
	GIT="$(call qstrip,$(BR2_GIT))" \
	HG="$(call qstrip,$(BR2_HG))" \
	LOCALFILES="$(call qstrip,$(BR2_LOCALFILES))" \
	SCP="$(call qstrip,$(BR2_SCP))" \
	SFTP="$(call qstrip,$(BR2_SFTP))" \
	SVN="$(call qstrip,$(BR2_SVN))" \
	WGET="$(call qstrip,$(BR2_WGET))" \
	BR_NO_CHECK_HASH_FOR="$(if $(BR2_DOWNLOAD_FORCE_CHECK_HASHES),,$(BR_NO_CHECK_HASH_FOR))" \
		flock $($(PKG)_DL_DIR)/.lock $(DL_WRAPPER) \
		-c '$($(PKG)_DL_VERSION)' \
		-d '$($(PKG)_DL_DIR)' \
		-D '$(DL_DIR)' \
		-f '$(notdir $(1))' \
		$(foreach f,$($(PKG)_HASH_FILES),-H '$(f)') \
		-n '$($(PKG)_DL_SUBDIR)-$($(PKG)_VERSION)' \
		-N '$($(PKG)_RAWNAME)' \
		-o '$($(PKG)_DL_DIR)/$(notdir $(1))' \
		$(if $(filter YES,$($(PKG)_SVN_EXTERNALS)),-r) \
		$(if $($(PKG)_GIT_SUBMODULES),-r) \
		$(if $($(PKG)_GIT_LFS),-l) \
		$(foreach uri,$(call DOWNLOAD_URIS,$(1),$(PKG)),-u $(uri)) \
		$(2) \
		$(QUIET) \
		-- \
		$($(PKG)_DL_OPTS)
endef
