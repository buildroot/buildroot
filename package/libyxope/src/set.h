/*
Copyright (C) 2021 Metrological
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

#pragma once

#include <cstdint>
#include <cstdlib>
#include <type_traits>
#include <set>
#include <atomic>
#include <utility>

template <typename T, typename U = void>
class Element {
    // Fixes the symbol names for the debugger, any defined type will do
    using dummy_t = uintptr_t; 

    // Typical order of private and public sections swapped to make required types (pre)defined
    private:

        class Object {
            using U_t = typename std::remove_reference <U>::type;

            // Typical order of private and public sections swapped to make required types (pre)defined
            private :

                // U may have type 'void' and then a reference is ill- defined
                void const * _o;

                // Record use of new in Object (V&&)
                bool _created = false;

            public :

                // U == void

                Object () : _o {nullptr} {}

                // U != void

#ifndef _FORCE_WELL_DEFINED
                template <typename V = U, typename = typename std::enable_if <!std::is_same <V, void>::value, dummy_t>::type>
                // May become ill-defined if passed in argument goes out of scope
                explicit Object (V const & v) : _o {static_cast <decltype (_o)> (&v)} {}
#endif

                template <typename V = U, typename = typename std::enable_if <!std::is_same <V, void>::value, dummy_t>::type>
                explicit Object (V && v) : _o { static_cast <decltype (_o)> ( new typename std::remove_reference <V>::type (v) ) } {
                    _created = _o != nullptr;
                }

                // U == void || U != void

                ~Object () {
                    if (_created != false) {
// TODO: const_cast
//                        /* bool */ destroy ( const_cast <U_t *> (static_cast <U_t const *> (_o)));
                    }
                }

                Object (Object const & other) {
                    (* this) = other;
                }

                Object & operator = (Object const & other) {
// TODO not a robust assignemnt on failure
                    if (this != &other) {
                        _o = create ( static_cast <U_t const *> (other._o));

                        if (_o != nullptr) {
                            _created = other._created;
                        }

                        // Alternatively
//                        _created = _o != nullptr;
                    }

                    return * this;
                }

                // Effectively used as an inequality test
                bool operator < (Object const & other) const {
                    return ! (_o == other._o);
                }

                bool operator == (Object const & other) const {
                    // Shallow (pointer) comparison
                    return _o == other._o;
                }

                // U == void

                template <typename V = U, typename = typename std::enable_if <std::is_same <V, void>::value, dummy_t>::type>
                void operator () () const {
                    return;
                }

                // U != void

                template <typename V = U, typename = typename std::enable_if <!std::is_same <V, void>::value, dummy_t>::type>
                V const & operator () () const {
                    // Avoid a pointer to an rvalue reference, see Object (V &&)
                    using V_t = typename std::remove_reference <V>::type;

                    return * static_cast <V_t const *> (_o);
                }

            private :

                void * create (void const *) {
                    return nullptr;
                }

                template <typename V = U, typename = typename std::enable_if <!std::is_same <V, void>::value, dummy_t>::type>
                V * create (V const * v) {
                    return new V (* v);
                }

                // Matches the first constructor, ie, U == void
                bool destroy (void *) {
                    return  true;
                }

                template <typename V = U, typename = typename std::enable_if <!std::is_same <V, void>::value, dummy_t>::type>
                bool destroy (V * _v) {
                    if (_v != nullptr) {
                        delete _v;

                        _v  = nullptr;
                    }

                    return _v == nullptr;
                }
        };

        // Wrapped object placeholder
        typename std::remove_reference <T>::type _object;

        // Underlying object placeholder
        Object _o;

    public :

        Element () = delete;

        // U == void

        template <typename V = T, typename W = U, typename = typename std::enable_if <std::is_same <W, void>::value, dummy_t>::type>
        explicit Element (V const & v) : _object {v}, _o {} {}

        template <typename V = T, typename W = U, typename = typename std::enable_if <std::is_same <W, void>::value, dummy_t>::type>
        explicit Element (V && v) : _object { std::forward <V> (v)}, _o {} {}

        // U != void

        template <typename V = T, typename W = U, typename = typename std::enable_if <!std::is_same <W, void>::value, dummy_t>::type>
        Element (V && v, W && w) : _object { std::forward <V> (v) }, _o { std::forward <W> (w) } {}

        // U == void || U != void

        virtual ~Element () = default;

        Element (Element const & other) : _object {other._object}, _o {other._o} {}

        Element & operator = (Element const & other) {
            _object = other._object;

            _o = other._o;

            return * this;
        }

        // Unclear what the defaults should be after move
        Element (Element && other) = delete;

        // Unclear what the defaults should be after move
        bool operator = (Element && other) const = delete;

        // Default operator for 'insert' etc in std::set, eg, determines uniqueness
        bool operator < (Element const & other) const {
            return ! ((* this) == other);
        }

        bool operator == (Element const & other) const {
            return WrappedObject () == other.WrappedObject ();
        }

        bool Has (decltype (_object) const & o) const {
            return WrappedObject () == o;
        }

    protected:

        auto WrappedObject () const -> decltype (_object) const {
            return _object;
        }

        auto UnderlyingObject () const -> decltype (_o ()) const {
            return _o ();
        }
};

// A (modified) set containing key, value pair(s)
template <typename T, typename U = void>
class Set {
    // Fixes the symbol names for the debugger, any defined type will do
    using dummy_t = uintptr_t; 

    // Typical order of private and public sections swapped to make required types (pre)defined
    private :

        std::set < Element <T, U> > _set;

    public :

        Set () {
            // Always start with an empty set
            _set.clear ();
        }

        virtual ~Set () {
            _set.clear ();
        }

    protected :

        // This provides access to the wrapped / underlying object type T in Element < T >
        class Onion final : public Element <T, U> {
            public :

                Onion () = default;
                ~Onion () = default;

                T const Peel () const {
                    return Element <T, U>::WrappedObject ();
                }

                T const PeelDeep () const {
                    return Element <T, U>::UnderlyingObject ();
                }

            private :
        };

        // U == void || U != void

        bool Add (Element <T, U> const & e) {
            return _set.insert (e).second;
        }

        // U != void

        template <typename V = U, typename = typename std::enable_if <!std::is_same <V, void>::value, dummy_t>::type>
        // Automatic type deduction is disabled
        bool Add (T const & t, decltype (std::declval <V const> ()) & v) {
            return Add (Element <T, V> (t,v));
        }

        // U == void or U != void

        bool Remove (Element <T, U> const & e) {
            size_t _count = _set.size ();

            auto _it = Find (e);

            if (_it != _set.end ()) {
               _it = _set.erase (_it);
            }

//            return Find (e) != _set.end ();

            // A (slightly) more efficient alternative
            return _count != _set.size ();
        }

        // U == void or U != void

        bool Remove (T const & t) {
            bool _ret = false;

            auto _it = Find (t);

            if (_it != _set.end ()) {
                _ret = Remove (*_it);
            }

            return _ret;
        }

        auto end () const -> typename decltype (_set)::const_iterator {
            return _set.end ();
        }

        auto begin () const -> typename decltype (_set)::const_iterator {
            return _set.begin ();
        }

        auto Find (Element <T, U> const & e) const -> decltype (end ()) {
            decltype (end ()) _ret = _set.end ();

            for (auto _it = _set.begin (), _end = _set.end (); _it != _end; _it++) {

                Element <T, U> const & _e = *_it;

                if (e == _e) {
                    _ret = _it;

                    break;
                }
            }

            return _ret;
        }

        auto Find (T const & t) const -> decltype (end ()) {
            decltype (end ()) _ret = _set.end ();

            for (auto  _it = _set.begin (), _end = _set.end (); _it != _end; _it++) {

                if (_it->Has (t) != true) {
                    continue;
                }
                else {
                    _ret = _it;

                    // In a proper a set only one should exist
                    break;
                }
            }

            return _ret;
        }

        size_t Size () const {
            return _set.size ();
        }

        bool Empty () const {
            return _set.empty ();
        }
};

template <typename T>
class Buffer : public Element <T> {

    using age_t = uintmax_t;

    private :

        age_t _age;

        static std::atomic < age_t > _ticks;

        uint8_t _count;

    public  :

        Buffer () = delete;

        explicit Buffer (T const & t) : Element <T> (t), _age (++_ticks), _count {0} {}

        ~Buffer () = default;

        bool operator > (Buffer const & b) const {
            return Element <T>::operator > (b);
        }

        auto Age () const -> decltype (_age) {
            return _age;
        }

#ifdef _USE_REFCOUNT
        bool Ref () {
            ++_count;

            return _count > 0;
        }

        bool UnRef () {
            --_count;

            return _count <= 1;
        }

        decltype (_count) Count () const {
            return _count;
        }
#endif
};

template <typename T>
std::atomic < typename Buffer <T>::age_t > Buffer <T>::_ticks (0);

template <typename T>
class BufferSet : public Set < Buffer <T> > {
    public :

        BufferSet () : Set < Buffer <T> > () {
            Clear ();
        }

        ~BufferSet () {
            Clear ();
        }

        BufferSet (BufferSet const & other) {
            (* this) = other;
        }

        BufferSet & operator = (BufferSet const & other) {
            Set < Buffer <T> >::operator = (other);

            return * this;
        }

        bool Add (Buffer <T> const & b) {
#ifndef _USE_REFCOUNT
            bool _ret = Set < Buffer <T> >::Add ( Element < Buffer <T> > (b));
#else
            Buffer <T> _b (b);

            // _b will be updated if it exists

            if (Has (_b) != false) {
                /* bool */ Set < Buffer <T> >::Remove (_b);
            }

            /* bool */ _b.Ref ();

            bool _ret = Set < Buffer <T> >::Add ( Element < Buffer <T> > (_b));
#endif

            return _ret;
        }

        bool Add (T const & t) {
            return Add (Buffer <T> (t));
        }

        bool Remove (Buffer <T> const & b) {
#ifndef _USE_REFCOUNT
            bool _ret = Set < Buffer <T> >::Remove (b);
#else
            Buffer <T> _b (b);

            bool _ret = Has (_b);

            /*bool */_ret =/* Has (_b) &&*/ Set < Buffer <T> >::Remove (_b);

            // _b has been updated if it exists

            /* bool */ _b.UnRef ();

            if (_b.Count () > 0) {
                // Compensate the Ref () in Add ()
                _ret = _ret && _b.UnRef() && Add (_b);
            }
#endif
            return _ret;
        }

        bool Remove (T const & t) {
           return Remove (Buffer <T> (t));
        }

        // Deliberately no Emplace

        bool Clear () {

            while (BufferSet <T>::Size () > 0) {
                auto & _e = static_cast < typename Set < Buffer <T> >::Onion const & > (* BufferSet <T>::begin () );

                auto & _b = _e.Peel ();

                bool _ret = Set < Buffer <T> >::Remove (_b);

                if (_ret != true) {
                    break;
                }
            }

            return BufferSet <T>::Empty ();
        }

        bool Has (Buffer <T> & b) const {
            auto  _it = Set < Buffer <T> >::Find (b);

            bool _ret = _it != Set < Buffer <T> >::end ();

            if (_ret != false) {
                auto & _e = static_cast <typename Set < Buffer <T> >::Onion const & > (* _it);

                auto & _b = _e.Peel ();

                b = _b;
            }

            return _ret;
        }

        Buffer <T> const & PredictedBuffer (bool elderoveryounger) const {
            using It_t = decltype ( std::declval < BufferSet <T> > ().end ());

            auto Prediction = [this] (bool elderoveryounger) -> decltype ( std::declval < BufferSet <T> > ().end ()) {

                auto Older = [] (It_t const & a, It_t const & b) -> bool {
                    auto & _ea = static_cast <typename Set < Buffer <T> >::Onion const & > (* a);
                    auto & _eb = static_cast <typename Set < Buffer <T> >::Onion const & > (* b);

                    auto & _ba = _ea.Peel ();
                    auto & _bb = _eb.Peel ();

                    return _ba.Age () < _bb.Age ();
                };

                auto Younger = [] (It_t const & a, It_t const & b) {
                    auto & _ea = static_cast <typename Set < Buffer <T> >::Onion const & > (* a);
                    auto & _eb = static_cast <typename Set < Buffer <T> >::Onion const & > (* b);

                    auto & _ba = _ea.Peel ();
                    auto & _bb = _eb.Peel ();

                    return _ba.Age () > _bb.Age ();
                };

                auto More = [] (It_t const & a, It_t const & b) {
                    auto & _ea = static_cast <typename Set < Buffer <T> >::Onion const & > (* a);
                    auto & _eb = static_cast <typename Set < Buffer <T> >::Onion const & > (* b);

                    auto & _ba = _ea.Peel ();
                    auto & _bb = _eb.Peel ();

                    return _ba.Count () > _bb.Count ();
                };

                auto Less = [] (It_t const & a, It_t const & b) {
                    auto & _ea = static_cast <typename Set < Buffer <T> >::Onion const & > (* a);
                    auto & _eb = static_cast <typename Set < Buffer <T> >::Onion const & > (* b);

                    auto & _ba = _ea.Peel ();
                    auto & _bb = _eb.Peel ();

                    return _ba.Count () < _bb.Count ();
                };

                It_t _eldest = BufferSet <T>::begin ();
                It_t _youngest = BufferSet <T>::begin ();

                for (auto _it = BufferSet <T>::begin (), _end = BufferSet <T>::end (); _it != _end; _it++) {
                    if (_eldest != _it) {
                        // Lowest count prevails in successive calls to 'gbm_surface_lock_front_buffer'
                        if (Less (_it, _eldest) != false) {
                            _eldest = _it;
                        }
                        else {
                            if (More (_it, _eldest) != true && Older (_it, _eldest) != false) {
                                _eldest = _it;
                            }
                        }

                    }

                    if (_youngest != _it) {
                        // Lowest count prevails in successive calls to 'gbm_surface_lock_front_buffer'
                        if (Less (_it, _youngest) != false) {
                            _youngest = _it;
                        }
                        else { 
                            if (More (_it, _youngest) != true && Younger (_it, _youngest) != false) {
                                _youngest = _it;
                            }
                        }
                    }
                }

                return elderoveryounger != false ? _eldest : _youngest;
            };

            auto _it = Prediction (elderoveryounger);

            auto & _e = static_cast <typename Set < Buffer <T> >::Onion const & > (* _it);

            auto & _b = _e.Peel ();

            return _b;
        }

        auto Size () const -> decltype (Set < Buffer <T> >::Size ()) {
            return Set < Buffer <T> >::Size ();
        }

    private :
};

template <typename T, typename U, typename V>
class Surface : public Element <T, U> {
    using dummy_t = uintptr_t; 

    public :

        Surface () = delete;

        // A surface with an empty BuferSet <V> has nothing to render

        template <typename A = U, typename = typename std::enable_if <std::is_same <A, void>::value, dummy_t>::type>
        explicit Surface (T const & t) : Element <T, U> (t) {}

        template <typename A = U, typename = typename std::enable_if <!std::is_same <A, void>::value, dummy_t>::type>
        explicit Surface (T const & t, A const & u) : Element <T, U> (t, u) {}

        ~Surface () = default;

        Surface & operator = (Surface const & other) {
            Element <T, U>::operator = (other);

            _set = other._set;

            return * this;
        }

        // Do not allow direct manipulation

        bool Add (Buffer <V> const & b) {
            return _set.Add (b);
        }

        bool Remove (Buffer <V> const & b) {
            return _set.Remove (b);
        }

        bool Has (Buffer <V> & b) const {
            return _set.Has (b);
        }

        bool operator > (Surface const & s) const {
            return Element <T, U>::operator > (s);
        }

    protected :

        BufferSet <V> const & Set () const {
            return _set;
        }

    private :

        BufferSet <V> _set;
};

template <typename T, typename U, typename V>
class SurfaceSet : public Set < Surface <T, U, V> > {
    public :

        SurfaceSet () : Set < Surface <T, U, V> > () {
            Clear ();
        }

        ~SurfaceSet () {
            Clear ();
        }

        SurfaceSet (SurfaceSet const &) = default;

        SurfaceSet & operator = (SurfaceSet const &) = default;

        bool Add (Surface <T, U, V> const & s) {
            return Set < Surface <T, U, V> >::Add ( Element < Surface <T, U, V> > (s) );
        }

        bool Remove (Surface <T, U, V> const & s) {
            return Set < Surface <T, U, V> >::Remove (s);
        }

        bool Emplace (Surface <T, U, V> const & s) {
// TOOD: Not a robust approach for failure

            Surface <T, U, V> _s (s);

            return Has (_s) && Remove (s) && Add (s);
        }

        // Surface may be updated
        bool Has (Surface <T, U, V> & s) const {
            auto _it = Set < Surface <T, U, V> >::Find (s);

            bool _ret = _it != Set < Surface <T, U, V> >::end ();

            if (_ret != false) {
                auto & _e = static_cast <typename Set < Surface <T, U, V> >::Onion const & > (* _it);

                auto & _s = _e.Peel ();

                s = _s;
            }

            return _ret;
        }

    protected :

        bool Clear () {
            while (SurfaceSet <T, U, V>::Size () > 0) {
                auto & _e = static_cast < typename Set < Surface <T, U, V> >::Onion const & > (* SurfaceSet <T, U, V>::begin () );

                auto & _s = _e.Peel ();

                bool _ret = Remove (_s);

                if (_ret != true) {
                    break;
                }
            }

            return SurfaceSet <T, U, V>::Empty ();
        }

    private :
};

template <typename T, typename U, typename V, typename W, typename X>
class Device : public Element <T, U> {
    using dummy_t = uintptr_t; 

    public :

        Device () = delete;

        template <typename A = U, typename = typename std::enable_if <std::is_same <A, void>::value, dummy_t>::type>
        explicit Device (T const & t) : Element <T, U> (t) {}

        template <typename A = U, typename = typename std::enable_if <!std::is_same <A, void>::value, dummy_t>::type>
        explicit Device (T const & t, A const & u) : Element <T, A> (t, u) {}

        ~Device () = default;

        Device (Device const & other) = default;

        Device & operator = (Device const & other) {
            Element <T, U>::operator = (other);

            _set = other._set;

            return * this;
        }

        // Do not allow direct manipulation

        bool Add (Surface <V, W, X> const & s) {
            return _set.Add (s);
        }

        bool Remove (Surface <V, W, X> const & s) {
            return _set.Remove (s);
        }

        bool Has (Surface <V, W, X> & s) const {
            return _set.Has (s);
        }

        bool operator > (Device const & d) const {
            return Element <T, U>::operator > (d);
        }

    protected :

        SurfaceSet <V, W, X> const & Set () const {
            return _set;
        }

    private :

        SurfaceSet <V, W, X> _set;
};

template <typename T, typename U, typename V, typename W, typename X>
class DeviceSet : public Set < Device <T, U, V, W, X> > {
    public :

        DeviceSet () : Set < Device <T, U, V, W, X> > () {
            Clear ();
        }

        ~DeviceSet () {
            Clear ();
        };

        DeviceSet (DeviceSet const &) = default;

        DeviceSet & operator = (DeviceSet const &) = default;

        bool Add (Device <T, U, V, W, X> const & d) {
            return Set < Device <T, U, V, W, X> >::Add ( Element < Device <T, U, V, W, X> > (d));
        }

        bool Remove (Device <T, U, V, W, X> const & d) {
            return Set < Device <T, U, V, W, X> >::Remove (d);
        }

        bool Emplace (Device <T, U, V, W, X> const & d) {
// TOOD: Not a robust approach with  failure

            Device <T, U, V, W, X> _d (d);

            return Has(_d) && Remove (d) && Add (d);
        }

        bool Has (Device <T, U, V, W, X> & d) const {
            auto _it = Set < Device <T, U, V, W, X> >::Find (d);

            bool _ret = _it != Set < Device <T, U, V, W, X> >::end ();

            if (_ret != false) {
                auto & _e = static_cast <typename Set < Device <T, U, V, W, X> >::Onion const & > (* _it);

                auto & _d = _e.Peel ();

                d = _d;
            }

            return _ret;
        }

    protected :

        bool Clear () {
            while (DeviceSet <T, U, V, W, X>::Size () > 0) {
                auto & _e = static_cast <typename Set < Device <T, U, V, W, X> >::Onion const & > (* DeviceSet <T, U, V, W, X>::begin () );

                auto & _d = _e.Peel ();

                bool _ret = Remove (_d);

                if (_ret != true) {
                    break;
                }
            }

           return DeviceSet <T, U, V, W, X>::Empty ();
        }

    private :
};
