/*
Copyright (C) 2020 Metrological
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#include "common.h"

#include <iostream>

#ifdef __cplusplus
extern "C" {
#endif

#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#include <dlfcn.h>
#undef _GNU_SOURCE

#ifdef __cplusplus
}
#endif

// An interposition target function should be located outside this library
COMMON_PRIVATE const std::string& libraryName () {
    static std::string _libname;

    if (_libname.empty () == true) {
        Dl_info info;

        if (dladdr (reinterpret_cast <void*> (&libraryName), &info) != 0) {
            if (info.dli_fname != nullptr) {
                LOG ("Library name ", info.dli_fname);
                _libname = info.dli_fname;
            }
        }
    }

     return _libname;
}

// Lookup the symbols in the scope associated with this library
COMMON_PRIVATE bool lookup (const std::string& symbol, uintptr_t& _address, bool default_scope) {
    bool ret = false;

    if (symbol.empty () != true)
    {
        // Its result might be statically allocated, hence, do not free it.
        /*char**/ dlerror();

        // Interposition requires to look outside this library
        _address = reinterpret_cast <uintptr_t> ( dlsym (default_scope ? RTLD_DEFAULT : RTLD_NEXT, symbol.data ()) );

        if (dlerror () == nullptr) {
            Dl_info info;

            if (dladdr ( reinterpret_cast <void*> (_address), &info ) != 0) {
                if (info.dli_fname != nullptr) {
                    LOG ("Library name ", info.dli_fname);

                    const std::string& _libraryName = libraryName ();

                    ret = _libraryName.empty () != true && _libraryName.compare (info.dli_fname) != 0;
                }
            }
        }
    }

    return ret;
}

COMMON_PRIVATE bool loaded(const std::string& lib) {
    bool ret = false;

    if (lib.empty () != true) {
        // Its result might be statically allocated, hence, do not free it.
        /*char**/ dlerror();

        // RTLD_NOLOAD does not exist in POSIX
        void* _handle = dlopen (lib.data (), RTLD_LAZY | RTLD_LOCAL);

        if (_handle != nullptr) {
            ret = true;
            /* int */ dlclose (_handle);
        }
        else {
            LOG ("Unable to test for loaded library ", lib.data (), " with error : ", dlerror ());
        }
    }

    return ret;
}
