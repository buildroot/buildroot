# Copyright (C) 2021 Metrological
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

CC ?= cc
CXX ?= c++

ifeq ($(CFLAGS)x,x)
$(warning warning: CFLAGS is empty.)
endif

ifeq ($(CXXFLAGS)x,x)
$(warning warning: CXXFLAGS is empty.)
endif

ifeq ($(CPPFLAGS)x,x)
$(warning warning: CPPFLAGS is empty)
endif

ifeq ($(LDFLAGS)x,x)
$(warning warning: LDFLAGS is empty.)
endif

ifeq ($(LIBS)x,x)
$(warning warning: LIBS is empty.)
endif

# At least required
override CXXFLAGS += --std=c++11 -O0

# The input files
srcdir :=
# The intermediate files
objdir := .obj
# The final result files
bindir := .bin

# All *.cpp files should get corresponding object files 
headers := $(wildcard $(srcdir)*.h)
sources := $(wildcard $(srcdir)*.cpp)
objects := $(patsubst %cpp,$(objdir)/%o,$(sources))


build = $(CXX) -Wl,--verbose $(LDFLAGS) $(objdir)/$(@).o -o $(bindir)/$(@)

rebuild = touch $(sources);


# The main target(s)
all:
	$(error "Specify drm-prime-multi as target")

#https://www.gnu.org/software/make/manual/make.html#Target_002dspecific
drm-prime-multi: EXTRA_FLAGS=-DNO_FLAGS

# Generate the binaries
drm-prime-multi: $(objects) | $(bindir)

	$(call build)

# Create all object files
$(objdir)/%.o: %.cpp | $(objdir)

	$(CXX) -Wp,$(CPPFLAGS) -Wp,$(EXTRA_FLAGS) -Wp,'-I $(headers)' -c -o $@ $< $(CXXFLAGS)
	$(call rebuild)

# Only run once, not after updating / placing a (new) file here
$(bindir):

	mkdir -p $(bindir)

# Only run once, not after updating / placing a (new) file here
$(objdir):

	mkdir -p $(objdir)

# Tidy up
clean:

	rm -rf $(bindir)
	rm -rf $(objdir)

# Targets that might have conflicting names with existing files
.PHONE: $(objdir) clean
