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

#include <array>
#include <queue>

#include "common.h"
#ifdef _ENABLE_BENCHMARK
#include "benchmark.h"
#endif

template <typename T>
class IQueue {

    public :

#ifdef _ENABLE_BENCHMARK
        IQueue () : _count (0) {
        }
#else
        IQueue () = default;
#endif

        virtual ~IQueue () {
#ifdef _ENABLE_BENCHMARK
            LOG (_count,  _2CSTR (" buffers added in : "));
#endif
        }

        void push (const T& element) {
#ifdef _ENABLE_BENCHMARK
            ++_count;
#endif

            _push (element);
        }

        T pop  () {
            return _pop ();
        }

        virtual std::size_t size () const = 0;

    protected :

        virtual void  _push (const T& element) = 0;
        virtual T _pop  () = 0;

    private :

#ifdef _ENABLE_BENCHMARK
        Timer _duration;

        std::size_t _count;
#endif

};

template <typename T, std::size_t N>
class FixedSizedQueue : public IQueue <T> {

    public :

        FixedSizedQueue () : _size (0), _front (0), _back (0) {};
        ~FixedSizedQueue () = default;

        std::size_t size () const override {
            return _size;
        }

    protected :

        void _push (const T& element) override {
            assert (_size < N);

            _queue.at (_back) = element;

            _back = (_back + 1) % N;

            ++_size;
        }

        T _pop () override {
            assert (_size > 0);

            T ret = _queue.at (_front);

            _front = (_front + 1) % N;

            --_size;

            return ret;
        }

    private :

        std::array <T, N> _queue;

        std::size_t _size, _front, _back;
};


template <typename T>
class DynamicSizedQueue : public IQueue <T> {

    public :
        DynamicSizedQueue ()  = default;
        ~DynamicSizedQueue () = default;

        std::size_t size () const {
            return _queue.size ();
        }

    protected :

        void _push (const T& element) override {
//            assert (size () < N);

            /* void */  _queue.push (element);
        }

        T _pop () {
            assert (size () > 0);

            T& _ret = _queue.front ();

            /* void */ _queue.pop ();

            return _ret;
        }

    private :

        std::queue <T> _queue;
};
