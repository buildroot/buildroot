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

#if defined (NDEBUG)
#warning This library encourages assert to be available
#endif

#include <cassert>

#include <string>
// A little less code bloat
#define _2CSTR(str) std::string (str).c_str ()

#define COMMON_PRIVATE __attribute__ (( visibility ("hidden") ))
#define COMMON_PUBLIC __attribute__ (( visibility ("default") ))

#include <iostream>
#include <mutex>
#include <type_traits>
#include <thread>

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
}
#endif

#if !defined(LOG_PREFIX)
#ifndef NDEBUG
    #define LOG(...) _LOG(__VA_ARGS__)
#else
    // At least define a LOG
    #define LOG(...) ((void)0)
#endif
#else
    #define _UNKNOWN_ 1
    #define _RELEASE_ 2
    #define _DEBUG_ 3

    // At least define a LOG
    #define LOG(...) ((void)0)

#ifndef NDEBUG
    #if (LOG_PREFIX==_RELEASE_)
        #undef LOG
        #define LOG(...) _LOG(__VA_ARGS__)
    #endif

    #if (LOG_PREFIX==_DEBUG_)
        #undef LOG
        #define LOG(...) _LOG(__FILE__, __LINE__, __VA_ARGS__)
    #endif
#endif

    #undef _UNKNOWN_
    #undef _RELEASE_
    #undef _DEBUG_
#endif

// Force internal linkage
namespace {

// Termination condition
void _LOG () {
    // Ensure the (default) standard stream objects are constructed before their first use
    static std::ios_base::Init _base;

    // Unbuffered!
    std::cerr << std::endl;
}

template <typename Head, typename... Tail>
void _LOG (const Head& head, const Tail&... tail) {
    // Ensure the (default) standard stream objects are constructed before their first use
    static std::ios_base::Init _base;

    // Unbuffered!
    std::cerr << head;

    _LOG (tail...);
}

} // Anonymous namespace

template <typename T>
class Singleton {

    public :

        Singleton (const Singleton&) = delete;
        Singleton (const Singleton&&) = delete;

        Singleton& operator= (const Singleton&) = delete;
        Singleton& operator= (Singleton&&) = delete;

        // Each shared object should have its own instance
        COMMON_PRIVATE static T& Instance ()
        {
            static T _instance;
            return _instance;
        }

    protected :

        COMMON_PRIVATE Singleton () = default;
        COMMON_PRIVATE virtual ~Singleton () = default;

    private :

        // Nothing
};

template <typename T>
class _Mutex : public T {
    public :

        // Only support these types of mutex (for now)
        static_assert (std::is_same <T, std::mutex>::value || std::is_same <T, std::recursive_mutex>::value != false);

        explicit _Mutex (const uint8_t depth = 1) : _maxlevel (depth) {};
        virtual ~_Mutex () {};

        // Currently, failure is not expressed by a return value, but it is handled via exception handling. This might change with (custom) implementations.
        // https://en.cppreference.com/w/cpp/thread/lock
        static_assert (std::is_void < decltype ( std::declval <T> ().lock () ) >::value != false);
        bool lock () {
            bool _ret = false;
#ifndef NDEBUG
            if (_mutex.try_lock () != false) {
                if (_taken != false && _count >= _maxlevel) {
                    LOG (_2CSTR ("Error: The mutex is already locked (too many times, max["), std::to_string (_maxlevel), _2CSTR ("]!"));

                    assert (false);

                    _ret = false;
                }
                else {
                    _owner = std::this_thread::get_id ();
                    _taken = true;
                    ++_count;
                }

                if (_ret != false) {
#endif

                    T::lock ();
                    _ret = true;
#ifndef NDEBUG
                }

                _mutex.unlock ();
            }
            else {
                // Error
                assert (false);

                _ret = false;
            }
#endif
            return _ret;
        }

        // See lock
        static_assert (std::is_void < decltype ( std::declval <T> ().unlock () ) >::value != false);
        bool unlock () {
            bool _ret = false;
#ifndef NDEBUG
            if (_mutex.try_lock () != false) {
                if (_taken != true) {
                    LOG (_2CSTR ("Error: The mutex is already unlocked!"));

                    assert (false);

                    _ret = false;
                }
                else {
                    if (_owner == std::this_thread::get_id ()) {
                        --_count;
                        if (_count <= 0) {
                            _taken = false;
                        }
                    }
                    else {
                        LOG (_2CSTR ("Error: Another thread is trying to unlock the mutex."));
                        assert (false);

                        _ret = false;
                    }
                }

                if (_ret != false) {
#endif
                    T::unlock ();
                    _ret = true;
#ifndef NDEBUG
                }

                _mutex.unlock ();
            }
            else {
                // Error
                assert (false);
            }
#endif
            return _ret;
        }

        bool try_lock () {
            bool _ret = false;

#ifndef NDEBUG
            _ret = T::try_lock ();
#else
            _ret = lock ();
#endif

            return _ret;
        }

        decltype ( std::declval <T> ().native_handle () ) native_handle () {
            return T::native_handle ();
        }

    protected :

        const uint8_t _maxlevel;

    private :

#ifndef NDEBUG
        // Maximum level of ownership is unknown
        // https://en.cppreference.com/w/cpp/thread/recursive_mutex/lock
        std::recursive_mutex _mutex;

        // Default does not contain an identifier that represents a thread
        // https://en.cppreference.com/w/cpp/thread/thread/id/id
        std::thread::id _owner;

        bool _taken = false;

        uint8_t _count = 0;
#endif
};

#ifdef NDEBUG
using Mutex = std::mutex;
#else
class Mutex : public _Mutex <std::mutex> {
    public :

        Mutex () = default;
        ~Mutex () final {};

    private :

        static constexpr uint8_t _depth = 1;
};
#endif

template <size_t N>
#ifdef NDEBUG
using MutexRecursive = std::recursive_mutex;
#else
class MutexRecursive : public _Mutex <std::recursive_mutex> {
    public :

        MutexRecursive () : _Mutex <std::recursive_mutex> (_depth) {};
        ~MutexRecursive () final {};

    private :

        static_assert (N > 1, "Error: For N <= 1, use Mutex instead");
        static constexpr uint8_t _depth = N;
};
#endif

COMMON_PRIVATE bool lookup (const std::string& symbol, uintptr_t& _address, bool default_scope = false);
COMMON_PRIVATE bool loaded(const std::string& lib);
