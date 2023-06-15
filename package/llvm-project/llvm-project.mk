################################################################################
#
# llvm-project
#
################################################################################

LLVM_PROJECT_VERSION_MAJOR = 15
LLVM_PROJECT_VERSION = $(LLVM_PROJECT_VERSION_MAJOR).0.3
LLVM_PROJECT_SITE = https://github.com/llvm/llvm-project/releases/download/llvmorg-$(LLVM_PROJECT_VERSION)

include $(sort $(wildcard package/llvm-project/*/*.mk))
