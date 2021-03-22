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
*/

// https://gcc.gnu.org/projects/cxx-status.html
// https://en.cppreference.com/w/cpp/feature_test
#if __cplusplus >= 200806L || defined (__cpp_threadsafe_static_init)
#warning "Thread safe static initialization is supported"
#else
#error "Thread safe static initialization is NOT supported but is required."
#endif

#include "common.h"

#define _USE_REFCOUNT
#include "set.h"

#include <string>

// A little less code bloat
#ifndef _2CSTR
#define _2CSTR(str) std::string (str).c_str ()
#endif

#define PROXYGBM_PRIVATE COMMON_PRIVATE
#define PROXYGBM_PUBLIC COMMON_PUBLIC

#define PROXYGBM_UNUSED __attribute__ ((unused))

#include <functional>

#ifdef __cplusplus
extern "C" {
#endif
#include <gbm.h>
#ifdef __cplusplus
}
#endif

#ifdef __cplusplus
extern "C" {
#endif

PROXYGBM_PUBLIC struct gbm_bo* gbm_surface_lock_front_buffer (struct gbm_surface* surface);
PROXYGBM_PUBLIC void gbm_surface_release_buffer (struct gbm_surface* surface, struct gbm_bo* bo);
PROXYGBM_PUBLIC int gbm_surface_has_free_buffers (struct gbm_surface* surface);

PROXYGBM_PUBLIC struct gbm_surface* gbm_surface_create (struct gbm_device* gbm, uint32_t width, uint32_t height, uint32_t format, uint32_t flags);
PROXYGBM_PUBLIC struct gbm_surface* gbm_surface_create_with_modifiers (struct gbm_device* gbm, uint32_t width, uint32_t height, uint32_t format, const uint64_t* modifiers, const unsigned int count);

PROXYGBM_PUBLIC void gbm_surface_destroy (struct gbm_surface* surface);
PROXYGBM_PUBLIC void gbm_device_destroy (struct gbm_device* device);

PROXYGBM_PUBLIC struct gbm_device* gbm_create_device (int fd);

#ifdef __cplusplus
}
#endif

namespace {
// Suppress compiler preprocessor 'visibiity ignored' in anonymous namespace
#define _PROXYGBM_PRIVATE /*PROXYGBM_PRIVATE*/
#define _PROXYGBM_PUBLIC PROXYGBM_PUBLIC
#define _PROXYGBM_UNUSED PROXYGBM_UNUSED

class Platform : public Singleton <Platform> {
    using sync_t = MutexRecursive <3>; // Three levels deep locking

    using gbm_bo_t      = struct gbm_bo *;
    using gbm_surface_t = struct gbm_surface *;
    using gbm_device_t  = struct gbm_device *;

    // This (These) friend(s) has (have) access to all members!
    friend Singleton <Platform>;

    public :

        _PROXYGBM_PRIVATE static constexpr gbm_device_t gbm_device_t_DEFAULT () {
            return nullptr;
        }

        _PROXYGBM_PRIVATE static constexpr gbm_surface_t gbm_surface_t_DEFAULT () {
            return nullptr;
        }

        _PROXYGBM_PRIVATE static constexpr gbm_bo_t gbm_bo_t_DEFAULT () {
            return nullptr;
        }

        _PROXYGBM_PRIVATE bool Add (gbm_surface_t const & surface, gbm_bo_t const & bo);
        _PROXYGBM_PRIVATE bool Add (gbm_device_t const & device, gbm_surface_t const & surface);

        _PROXYGBM_PRIVATE bool Remove (gbm_surface_t const & surface, gbm_bo_t const bo = gbm_bo_t_DEFAULT ());
        _PROXYGBM_PRIVATE bool Remove (gbm_device_t const & device, gbm_surface_t const surface = gbm_surface_t_DEFAULT ());

        // 'Educated' guess of the (next) buffer
        gbm_bo_t PredictedBuffer (gbm_surface_t const & surface) const;

        _PROXYGBM_PRIVATE bool Exist (gbm_device_t const & device) const;
        _PROXYGBM_PRIVATE bool Exist (gbm_surface_t const & surface) const;

        _PROXYGBM_PRIVATE static constexpr sync_t& SyncObject () {
            return _syncobject;
        }

    protected :

    // Nothing

    private:

        class BufferOnion : public Buffer <gbm_bo_t> {
            public :

                BufferOnion () = delete;

                ~BufferOnion () = default;

                BufferOnion (BufferOnion const &) = default;

                BufferOnion (BufferOnion &&) = delete;

                BufferOnion & operator = (BufferOnion const &) = default;

                BufferOnion & operator = (BufferOnion &&) = delete;

                gbm_bo_t Type () const {
                    return reinterpret_cast <gbm_bo_t> (Buffer <gbm_bo_t>::WrappedObject ());
                }

                bool List () const {
                    LOG (_2CSTR ("          |--> with (native) buffer: "), Type () );

                    return true;
                }
        };

        class BufferSetOnion : public BufferSet <gbm_bo_t> {
            public :

                BufferSetOnion () = delete;

                ~BufferSetOnion () = default;

                BufferSetOnion (BufferSetOnion const &) = default;

                BufferSetOnion (BufferSetOnion &&) = delete;

                BufferSetOnion & operator = (BufferSetOnion const &) = default;

                BufferSetOnion & operator = (BufferSetOnion &&) = delete;

                bool List () const {
                    bool _ret = false;

                    for (auto _it = begin (), _end = end (); _it != _end; _it++) {
                        auto _e = static_cast <typename Set < Buffer <gbm_bo_t> >::Onion const & > (*_it);

                        auto _b = _e.Peel ();

                        BufferOnion const & _bo = static_cast <BufferOnion const &> (_b);

                        _ret = _bo.List ();

                        if (_ret != false) {
                            break;
                        }
                    }

                    return _ret;
                }
        };

        class SurfaceOnion : public Surface <gbm_surface_t, void, gbm_bo_t> {
            public :

                SurfaceOnion () = delete;

                ~SurfaceOnion () = default;

                SurfaceOnion (SurfaceOnion const &) = default;

                SurfaceOnion (SurfaceOnion &&) = delete;

                SurfaceOnion & operator = (SurfaceOnion const &) = default;

                SurfaceOnion & operator = (SurfaceOnion &&) = delete;

                BufferSet <gbm_bo_t> const &  Set () const {
                    auto _set = Surface <gbm_surface_t, void, gbm_bo_t>::Set ();
                    return Surface <gbm_surface_t, void, gbm_bo_t>::Set ();
                }

                bool List () const {
                    LOG (_2CSTR ("     |--> with (native) surface entry: "), reinterpret_cast <gbm_surface_t> ( Surface <gbm_surface_t, void, gbm_bo_t>::WrappedObject () ));

                    BufferSetOnion const & _b = static_cast <BufferSetOnion const & > (Set ());

                    bool _ret = true;;

                    if (_b.Size () > 0) {
                        _ret = _b.List ();;
                    }
                    else {
                        LOG (_2CSTR ("          |--> with NO (native) buffer"));
                    }

                    return _ret;
                }
        };

        class SurfaceSetOnion : public SurfaceSet <gbm_surface_t, void, gbm_bo_t> {
            public :

                SurfaceSetOnion () = delete;

                ~SurfaceSetOnion () = default;

                SurfaceSetOnion (SurfaceSetOnion const &) = default;

                SurfaceSetOnion (SurfaceSetOnion &&) = delete;

                SurfaceSetOnion & operator = (SurfaceSetOnion const &) = default;

                SurfaceSetOnion & operator = (SurfaceSetOnion &&) = delete;

                auto Size () const -> decltype ( SurfaceSet <gbm_surface_t, void, gbm_bo_t>::Size () ) {
                    return SurfaceSet <gbm_surface_t, void, gbm_bo_t>::Size ();
                }

                bool List () const {
                    bool _ret = false;

                    for (auto _it = begin (), _end = end (); _it != _end; _it++) {
                        auto _e = static_cast <typename Set < Surface <gbm_surface_t, void, gbm_bo_t> >::Onion const & > (* _it);

                        auto _s = _e.Peel ();

                        SurfaceOnion const & _so = static_cast <SurfaceOnion const &> (_s);

                        _ret = _so.List ();

                        if (_ret != false) {
                            break;
                        }
                    }

                    return _ret;
                }
        };

        class DeviceOnion : public Device <gbm_device_t, void, gbm_surface_t, void, gbm_bo_t> {
            public :

                DeviceOnion () = delete;

                ~DeviceOnion () = default;

                DeviceOnion (DeviceOnion const &) = default;

                DeviceOnion (DeviceOnion &&) = delete;

                DeviceOnion & operator = (DeviceOnion const &) = default;

                DeviceOnion & operator = (DeviceOnion &&) = delete;

                bool List () const {
                    LOG (_2CSTR ("Warning: remaining (native) device entry: "), reinterpret_cast <gbm_device_t> ( Device <gbm_device_t, void, gbm_surface_t, void, gbm_bo_t>::WrappedObject () ));

                    SurfaceSetOnion const & _s = static_cast <SurfaceSetOnion const & > (Set ());

                    bool _ret = true;;

                    if (_s.Size () > 0) {
                        _ret =  _s.List ();
                    }
                    else {
                        LOG (_2CSTR ("     |--> with NO (native) surface"));
                    }

                    return _ret;
                }
        };


        class DeviceSetOnion : public DeviceSet <gbm_device_t, void, gbm_surface_t, void, gbm_bo_t> {
            public :

                DeviceSetOnion () = delete;

                ~DeviceSetOnion () = default;

                DeviceSetOnion (DeviceSetOnion const &) = default;

                DeviceSetOnion (DeviceSetOnion &&) = delete;

                DeviceSetOnion & operator = (DeviceSetOnion const &) = default;

                DeviceSetOnion & operator = (DeviceSetOnion &&) = delete;

                bool Has (Device <gbm_device_t, void, gbm_surface_t, void, gbm_bo_t> & device, Surface <gbm_surface_t, void, gbm_bo_t> const & surface) const {
                    bool _ret = false;

                    Surface <gbm_surface_t, void, gbm_bo_t> _surface (surface);

                    for (auto _it = begin (), _end = end (); _it != _end; _it++) {
                        auto _e = static_cast <typename Set < Device <gbm_device_t, void, gbm_surface_t, void, gbm_bo_t> >::Onion const & > (* _it);

                        auto _d = _e.Peel ();

                       _ret = _d.Has (_surface);

                       if (_ret != false) {
                            device = _d;

                            break;
                       }
                    };

                    return _ret;
                }

                bool List () const {
                    bool _ret = false;

                    for (auto _it = begin (), _end = end (); _it != _end; _it++) {
                        auto _e = static_cast <typename Set < Device <gbm_device_t, void, gbm_surface_t, void, gbm_bo_t> >::Onion const & > (* _it);

                        auto _d = _e.Peel ();

                        DeviceOnion const & _do = static_cast <DeviceOnion const &> (_d);

                       _ret = _do.List ();

                       if (_ret != false) {
                           break;
                       }
                    }

                    return _ret;
                }
        };

    private :

        _PROXYGBM_PRIVATE static sync_t _syncobject;

        DeviceSet <gbm_device_t, void, gbm_surface_t, void, gbm_bo_t> _set;

        Platform () = default;

        virtual ~Platform () {
            DeviceSetOnion const & _s = static_cast <DeviceSetOnion const &> (_set);

            _s.List ();
        }
};

/*_PROXYGBM_PRIVATE*/ Platform::sync_t Platform::_syncobject;

Platform::gbm_bo_t Platform::PredictedBuffer (gbm_surface_t const & surface) const {
    std::lock_guard < decltype (Platform::_syncobject) > _lock (_syncobject);

    DeviceSetOnion const & _dso = static_cast <DeviceSetOnion const &> (_set);

    Device <gbm_device_t, void, gbm_surface_t, void, gbm_bo_t> _device (gbm_device_t_DEFAULT () /* act as dummy */);

    Surface <gbm_surface_t, void, gbm_bo_t> _surface (surface);

    gbm_bo_t _ret = gbm_bo_t_DEFAULT ();

    if (_dso.Has (_device, _surface) != false && _device.Has (_surface) != false) {

        // _device has been updated if it exists, likewise _surface

        SurfaceOnion const & _so = static_cast <SurfaceOnion const &> (_surface);

        auto & _bset = _so.Set ();

        // Nothing to predict from an empty set

        if (_bset.Size () > 0) {
            Buffer <gbm_bo_t> const & _buffer = _bset.PredictedBuffer (false);

            BufferOnion const & _bo = static_cast <BufferOnion const &> (_buffer);

            _ret = _bo.Type ();
        }
    }

    return _ret;
}

bool Platform::Add (gbm_surface_t const & surface, gbm_bo_t const & bo) {
    std::lock_guard < decltype (Platform::_syncobject) > _lock (_syncobject);

    DeviceSetOnion const & _dso = static_cast <DeviceSetOnion const &> (_set);

    Device <gbm_device_t, void, gbm_surface_t, void, gbm_bo_t> _device (gbm_device_t_DEFAULT () /* act as dummy */);

    Surface <gbm_surface_t, void, gbm_bo_t> _surface (surface);

    bool _ret = _dso.Has (_device, _surface);

    // _device has been updated if it exists, but _surface has not

    // Allowed to fail
    /* bool */ _device.Has (_surface);

    // _surface has been updated if it exists

    if (bo != gbm_bo_t_DEFAULT ()) {
        Buffer <gbm_bo_t> _buffer (bo);

        _ret = _ret && _surface.Add (_buffer);
    }

    // Allowed to fail
    /* bool */ _device.Remove (_surface);

    _ret = _ret && _device.Add (_surface) && _set.Emplace (_device);

    assert (_ret != false);

    return _ret;
}

bool Platform::Remove (gbm_surface_t const & surface, gbm_bo_t bo) {
    std::lock_guard < decltype (Platform::_syncobject) > _lock (_syncobject);

    DeviceSetOnion const & _dso = static_cast <DeviceSetOnion const &> (_set);

    Device <gbm_device_t, void, gbm_surface_t, void, gbm_bo_t> _device (gbm_device_t_DEFAULT () /* act as dummy */);

    Surface <gbm_surface_t, void, gbm_bo_t> _surface (surface);

    bool _ret = _dso.Has (_device, _surface) && _device.Has (_surface) && _device.Remove (_surface);

    // _device has been updated if it exists, likewise _surface

    if (bo != gbm_bo_t_DEFAULT ()) {
        Buffer <gbm_bo_t> _buffer (bo);

        _ret = _ret && _surface.Remove (_buffer) && _device.Add (_surface);
    }

    _ret = _ret && _set.Emplace (_device);

    assert (_ret != false);

    return _ret;
}

bool Platform::Add (gbm_device_t const & device, gbm_surface_t const & surface) {
    std::lock_guard < decltype (Platform::_syncobject) > _lock (_syncobject);

    Device <gbm_device_t, void, gbm_surface_t, void, gbm_bo_t> _device (device);

    bool _ret = false;

    // Allowed to fail
    /* bool */ _set.Has (_device);

    // _device has been updated if it exists

    if (surface != gbm_surface_t_DEFAULT ()) {
        Surface <gbm_surface_t, void, gbm_bo_t> _surface (surface);

        _ret = _device.Add (_surface) && _set.Emplace (_device);
    }
    else {
        _ret = _set.Add (_device);
    }

    assert (_ret != false);

    return _ret;
}

bool Platform::Remove (gbm_device_t const & device, gbm_surface_t surface) {
    std::lock_guard < decltype (Platform::_syncobject) > _lock (_syncobject);

    Device <gbm_device_t, void, gbm_surface_t, void, gbm_bo_t> _device (device);

    // Here DeviceSetOnion is not really required
    bool _ret = _set.Has (_device);

    // _device has been updated if it exists

    if (surface != gbm_surface_t_DEFAULT ()) {
        Surface <gbm_surface_t, void, gbm_bo_t> _surface (surface);

        _ret = _ret && _device.Remove (_surface) && _set.Emplace (_device);
    }
    else {
        _ret = _ret && _set.Remove (_device);
    }

    assert (_ret != false);

    return _ret;
}

bool Platform::Exist (gbm_surface_t const & surface) const {
    std::lock_guard < decltype (Platform::_syncobject) > _lock (_syncobject);

    DeviceSetOnion const & _dso = static_cast <DeviceSetOnion const &> (_set);

    Device <gbm_device_t, void, gbm_surface_t, void, gbm_bo_t> _device (gbm_device_t_DEFAULT () /* act as dummy */);

    Surface <gbm_surface_t, void, gbm_bo_t> _surface (surface);

    return _dso.Has (_device, _surface);
}

bool Platform::Exist (gbm_device_t const & device) const {
    std::lock_guard < decltype (Platform::_syncobject) > _lock (_syncobject);

    Device <gbm_device_t, void, gbm_surface_t, void, gbm_bo_t> _device (device);

    return _set.Has (_device);
}

#undef _PROXYGBM_PRIVATE
#undef _PROXYGBM_PUBLIC
#undef _PROXYGBM_UNUSED
} // Anonymous namespace

struct gbm_bo* gbm_surface_lock_front_buffer (struct gbm_surface* surface) {
    static struct gbm_bo* (*_gbm_surface_lock_front_buffer) (struct gbm_surface*) = nullptr;

    static bool resolved = lookup ("gbm_surface_lock_front_buffer", reinterpret_cast <uintptr_t&> (_gbm_surface_lock_front_buffer));

    struct gbm_bo* bo = Platform::gbm_bo_t_DEFAULT ();

    if (resolved != false) {
        std::lock_guard < decltype (Platform::Instance ().SyncObject ()) > _lock (Platform::Instance ().SyncObject ());

        bool _flag = false;

        if (surface != Platform::gbm_surface_t_DEFAULT ()) {
            _flag = gbm_surface_has_free_buffers (surface) > 0;

            LOG (_2CSTR ("Calling Real gbm_surface_lock_front_buffer"));

            // This might trigger an internal error
            bo = _gbm_surface_lock_front_buffer (surface);
        }
        else {
            // Error
            assert (false);
        }

        if (bo == Platform::gbm_bo_t_DEFAULT ()) {
            // gbm_surface_lock_front_buffer (also) fails if eglSwapBuffers has not been called (yet)

            if (_flag != false) {
                bo = Platform::Instance ().PredictedBuffer (surface);

                // Existing bo's can be updated by increasing the count
                if (Platform::Instance (). Add (surface, bo) != true) {
                    LOG (_2CSTR ("Unable to update existing bo"));
                }
            }
            else {
                // Error indicative for no free buffers, just hand over the result
            }
        }
        else {
            // A successful gbm_surface_lock_front_buffer

            if (Platform::Instance (). Add (surface, bo) != true) {
                // Unable to track or other error

                /* void */ gbm_surface_release_buffer (surface, bo);

                bo = Platform::gbm_bo_t_DEFAULT ();

                assert (false);
            }
            else {
                // Just hand over the created bo
            }
        }
    }
    else {
        LOG (_2CSTR ("Real gbm_surface_lock_front_buffer not found"));
        assert (false);
    }

    return bo;
}

void gbm_surface_release_buffer (struct gbm_surface* surface, struct gbm_bo* bo) {
    static void (*_gbm_surface_release_buffer) (struct gbm_surface*, struct gbm_bo*) = nullptr;

    static bool resolved = lookup ("gbm_surface_release_buffer", reinterpret_cast <uintptr_t&> (_gbm_surface_release_buffer));

    if (resolved != false) {
        std::lock_guard < decltype (Platform::Instance ().SyncObject ()) > _lock (Platform::Instance ().SyncObject ());

        if (Platform::Instance (). Remove (surface, bo) != true) {
#ifdef _NO_RESTART_APPLICATION
            // Error, probably, unknown surface, no known previous locked buffers or other error
            assert (false);
#endif
        }
        else {
            // Expected
        }

        // Avoid any segfault
        if (bo != Platform::gbm_bo_t_DEFAULT ()) {
            LOG (_2CSTR ("Calling Real gbm_surface_release_buffer"));

            // Always release even an untracked surface
            /* void */ _gbm_surface_release_buffer (surface, bo);
        }
        else {
            // Error
            assert (false);
        }
    }
    else {
        LOG (_2CSTR ("Real gbm_surface_release_buffer not found"));
        assert (false);
    }
}

int gbm_surface_has_free_buffers(struct gbm_surface* surface) {
    static int (*_gbm_surface_has_free_buffers) (struct gbm_surface*) = nullptr;

    static bool resolved = lookup ("gbm_surface_has_free_buffers", reinterpret_cast <uintptr_t&> (_gbm_surface_has_free_buffers));

    // GBM uses only values 0 and 1; the latter indicates free buffers are available
    int ret = 0;

    if (resolved != false) {
        std::lock_guard < decltype (Platform::Instance ().SyncObject ()) > _lock (Platform::Instance ().SyncObject ());

        LOG (_2CSTR ("Calling Real gbm_surface_has_buffers"));

        ret = _gbm_surface_has_free_buffers (surface);
    }
    else {
        LOG (_2CSTR ("Real gbm_surface_has_free_buffers not found"));
        assert (false);
    }

    return ret;
}

struct gbm_surface* gbm_surface_create (struct gbm_device* gbm, uint32_t width, uint32_t height, uint32_t format, uint32_t flags) {
    static struct gbm_surface* (*_gbm_surface_create) (struct gbm_device*, uint32_t, uint32_t, uint32_t, uint32_t) = nullptr;

    static bool resolved = lookup ("gbm_surface_create", reinterpret_cast <uintptr_t&> (_gbm_surface_create));

    struct gbm_surface* ret = Platform::gbm_surface_t_DEFAULT ();

    if (resolved != false) {
        std::lock_guard < decltype (Platform::Instance ().SyncObject ()) > _lock (Platform::Instance ().SyncObject ());

        LOG (_2CSTR ("Calling Real gbm_surface_create"));

        ret = _gbm_surface_create (gbm, width, height, format, flags);

        // The surface should not yet exist
        if (Platform::Instance ().Exist (ret) != false && Platform::Instance ().Remove (ret) != false) {
            assert (false);
        }

        if (Platform::Instance ().Add (gbm, ret) != true) {
            /* void */ gbm_surface_destroy (ret);

            ret = Platform::gbm_surface_t_DEFAULT ();

            assert (false);
        }
        else {
            // Just hand over the created surface (pointer)
        }
    }
    else {
        LOG (_2CSTR ("Real gbm_surface_create not found"));
        assert (false);
    }

    return ret;
}

struct gbm_surface* gbm_surface_create_with_modifiers (struct gbm_device* gbm, uint32_t width, uint32_t height, uint32_t format, const uint64_t* modifiers, const unsigned int count) {
    static struct gbm_surface* (*_gbm_surface_create_with_modifiers) (struct gbm_device*, uint32_t, uint32_t, uint32_t, const uint64_t*, const unsigned int) = nullptr;

    static bool resolved = lookup ("gbm_surface_create_with_modifiers", reinterpret_cast <uintptr_t&> (_gbm_surface_create_with_modifiers));

    // GBM uses only values 0 and 1; the latter indicates free buffers are available
    struct gbm_surface* ret = Platform::gbm_surface_t_DEFAULT ();

    if (resolved != false) {
        std::lock_guard < decltype (Platform::Instance ().SyncObject ()) > _lock (Platform::Instance ().SyncObject ());

        LOG (_2CSTR ("Calling Real gbm_surface_create_with_modifiers"));

        ret = _gbm_surface_create_with_modifiers (gbm, width, height, format, modifiers, count);

        // The surface should not yet exist
        if (Platform::Instance ().Exist (ret) != false && Platform::Instance ().Remove (ret)) {
            assert (false);
        }

        if (Platform::Instance ().Add (gbm, ret) != true) {
            /* void */ gbm_surface_destroy (ret);

            ret = Platform::gbm_surface_t_DEFAULT ();

            assert (false);
        }
        else {
            // Just hand over the created gbm_surface
        }
    }
    else {
        LOG (_2CSTR ("Real gbm_surface_create_with_modifiers"));
        assert (false);
    }

    return ret;
}

void gbm_surface_destroy (struct gbm_surface* surface) {
    static void (*_gbm_surface_destroy) (struct gbm_surface*) = nullptr;

    static bool resolved = lookup ("gbm_surface_destroy", reinterpret_cast <uintptr_t&> (_gbm_surface_destroy));

    if (resolved != false) {
        std::lock_guard < decltype (Platform::Instance ().SyncObject ()) > _lock (Platform::Instance ().SyncObject ());

        // Remove all references
        if (Platform::Instance ().Remove (surface, nullptr) != false) {
            LOG (_2CSTR ("Calling Real gbm_surface_destroy"));
            /*void*/ _gbm_surface_destroy (surface);
        }
        else {
            // Error
            assert (false);
        }
    }
    else {
        LOG (_2CSTR ("Real gbm_surface_destroy not found"));
        assert (false);
    }
}

void gbm_device_destroy (struct gbm_device* device) {
    static void (*_gbm_device_destroy) (struct gbm_device*) = nullptr;

    static bool resolved = lookup ("gbm_device_destroy", reinterpret_cast <uintptr_t&> (_gbm_device_destroy));

    if (resolved != false) {
        std::lock_guard < decltype (Platform::Instance ().SyncObject ()) > _lock (Platform::Instance ().SyncObject ());

        // Remove all references
        if (Platform::Instance ().Remove (device, nullptr) != false) {
            LOG (_2CSTR ("Calling Real gbm_device_destroy"));
            /* void */ _gbm_device_destroy (device);
        }
        else {
            // Error
            assert (false);
        }
    }
    else {
        LOG (_2CSTR ("Real gbm_device_destroy not found"));
        assert (false);
    }
}

struct gbm_device* gbm_create_device (int fd) {
    static struct gbm_device* (*_gbm_create_device) (int) = nullptr;

    static bool resolved = lookup ("gbm_create_device", reinterpret_cast <uintptr_t&> (_gbm_create_device));

    struct gbm_device* ret = Platform::gbm_device_t_DEFAULT ();

    if (resolved != false) {
        std::lock_guard < decltype (Platform::Instance ().SyncObject ()) > _lock (Platform::Instance ().SyncObject ());

        LOG (_2CSTR ("Calling Real gbm_create_device"));

        ret = _gbm_create_device (fd);

        // The device should not yet exist
        if (Platform::Instance ().Exist (ret) != false && Platform::Instance ().Remove (ret)) {
            assert (false);
        }

        if (Platform::Instance ().Add (ret, nullptr) != true) {
            /* void */ gbm_device_destroy (ret);

            ret = Platform::gbm_device_t_DEFAULT ();

            assert (false);
        }
        else {
            // Just hand over the created device (pointer)
        }
    }
    else {
        LOG (_2CSTR ("Real gbm_create_device not found"));
        assert (false);
    }

    return ret;
}
