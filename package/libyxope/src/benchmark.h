/*
Copyright (C) 2020-2021 Metrological
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

First attempt. Possibly wrong and / or incomplete, and may contain 'bad' code and / or coding practice.
*/

#pragma once

#if __cplusplus >= 200704L || defined (__cpp_variadic_templates)
#warning "Variadic templates are supported"
#else
#error "Variadic templates are NOT supported but support is required"
#endif

#include <chrono>
#include <typeinfo>

#ifdef __GNUG__
#ifdef __cplusplus
extern "C" {
#endif
#include <cxxabi.h>
#ifdef __cplusplus
}
#endif
#else
#error For benchmarking the GNU compiler suite is expected
#endif

#include "common.h"

// Various 'crude' and non-perfect ways to get some estimates

namespace {

    class Timer { 
        using clock_t = std::chrono::steady_clock;
        using timepoint_t = std::chrono::time_point <clock_t>;

        public :

            Timer () {
                // Start
                _start = clock_t::now();
            }

            ~Timer () {
                timepoint_t _finish = clock_t::now();

                static_assert (clock_t::period::num == 1);

                switch (clock_t::period::den) {
                    case 1000000    :   // microsecond precision
                                        LOG (std::chrono::duration_cast <std::chrono::microseconds> (_finish - _start).count (), _2CSTR (" [microseonds]"));
                                        break;
                    case 1000000000 :   // nanosecond precision
                                        LOG (std::chrono::duration_cast <std::chrono::nanoseconds> (_finish - _start).count (), _2CSTR (" [nanoseconds]"));
                                        break;
                    default         :   // Too coarse
                                        LOG ( _2CSTR ("Error [insufficient time precision]."));
                                        ;
                }
            }

        private :

            timepoint_t _start;
    };

    class demangle {

        public:

        static std::string name (const std::type_info& info) {
            int _status =0;
            char* _name = abi::__cxa_demangle (info.name (), nullptr, nullptr, &_status);

            std::string name = (_status != 0 ? "Unknown name "  : _name);

            if (_name != nullptr) {
                free (_name);
            }

            return name;
        }
    };

}

// No arguments
template <typename Func>
auto profile (Func func) -> decltype (func ())
{
    std::string _name = demangle::name (typeid (func));

    LOG (_name , _2CSTR(" : "));

    Timer _time;

    return func ();
}

template <typename Func, typename ... Args>
auto profile (Func func, Args&&... args) -> decltype (func (std::forward <Args...> (args...)))
{
    std::string _name = demangle::name (typeid (func));

    LOG ( _2CSTR (" : "));

    Timer _time;

    return func (std::forward <Args...> (args...));
}
