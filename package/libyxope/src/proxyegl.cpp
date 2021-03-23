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
#include "set.h"

#include <string>

// A little less code bloat
#ifndef _2CSTR
#define _2CSTR(str) std::string (str).c_str ()
#endif

#define PROXYEGL_PRIVATE COMMON_PRIVATE
#define PROXYEGL_PUBLIC COMMON_PUBLIC

#include <limits>
#include <vector>
#include <array>
#include <cstring>
#include <atomic>

// Our implementation
#include "queue.h"

#include <tuple>

#ifdef __cplusplus
extern "C" {
#endif

// This order matters!
#include <gbm.h>
#include <xf86drm.h>
#include <xf86drmMode.h>
#include <drm_fourcc.h>
#include <EGL/egl.h>
#include <EGL/eglext.h>

#ifndef EGL_PLATFORM_GBM_KHR
#define EGL_PLATFORM_GBM_KHR 0x31D7
#endif

#ifndef EGL_PLATFORM_GBM_MESA
#define EGL_PLATFORM_GBM_KHR

#ifndef EGL_VERSION_1_5
#warning "EGL version 1.5 or EGL version 1.4 with extension support is preferred."
typedef intptr_t EGLAttrib;
#endif
#endif

#include <signal.h>

#ifndef _POSIX_SOURCE
#define _POSIX_SOURCE
#endif
#include <setjmp.h>
#include <sys/select.h>
#undef _POSIX_SOURCE

#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#include <dlfcn.h>
#undef _GNU_SOURCE

#ifdef _MESADEBUG
#include <unistd.h>
#include <sys/syscall.h>
#endif

#ifdef __cplusplus
}
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define PROXYEGL_PRIVATE COMMON_PRIVATE
#define PROXYEGL_PUBLIC COMMON_PUBLIC

// EGL 1.4 / 1.5 extension support
PROXYEGL_PUBLIC __eglMustCastToProperFunctionPointerType eglGetProcAddress (const char*);
PROXYEGL_PUBLIC EGLDisplay eglGetPlatformDisplayEXT (EGLenum, void*, const EGLAttrib*);
PROXYEGL_PUBLIC EGLSurface eglCreatePlatformWindowSurfaceEXT (EGLDisplay, EGLConfig, void*, const EGLAttrib*);

// EGL 1.4 support
PROXYEGL_PUBLIC EGLDisplay eglGetDisplay (EGLNativeDisplayType);
PROXYEGL_PUBLIC EGLBoolean eglTerminate (EGLDisplay);

PROXYEGL_PUBLIC EGLBoolean eglChooseConfig (EGLDisplay, const EGLint*, EGLConfig*, EGLint, EGLint*);

PROXYEGL_PUBLIC EGLSurface eglCreateWindowSurface (EGLDisplay, EGLConfig, EGLNativeWindowType, const EGLint*);
PROXYEGL_PUBLIC EGLBoolean eglDestroySurface (EGLDisplay, EGLSurface);

PROXYEGL_PUBLIC EGLBoolean eglSwapBuffers (EGLDisplay, EGLSurface);

#ifdef _MESADEBUG
PROXYEGL_PUBLIC EGLContext eglCreateContext (EGLDisplay, EGLConfig, EGLContext, const EGLint*);
PROXYEGL_PUBLIC EGLBoolean eglDestroyContext (EGLDisplay, EGLContext);

PROXYEGL_PUBLIC EGLSurface eglCreatePbufferSurface (EGLDisplay, EGLConfig, const EGLint*);

PROXYEGL_PUBLIC EGLBoolean eglMakeCurrent (EGLDisplay, EGLSurface, EGLSurface, EGLContext);
#endif

// EGL 1.5 support
PROXYEGL_PUBLIC EGLDisplay eglGetPlatformDisplay (EGLenum, void*, const EGLAttrib*);
PROXYEGL_PUBLIC EGLSurface eglCreatePlatformWindowSurface (EGLDisplay, EGLConfig, void*, const EGLAttrib*);

#ifdef __cplusplus
}
#endif

namespace {
// Suppress compiler preprocessor 'visibiity ignored' in anonymous namespace
#define _PROXYEGL_PRIVATE /*PROXYEGL_PRIVATE*/
#define _PROXYEGL_PUBLIC PROXYEGL_PUBLIC

class Platform : public Singleton <Platform> {
        using sync_t = MutexRecursive <2>; // Two levels deep locking

        using gbm_bo_t      = struct gbm_bo*;
        using gbm_surface_t = struct gbm_surface*;
        using gbm_device_t  = struct gbm_device*;
 
        // This friend has access to all members!
        friend Singleton <Platform>;

    private :

        class Queue;

    public :

        _PROXYEGL_PRIVATE static constexpr gbm_device_t gbm_device_t_DEFAULT () {
            return nullptr;
        }

        _PROXYEGL_PRIVATE static constexpr gbm_surface_t gbm_surface_t_DEFAULT () {
            return nullptr;
        }

        _PROXYEGL_PRIVATE static constexpr gbm_bo_t gbm_bo_t_DEFAULT () {
            return nullptr;
        }

        // Not all EGL platforms use underlying pointers for these types, code might require (future) changes / adaptations
        static_assert (std::is_pointer <EGLDisplay>::value != false);
        static_assert (std::is_pointer <EGLSurface>::value != false);
        static_assert (std::is_pointer <EGLNativeDisplayType>::value != false);
        static_assert (std::is_pointer <EGLNativeWindowType>::value != false);

        _PROXYEGL_PRIVATE static constexpr EGLSurface EGLSurface_DEFAULT () {
            return EGL_NO_SURFACE;
        }

        _PROXYEGL_PRIVATE static constexpr EGLDisplay EGLDisplay_DEFAULT () {
            return EGL_NO_DISPLAY;
        }

        _PROXYEGL_PRIVATE static constexpr EGLNativeWindowType EGLNativeWindowType_DEFAULT () {
            return nullptr;
        }

        _PROXYEGL_PRIVATE static constexpr EGLNativeDisplayType EGLNativeDisplayType_DEFAULT () {
            return nullptr;
        }

        _PROXYEGL_PRIVATE bool isGBMdevice (EGLNativeDisplayType const & display) const;
        _PROXYEGL_PRIVATE bool isGBMsurface (EGLNativeWindowType const & window) const;

        _PROXYEGL_PRIVATE void FilterConfigs (EGLDisplay const & display, std::vector <EGLConfig> & configs) const;

        _PROXYEGL_PRIVATE bool Add (EGLDisplay const & display, EGLNativeDisplayType const & native);
        _PROXYEGL_PRIVATE bool Add (EGLDisplay const & display, EGLSurface const & surface, EGLNativeWindowType const & native);

        _PROXYEGL_PRIVATE bool Remove (EGLDisplay const & display, EGLSurface const & surface);

        _PROXYEGL_PRIVATE bool ScanOut (EGLSurface const & surface) const;

        // Expected runtime dependencies and their names
        // Also see helpers
        _PROXYEGL_PRIVATE static constexpr const char* libGBMname () {
            return "libgbm.so";
        }

        _PROXYEGL_PRIVATE static constexpr const char* libDRMname () {
            return "libdrm.so";
        }

        _PROXYEGL_PRIVATE static constexpr sync_t& SyncObject () {
            return _syncobject;
        }

    protected :

        // Nothing

    private :

        _PROXYEGL_PRIVATE bool Add (EGLSurface const & surface, EGLNativeWindowType const & native);
        _PROXYEGL_PRIVATE bool Remove (EGLSurface const & surface);

        class SurfaceOnion : public Surface <EGLSurface, EGLNativeWindowType, gbm_bo_t> {
            public :

                SurfaceOnion () = delete;

                ~SurfaceOnion () = default;

                SurfaceOnion (SurfaceOnion const &) = default;

                SurfaceOnion (SurfaceOnion &&) = delete;

                SurfaceOnion & operator = (SurfaceOnion const &) = default;

                SurfaceOnion & operator = (SurfaceOnion &&) = delete;

                static_assert (std::is_same <gbm_surface_t, EGLNativeWindowType>::value || (std::is_pointer <gbm_surface_t>::value && std::is_pointer <EGLNativeWindowType>::value));

                EGLSurface const EGLType () const {
                    return reinterpret_cast <EGLSurface> ( Surface <EGLSurface, EGLNativeWindowType, gbm_bo_t>::WrappedObject () );
                }

                EGLNativeWindowType const NativeType () const {
                    return reinterpret_cast <EGLNativeWindowType> ( Surface <EGLSurface, EGLNativeWindowType, gbm_bo_t>::UnderlyingObject () );
                }

                bool HasNative (Surface <EGLSurface, EGLNativeWindowType, gbm_bo_t> const & surface) const {
                    SurfaceOnion const & _onion = static_cast <SurfaceOnion const &> (surface);

                    return _onion.NativeType () == NativeType ();
                }

                bool List () const {
                    LOG (_2CSTR ("     |--> with (EGL) surface entry: "), EGLType ());
                    LOG (_2CSTR ("          |--> with EGLNativeWindowType: "), NativeType ());

                    return true;
                }
        };

        class SurfaceSetOnion : public SurfaceSet <EGLSurface, EGLNativeWindowType, gbm_bo_t> {
            public :

                SurfaceSetOnion () = delete;

                ~SurfaceSetOnion () = default;

                SurfaceSetOnion (SurfaceSetOnion const &) = default;

                SurfaceSetOnion (SurfaceSetOnion &&) = delete;

                SurfaceSetOnion & operator = (SurfaceSetOnion const &) = default;

                SurfaceSetOnion & operator = (SurfaceSetOnion &&) = delete;

                bool HasNative (Surface <EGLSurface, EGLNativeWindowType, gbm_bo_t> const & surface) const {
                    bool _ret = false;

                    for (auto _it = begin (), _end = end (); _it != _end; _it++) {
                        auto _e = static_cast <typename Set < Surface <EGLSurface, EGLNativeWindowType, gbm_bo_t> >::Onion const & > (* _it);

                        auto _s = _e.Peel ();

                        SurfaceOnion const & _onion = static_cast <SurfaceOnion const &> (_s);

                       _ret = _onion.HasNative (surface);

                       if (_ret != false) {
                           break;
                       }
                    };

                    return _ret;
                }

                auto Size () const -> decltype ( SurfaceSet <EGLSurface, EGLNativeWindowType, gbm_bo_t>::Size() ) {
                    return SurfaceSet <EGLSurface, EGLNativeWindowType, gbm_bo_t>::Size ();
                }

                bool List () const {
                    bool _ret = false;

                    for (auto _it = begin (), _end = end (); _it != _end; _it++) {
                        auto _e = static_cast <typename Set < Surface <EGLSurface, EGLNativeWindowType, gbm_bo_t> >::Onion const & > (*_it);

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

        class DeviceOnion : public Device <EGLDisplay, EGLNativeDisplayType, EGLSurface, EGLNativeWindowType, gbm_bo_t> {
            public :

                DeviceOnion () = delete;

                ~DeviceOnion () = default;

                DeviceOnion (DeviceOnion const &) = default;

                DeviceOnion (DeviceOnion &&) = delete;

                DeviceOnion & operator = (DeviceOnion const &) = default;

                DeviceOnion & operator = (DeviceOnion &&) = delete;

                static_assert (std::is_same <gbm_surface_t, EGLNativeWindowType>::value || (std::is_pointer <gbm_surface_t>::value && std::is_pointer <EGLNativeWindowType>::value));

                EGLDisplay const EGLType () const {
                    return reinterpret_cast <EGLDisplay> ( Device <EGLDisplay, EGLNativeDisplayType, EGLSurface, EGLNativeWindowType, gbm_bo_t>::WrappedObject () );
                }

                EGLNativeDisplayType const NativeType () const {
                    return reinterpret_cast <EGLNativeDisplayType> ( Device <EGLDisplay, EGLNativeDisplayType, EGLSurface, EGLNativeWindowType, gbm_bo_t>::UnderlyingObject () );
                }

                bool HasNative (Surface <EGLSurface, EGLNativeWindowType, gbm_bo_t> const & surface) const {
                    bool _ret = false;

                        SurfaceSetOnion const & _s = static_cast <SurfaceSetOnion const & > (Set ());

                       _ret = _s.HasNative (surface);

                    return _ret;
                }

                bool List () const {
                    LOG (_2CSTR ("Warning: remaining (EGL) display entry: "), EGLType ());
                    LOG (_2CSTR ("     |--> with EGLNativeDisplayType: "), NativeType ());

                    SurfaceSetOnion const & _s = static_cast <SurfaceSetOnion const & > (Set ());

                    bool _ret = true;

                    if (_s.Size () > 0) {
                        _ret = _s.List ();
                    }
                    else {
                        LOG (_2CSTR ("     |--> with NO (EGL) surface"));
                    }

                    return _ret;
                }
        };

        class DeviceSetOnion : public DeviceSet <EGLDisplay, EGLNativeDisplayType, EGLSurface, EGLNativeWindowType, gbm_bo_t> {
            public :

                DeviceSetOnion () = delete;

                ~DeviceSetOnion () = default;

                DeviceSetOnion (DeviceSetOnion const &) = default;

                DeviceSetOnion (DeviceSetOnion &&) = delete;

                DeviceSetOnion & operator = (DeviceSetOnion const &) = default;

                DeviceSetOnion & operator = (DeviceSetOnion &&) = delete;

                bool Has (Surface <EGLSurface, EGLNativeWindowType, gbm_bo_t> & surface) const {
                    bool _ret = false;

                    for (auto _it = begin (), _end = end (); _it != _end; _it++) {
                        auto _e = static_cast <typename Set < Device <EGLDisplay, EGLNativeDisplayType, EGLSurface, EGLNativeWindowType, gbm_bo_t> >::Onion const & > (* _it);

                        auto _d = _e.Peel ();

                       _ret = _d.Has (surface);

                       if (_ret != false) {
                           break;
                       }
                    };

                    return _ret;
                }

                bool HasNative (Surface <EGLSurface, EGLNativeWindowType, gbm_bo_t> const & surface) const {
                    bool _ret = false;

                    for (auto _it = begin (), _end = end (); _it != _end; _it++) {
                        auto _e = static_cast <typename Set < Device <EGLDisplay, EGLNativeDisplayType, EGLSurface, EGLNativeWindowType, gbm_bo_t> >::Onion const & > (* _it);

                        auto _d = _e.Peel ();

                        DeviceOnion const & _do = static_cast <DeviceOnion const &> (_d);

                       _ret = _do.HasNative (surface);

                       if (_ret != false) {
                           break;
                       }
                    }

                    return _ret;
                }

                bool List () const {
                    bool _ret = false;

                    for (auto _it = begin (), _end = end (); _it != _end; _it++) {
                        auto _e = static_cast <typename Set < Device <EGLDisplay, EGLNativeDisplayType, EGLSurface, EGLNativeWindowType, gbm_bo_t> >::Onion const & > (* _it);

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

        using drm_callback_data_t = struct { int fd; uint32_t fb; gbm_bo_t bo; bool waiting; };

        _PROXYEGL_PRIVATE static sync_t _syncobject;

        DeviceSet <EGLDisplay, EGLNativeDisplayType, EGLSurface, EGLNativeWindowType, gbm_bo_t> _set;

        using queue_t = std::tuple <int, uint32_t, gbm_surface_t, gbm_bo_t>;

#ifdef _FIXEDSIZEDQUEUE
        static constexpr uint32_t MaximumBufferCount = 2;

        class Queue : public FixedSizedQueue <queue_t, MaximumBufferCount> {
#else
        class Queue : public DynamicSizedQueue <queue_t> {
#endif
            using modeset_t = struct { int fd; drmModeCrtc* crtc; uint32_t connector; };

            public :

                Queue () = delete;

                Queue (int fd, uint32_t crtc, uint32_t connector) {
                    static_assert (std::is_pointer <decltype (_modeset.crtc)>::value != false);

                    decltype (_modeset.crtc) _crtc = nullptr;

                    assert (fd > 0);

                    if (fd > 0) {
                        _crtc = drmModeGetCrtc (fd, crtc);
                    }

                    _modeset = { fd, _crtc, connector };
                }

                ~Queue () {
                    auto _fd = _modeset.fd;
                    auto _crtc = _modeset.crtc;
                    auto _connector = _modeset.connector;

                    if (_crtc == nullptr || _fd <= 0 || drmModeSetCrtc(_fd, _crtc->crtc_id, _crtc->buffer_id, _crtc->x, _crtc->y, &_connector, 1, &(_crtc->mode)) != 0) {
                        // Error
                        LOG (_2CSTR ("Unable to restore initial mode set, with crtc (id = "), _crtc->crtc_id, _2CSTR(") and framebuffer (id "), _crtc->buffer_id, _2CSTR(")"));

                        assert (false);
                    }
                    else {
                        LOG (size (), _2CSTR (" framebuffer(s) available to cleanup"));

                        while (size () >= 1) {
                            queue_t _element = pop ();

                            auto _fd = std::get <0> (_element);
                            auto _fb = std::get <1> (_element);

                            if (_fd < 0 || _fb == 0 || drmModeRmFB (_fd, _fb) != 0) {
                                LOG (_2CSTR ("Failed to destruct frame buffer (id = "), _fb, _2CSTR (")"));
                            }
                            else {
                                auto _surf = std::get <2> (_element);
                                auto _bo = std::get <3> (_element);

                                if (_surf != gbm_surface_t_DEFAULT () && _bo != gbm_bo_t_DEFAULT ()) {

                                    {
                                    std::lock_guard < decltype (Platform::_syncobject) > _lock (_syncobject);

                                    DeviceSetOnion const & _onion = static_cast <DeviceSetOnion const &> (Platform::Instance ()._set);

                                    Surface <EGLSurface, EGLNativeWindowType, gbm_bo_t> _surface (EGL_NO_SURFACE /* act as dummy */, _surf);

                                    if (_onion.HasNative (_surface) != true) {
                                        // Error, expect it to be removed already by proper destruction flow
                                        // e.g., a call to gbm_surface_destroy or some other 'destroy' API
                                        LOG (_2CSTR ("Tracked surface not found"));
                                    }
                                    else {
                                        // Platform is destructed later

                                        /*void*/ Platform::Instance ().gbm_surface_release_buffer (_surf, _bo);
                                    }
                                    }
                                }
                                else {
                                    LOG (_2CSTR ("Failed to release internal buffer at "), _bo);
                                }
                            }
                        }
                    }

                    if(_crtc != nullptr) {
                        drmModeFreeCrtc (_crtc);
                    }
                }

            private :

                // Initial mode set
                modeset_t _modeset;
        };

        Platform () = default;

        virtual ~Platform () {
            DeviceSetOnion const & _s = static_cast <DeviceSetOnion const &> (_set);

            _s.List ();
        }

        template <typename Func>
        _PROXYEGL_PRIVATE bool hasGBMproperty(Func func) const;

        static constexpr uint32_t MinimumBufferCount () {
            return 1;
        }

// TODO; class Surface, also see comment on 'friends'
        _PROXYEGL_PRIVATE bool ScanOut (gbm_surface_t const & surface, uint8_t buffers = MinimumBufferCount ()) const;

        // Seconds
        _PROXYEGL_PRIVATE static constexpr time_t FrameDuration () {
            return 1;
        }

        // Helpers, make the GBM API well-defined within this unit
        // All these are ill-defined for EGL_DEFAULT_DISPLAY
// TODO: validate signature
        _PROXYEGL_PRIVATE gbm_bo_t gbm_surface_lock_front_buffer (gbm_surface_t surface) const;
        _PROXYEGL_PRIVATE void gbm_surface_release_buffer (gbm_surface_t surface, gbm_bo_t bo) const;
        _PROXYEGL_PRIVATE int gbm_surface_has_free_buffers (gbm_surface_t surface) const;

        // Allow access to this wrapper
        friend EGLBoolean ::eglTerminate (EGLDisplay);
        _PROXYEGL_PRIVATE bool Terminate (EGLDisplay const & display) {
            bool ret = false;

            std::lock_guard < decltype (Platform::_syncobject) > _lock (_syncobject);

            Device <EGLDisplay, EGLNativeDisplayType, EGLSurface, EGLNativeWindowType, gbm_bo_t> _device (display, EGLNativeDisplayType_DEFAULT () /* act as dummy */);

// TODO: This removes all resources, but EGL allows those resources continue to be bound on other threads until their explcit release, hence scan out might be affected
            ret = _set.Has (_device) && _set.Remove (_device);

            if (ret != true) {
                LOG (_2CSTR ("Unable to remove EGLDisplay "), display);
            }

            return ret;
        }
};

/*_PROXYEGL_PRIVATE*/ Platform::sync_t Platform::_syncobject;

template <typename Func>
bool Platform::hasGBMproperty (Func func) const {
    bool ret = false;

    struct sigaction _action[2]; //  new action, old action
    sigset_t _mask[2]; // new mask, old mask

    constexpr uint8_t NEW = 0;
    constexpr uint8_t OLD = 1;

    static Mutex _mutex;

    // It's time to block any of the calling threads before the first has completed the test
    std::lock_guard < decltype (_mutex) > _lock (_mutex);

    if (sigemptyset (&_mask[NEW]) != 0 || sigaddset (&_mask[NEW], SIGSEGV) != 0) {
        // Error
    }
    else {
        // Undefined behavior if SIGFPE, SIGILL, SIGSEGV, or SIGBUS are blocked and not generated by kill, pthreadd_kill, raise or sigqueue on the same thread; generated by other processes is ok
        // At least unblock any inadvertently blocked SIGSEGV
        if (pthread_sigmask (SIG_UNBLOCK /* ignored */,&_mask[NEW], &_mask[OLD]) == 0) {
            enum class JMP_STATUS : sig_atomic_t {UNDEFINED, SETUP, PROCESSED};

            static volatile JMP_STATUS _safe;
            static sigjmp_buf _stack_env;

            _safe = JMP_STATUS::UNDEFINED;

            // Strictly speaking c++ linkage and not C linkage
            // Asynchronous, but never called more than once (although pending SIGSEGV are possible, but they are usually redirected to one of the avaiable threads), still in scope until the old handler is restored
            auto handler = +[] (int signo) /*-> void */ {
                switch (_safe) {
                    case JMP_STATUS::UNDEFINED :
                        {
                            // Handler triggered before the stack enviroment was set up

                            if (signo == SIGSEGV) {
                                // Forward to the default handler
                                struct sigaction action;

                                /*void**/ memset (&action, 0, sizeof (action));

                                action.sa_flags = 0;
                                action.sa_handler = SIG_DFL;

                                // No longer block the SIGSEGV 
                                if (sigemptyset (&(action.sa_mask)) != 0) {
//                                    // Error
                                }

                                if (sigaction (SIGSEGV, &action, nullptr) != 0) {
                                    // Error
                                }

                                // Invoke the signal
                                LOG (_2CSTR ("Invoking the default SIGSEGV handler"));
                                if (pthread_kill (pthread_self (), SIGSEGV) != 0) {
//                                    // Error
                                }
                            }
                            break;
                        }
                    case JMP_STATUS::SETUP :
                        {
                            _safe = JMP_STATUS::PROCESSED;

                            siglongjmp (_stack_env , 1 /* anything not 0 */);

                            break;
                        }
                    case JMP_STATUS::PROCESSED :
                    default                              :
                        {  // Error, this should not happen
                            LOG (_2CSTR ("Unexpected state in the SIGSEGV handler"));
                        }
                }
            };

            /*void**/ memset (&_action[NEW], 0, sizeof (_action[NEW]));
            _action[NEW].sa_flags = 0;
//            _action[NEW].sa_handler = &gbm_handler;
            _action[NEW].sa_handler = handler;
            // Only if SA_NODEFER is set
//            _action[NEW].sa_mask = _mask[NEW];

            if (sigsetjmp (_stack_env, 1 /* save signal mask */) != 0) {
                // Returned from siglongjmp in signal handler and rewinded the stack etc
                // Return value equals value set in siglongjmp
                 LOG (_2CSTR ("Returned from the signal handler"));
            }
            else {
                // Prepare to probe
                // True return of sigsetjmp equals 0

#ifndef _TEST
                // Handler and stack environment are set up
                _safe = JMP_STATUS::SETUP;

                // Probe gbm property
                func();
#else
                // Deliberately cause a segfault
                LOG (_2CSTR ("Deliberately invoking SIGSEGV"));
                if (pthread_kill (pthread_self (), SIGSEGV) != 0) {
                }
#endif
            }

            // Restore by at least disabling the 'local' signal handler
            if (sigaction (SIGSEGV, &_action[OLD], nullptr) != 0) {
                // Error
            }

            // Wait until none of the pending signals is a SIGSEGV
            sigset_t pending;

            int value = 0;
            do {
                if (value == -1 || sigpending (&pending) != 0) {
                    // Unable to verify
                    int err = errno;
                    LOG (_2CSTR ("Unable to determine pending SIGSEGV signals with "), err);
                    break;
                }
                else {
                    value = sigismember (&pending, SIGSEGV);
                }
            } while (value == 1 || value == -1); // SIGSEGV pending or error

            // Assume display is a of gbm_device_t If the handler was not invoked
             ret = !(_safe == JMP_STATUS::PROCESSED);

            _safe = JMP_STATUS::UNDEFINED;

#ifdef _TEST
            // Deliberately cause a segfault
            LOG (_2CSTR ("Deliberately invoking SIGSEGV"));
            if (pthread_kill (pthread_self (), SIGSEGV) != 0) {
                // Error
            }
#endif

        }
    }

    return ret;
}

// Uses hasGBMproperty, hence no guard
bool Platform::isGBMdevice (EGLNativeDisplayType const & display) const {
    // Probe gbm device
    auto func = [&display] () -> bool {
        bool ret = false;

        // Not using Platform::gbm_device_t! Here using gbmint.h internals.
        using gbm_device_t = struct { struct gbm_device* (*dummy) (int); };

        // Expect some slicing
        const gbm_device_t* _device = reinterpret_cast <const gbm_device_t*> (display);

        if (_device != nullptr && _device->dummy != nullptr) {
            // Some symbols may be undefined if libgbm is not explicitly loaded
            ret = loaded (libGBMname ()) != false && _device->dummy == &gbm_create_device;
// TODO: use dladdr to test if both are within the same library and the nearest symbols equal
        }

        return ret;
    };

    bool ret = false;

    // The true type is fixed by eglplatform and a platform flag, eg, __GBM__
    if (display != EGL_DEFAULT_DISPLAY) {
        // Probe gbm device
        ret = hasGBMproperty (func);
    }

    LOG (_2CSTR ("Display is "), ret != false ? _2CSTR ("") : _2CSTR ("NOT "), _2CSTR ("a GBM device"));

    return ret;
}

// Uses hasGBMproperty, hence no guard
bool Platform::isGBMsurface (EGLNativeWindowType const & window) const {
    // Probe gbm surface
    auto func = [&window] () -> bool {
        bool ret = false;

        // Not using Platform::gbm_device_t! Here using gbmint.h internals.
        using gbm_surface_t = struct { struct gbm_device* gbm; };

        // Expect some slicing
        const gbm_surface_t* _surface = reinterpret_cast <const gbm_surface_t*> (window);

        if (_surface != nullptr && _surface->gbm != nullptr) {
            // Not using Platform::gbm_device_t! Here using gbmint.h internals.
            using gbm_device_t = struct { struct gbm_device* (*dummy) (int); };

            // Expect some slicing
            const gbm_device_t* _device = reinterpret_cast <const gbm_device_t*> (_surface->gbm);

            if (_device != nullptr && _device->dummy != nullptr) {
                // Some symbols may undefined if libgbm is not explicitly loaded
                // RTLD_NOLOAD does not exist in POSIX
                ret = loaded (libGBMname ()) != false && _device->dummy == &gbm_create_device;
// TODO: use dladdr to test if both are within the same library and the nearest symbols equal
            }
        }

        return ret;
    };

    // Probe gbm surface
    bool ret = hasGBMproperty (func);

    LOG (_2CSTR ("Surface is "), ret != false ? _2CSTR ("") : _2CSTR ("NOT "), _2CSTR ("a GBM surface"));

    return ret;
}

void Platform::FilterConfigs (EGLDisplay const & display, std::vector <EGLConfig>& configs) const {
    std::lock_guard < decltype (Platform::_syncobject) > _lock (_syncobject);

    Device <EGLDisplay, EGLNativeDisplayType, EGLSurface, EGLNativeWindowType, gbm_bo_t> _device (display, EGLNativeDisplayType_DEFAULT () /* act as dummy */);

    // Filter only for GBM displays being tracked
    if ( _set.Has (_device) != false && configs.empty() != true) {
        auto it = configs.begin();

        while (it != configs.end()) {
            EGLint value = 0;

            if (eglGetConfigAttrib (display, *it, EGL_NATIVE_VISUAL_ID, &value) != EGL_FALSE) {
                // Both formats should be considered equivalent / interchangeable
                if (value != DRM_FORMAT_ARGB8888 && value != DRM_FORMAT_XRGB8888) {
                    it = configs.erase (it);
                    continue;
                }
            }

            ++it;
        }
    }
}

bool Platform::Add (EGLDisplay const & egl, EGLNativeDisplayType const & native) {
    //  An EGL display remains valid until an application ends, here until the library unloads

    std::lock_guard < decltype (Platform::_syncobject) > _lock (_syncobject);

    Device <EGLDisplay, EGLNativeDisplayType, EGLSurface, EGLNativeWindowType, gbm_bo_t> _device (egl, native);

    bool ret = _set.Add (_device);

    if (ret != true) {
        LOG (_2CSTR ("Unable to add EGLDisplay "), egl, _2CSTR (" and native display "), native);
    }

    assert (ret != false);

    return ret;
}

bool Platform::Add (EGLDisplay const & display, EGLSurface const & egl, EGLNativeWindowType const & native) {
    std::lock_guard < decltype (Platform::_syncobject) > _lock (_syncobject);

    Device <EGLDisplay, EGLNativeDisplayType, EGLSurface, EGLNativeWindowType, gbm_bo_t> _device (display, EGLNativeDisplayType_DEFAULT () /* act as dummy */);

    Surface <EGLSurface, EGLNativeWindowType, gbm_bo_t> _surface (egl, native);

    bool ret = _set.Has (_device) && _device.Add (_surface) && _set.Emplace (_device);

    assert (ret != false);

    return ret;
}

bool Platform::Remove (EGLDisplay const & display, EGLSurface const & egl) {
    std::lock_guard < decltype (Platform::_syncobject) > _lock (_syncobject);

    Device <EGLDisplay, EGLNativeDisplayType, EGLSurface, EGLNativeWindowType, gbm_bo_t> _device (display, EGLNativeDisplayType_DEFAULT () /* act as dummy */);

    Surface <EGLSurface, EGLNativeWindowType, gbm_bo_t> _surface (egl, EGLNativeWindowType_DEFAULT () /* act as dummy*/);

    bool ret = _set.Has (_device) && _device.Has (_surface) && _device.Remove (_surface) && _set.Emplace (_device);

    assert (ret != false);

    return ret;
}

bool Platform::ScanOut (EGLSurface const & surface) const {
    bool ret = false;

    std::lock_guard < decltype (Platform::_syncobject) > _lock (_syncobject);

    // Check here and not in every helper
    EGLDisplay _dpy = eglGetCurrentDisplay ();

    if (_dpy != EGL_NO_DISPLAY) {
        Device <EGLDisplay, EGLNativeDisplayType, EGLSurface, EGLNativeWindowType, gbm_bo_t> _device (_dpy, EGL_DEFAULT_DISPLAY /* act as dummy */);

        Surface <EGLSurface, EGLNativeWindowType, gbm_bo_t> _surface (surface, EGLNativeWindowType_DEFAULT () /* act as dummy*/);

        if (_set.Has (_device) != false && _device.Has (_surface) != false)  {
            DeviceOnion const & _do = static_cast <DeviceOnion const &> (_device);

            if (_do.NativeType () != EGL_DEFAULT_DISPLAY) {
                EGLint _value;

                if (eglQuerySurface (_dpy, surface, EGL_RENDER_BUFFER, &_value) != EGL_FALSE) {
                    SurfaceOnion const & _so = static_cast <SurfaceOnion const &> (_surface);

                    gbm_surface_t _gbm_surf = reinterpret_cast <gbm_surface_t> (_so.NativeType ());

#ifdef _FIXEDSIZEDQUEUE
                    static_assert (MinimumBufferCount () < MaximumBufferCount);
#endif
                    ret = ScanOut (_gbm_surf, _value != EGL_BACK_BUFFER ? MinimumBufferCount () : MinimumBufferCount () + 1);
                }
                else {
                    LOG (_2CSTR ("Unable to complete scan out"));
                }
            }
            else {
                LOG (_2CSTR ("EGL display has wrong type"));
                assert (false);
            }
        }
        else {
            LOG (_2CSTR ("Untracked EGLSurface"));
            assert (false);
        }
    } else {
        LOG (_2CSTR ("No valid EGL display available for scan out"));
    }

    return ret;
}

// Never called directly, hence no guard
bool Platform::ScanOut (gbm_surface_t const & surface, uint8_t buffers) const {
    // Determine current CRTC; currently only considers just a single crtc-encoder-connector path
    auto func = [] (uint32_t fd, uint32_t& crtc, uint32_t& connectors) -> uint32_t {
        uint32_t ret = 0;

        if (ret == 0) {
            drmModeResPtr _res = drmModeGetResources (fd);

            if (_res != nullptr) {

                for (int i = 0; i < _res->count_connectors; i++) {
                    // Do not probe
                    drmModeConnectorPtr _con = drmModeGetConnectorCurrent (fd, _res->connectors[i]);

                    // Only consider HDMI
                    if (_con != nullptr) {
                        if ( (_con->connector_type == DRM_MODE_CONNECTOR_HDMIA  || \
                              _con->connector_type == DRM_MODE_CONNECTOR_HDMIB) && \
                              DRM_MODE_CONNECTED == _con->connection) {

                            // Encoder currently connected to
                            drmModeEncoderPtr _enc = drmModeGetEncoder (fd, _con->encoder_id);

                            if (_enc != nullptr) {
                                crtc = _enc->crtc_id;

                                connectors = _con->connector_id;

                                ++ret;

                                drmModeFreeEncoder (_enc);
                            }
                        }

                        drmModeFreeConnector (_con);
                    }

                    if (ret > 0) {
                        // Probably never exceeds 1
                        break;
                    }
                }

                drmModeFreeResources (_res);
            }
        }

        return ret;
    };

    // Buffer to queue and buffer to release
    std::array <gbm_bo_t, 2> _bo = { nullptr, nullptr };

    // Not all used  gbm / drm API here are well defined within this unit
    // This can be an expensive test, thus cache the result
    static bool _loaded = loaded (libGBMname ()) && loaded (libDRMname ());

    if (_loaded != false) {
        if (surface != gbm_surface_t_DEFAULT ()) {
            _bo.back () = gbm_surface_lock_front_buffer (surface);
        }

        gbm_device_t _gbm_device = gbm_device_t_DEFAULT ();

        if (_bo.back () != gbm_bo_t_DEFAULT ()) {
            _gbm_device = gbm_bo_get_device (_bo.back ());
        }

        if (_gbm_device != gbm_device_t_DEFAULT ()) {
            int _fd = gbm_device_get_fd (_gbm_device);

            if (_fd >= 0 && drmAvailable () != 0 && drmIsMaster (_fd) != 0) {
                auto _element = _bo.back ();

                uint32_t _format = gbm_bo_get_format (_element);
                uint32_t _bpp = gbm_bo_get_bpp (_element);
                uint32_t _stride = gbm_bo_get_stride (_element);
                uint32_t _height = gbm_bo_get_height (_element);
                uint32_t _width = gbm_bo_get_width (_element);
                uint32_t _handle = gbm_bo_get_handle (_element).u32;

                if (_bpp == 32 && gbm_device_is_format_supported (_gbm_device, _format, GBM_BO_USE_SCANOUT) != 0) {
                    // gbm_bo_format is any of
                    // GBM_BO_FORMAT_XRGB8888 : RGB in 32 bit
                    // GBM_BO_FORMAT_ARGB8888 : ARGB in 32 bit
                    // and should be considered something internal

                    // Formats can be set using GBM_BO_FORMAT_XRGB8888, GBM_BO_FORMAT_ARGB8888, but also with DRM_FORMAT_XRGB8888 and DRM_FORMAT_ARGB8888
                    // The returned format is always one of the latter two, which is indicative for the native visual id. Do not support other format than available with gbm.
                    assert (_format == DRM_FORMAT_XRGB8888 || _format == DRM_FORMAT_ARGB8888);

                    uint32_t _fb = 0;

                    // drm_fourcc.c illustrates that DRM_FORMAT_XRGB8888 has depth 24, and DRM_FORMAT_ARGB8888 has depth 32
                    if (drmModeAddFB (_fd, _width, _height, _format != DRM_FORMAT_ARGB8888 ? _bpp - 8 : _bpp, _bpp, _stride, _handle, &_fb) == 0) {
                        // Expensive operation thus best to cache the result assuming it will not change
                        static uint32_t _crtc = 0;
                        static uint32_t _connectors = 0;
                        static uint32_t _count = func (_fd, _crtc, _connectors);

                        // Enable multi buffering
                        static Platform::Queue _queue (_fd, _crtc, _connectors);

                        auto enqueue = [&buffers, &surface, this] (int fd, uint32_t fb, gbm_bo_t bo) -> gbm_bo_t {
                            gbm_bo_t ret = gbm_bo_t_DEFAULT ();

                            /* void */ _queue.push (std::make_tuple(fd, fb, surface, bo));

                            if ( MinimumBufferCount () ==  buffers || _queue.size () >= buffers) {
                                queue_t _element = _queue.pop ();

                                auto _fd = std::get <0> (_element);
                                auto _fb = std::get <1> (_element);

                                if (_fd < 0 || _fb == 0 || drmModeRmFB (_fd, _fb) != 0) {
                                    // Always true for the initial frame
                                    LOG (_2CSTR ("Unable to remove 'old' frame buffer"));
                                }
                                else {
                                    auto _bo = std::get <3> (_element);

                                    static_assert (std::is_same <decltype (_bo), decltype (ret)>::value != false);
                                    ret = _bo;
                                }
                            }

                            return ret;
                        };

                        static Platform::drm_callback_data_t _callback_data = {_fd, _fb, _bo.back (), true};

                        // Guardian of the shared data presented one line earlier
                        static Mutex _mutex;

                        _callback_data = {_fd, _fb, _bo.back (), true};

                        int _err = drmModePageFlip (_fd, _crtc, _fb, DRM_MODE_PAGE_FLIP_EVENT, &_callback_data);

                        switch (0 - _err) {
                            case 0      :   {   // No error
                                                // Strictly speaking c++ linkage and not C linkage
                                                // Asynchronous, but never called more than once, waiting in scope
                                                auto handler = +[] (int fd, unsigned int frame, unsigned int sec, unsigned int usec, void* data) {
                                                    std::lock_guard < decltype (_mutex) > _lock (_mutex);

                                                    if (data != nullptr) {
                                                        Platform::drm_callback_data_t* _data = reinterpret_cast <Platform::drm_callback_data_t*> (data);

                                                        assert (fd == _data->fd);

                                                        // Encourages the loop to break
                                                        _data->waiting = false;
                                                    }
                                                    else {
                                                        LOG (_2CSTR ("Invalid callback data"));
                                                    }
                                                };

                                                // Use the magic constant here because the struct is versioned!
                                                drmEventContext _context = { .version = 2, . vblank_handler = nullptr, .page_flip_handler = handler };

                                                fd_set _fds;

                                                struct timespec _timeout = { .tv_sec = Platform::FrameDuration (), .tv_nsec = 0 };

                                                bool _waiting = true;

                                                {
                                                    std::lock_guard < decltype (_mutex) > _lock (_mutex);
                                                    _waiting = _callback_data.waiting;
                                                }

                                                while (_waiting != false) {
                                                    FD_ZERO (&_fds);
                                                    FD_SET( _fd, &_fds);

                                                    // Race free
                                                    _err  = pselect(_fd + 1, &_fds, nullptr, nullptr, &_timeout, nullptr);

                                                    if (_err < 0) {
                                                        // Error; break the loop
                                                        break;
                                                    }
                                                    else {
                                                        if (_err == 0) {
                                                            // Timeout; retry
// TODO: add an additional condition to break the loop to limit the number of retries, but then deal with the asynchronous nature of the callback
                                                        }
                                                        else { // ret > 0
                                                            if (FD_ISSET (_fd, &_fds) != 0) {
                                                                // Node is readable
                                                                if (drmHandleEvent (_fd, &_context) != 0) {
                                                                    // Error; break the loop
                                                                    break;
                                                                }

                                                                // Flip probably occured already otherwise it loops again
                                                                _bo.front () = enqueue (_fd, _fb, _bo.back ());
                                                            }
                                                        }
                                                    }

                                                    {
                                                         std::lock_guard < decltype (_mutex) > _lock (_mutex);
                                                        _waiting = _callback_data.waiting;
                                                    }
                                                }

                                                break;
                                            }
                            // Many causes, but the most obvious is a busy resource or a missing drmModeSetCrtc
                            case EINVAL :   {     // Probably a missing drmModeSetCrtc or an invalid _crtc
                                                drmModeCrtcPtr _ptr = drmModeGetCrtc (_fd, _crtc);

                                                if (_ptr != nullptr) {
                                                    // Assume the dimensions of the buffer fit within this mode
                                                    if (drmModeSetCrtc (_fd, _crtc, _fb, _ptr->x, _ptr->y, &_connectors, _count, &_ptr->mode) != 0) {
                                                        // Error
                                                        // There is nothing to be done te recover
                                                    }
                                                    else {
                                                        _bo.front () = enqueue (_fd, _fb, _bo.back ());
                                                    }

                                                    drmModeFreeCrtc (_ptr);
                                                }

                                                break;
                                            }
                            case EBUSY  :
                            default     :   {
                                            // There is nothing to be done about it
                                            }
                        }
                    }
                }
            }
            else {
                LOG (_2CSTR ("Unable to complete the scan out due to insufficient privileges"));
            }
        }

        if (surface != gbm_surface_t_DEFAULT () && _bo.front () != gbm_bo_t_DEFAULT ()) {
            /*void*/ gbm_surface_release_buffer (surface, _bo.front ());
        }
        else {
            LOG (_2CSTR ("Unable to release a buffer"));
        }

        if (surface != nullptr && gbm_surface_has_free_buffers (surface) <= 0) {
            LOG (_2CSTR ("Insufficient free buffers left"));
        }
    }
    else {
        LOG (_2CSTR ( "Unable to complete the scan out due to missing support library"));
    }

    return _bo.front () != gbm_bo_t_DEFAULT ();
}

// Helpers

Platform::gbm_bo_t Platform::gbm_surface_lock_front_buffer (gbm_surface_t surface) const {
    gbm_bo_t ret = gbm_bo_t_DEFAULT ();

    // This can be an expensive test thus cache the result
    static bool _loaded = loaded (libGBMname ());

    // Some symbols may be undefined if libgbm is not (explicitly) loaded
    if (_loaded != false) {
        ret = ::gbm_surface_lock_front_buffer (surface);
    }
    else {
        // Error
        assert (false);
    }

    return ret;
}

void Platform::gbm_surface_release_buffer (gbm_surface_t surface, gbm_bo_t bo) const {
    // This can be an expensive test thus cache the result
    static bool _loaded = loaded (libGBMname ());

    // Some symbols may be undefined if libgbm is not (explicitly) loaded
    if (_loaded != false) {
        /* void */ ::gbm_surface_release_buffer (surface, bo); 
    }
    else {
        // Error
        assert (false);
    }
}

int Platform::gbm_surface_has_free_buffers (gbm_surface_t surface) const {
    // This can be an expensive test thus cache the result
    static bool _loaded = loaded (libGBMname ());

    int ret = 0;

    // Some symbols may be undefined if libgbm is not (explicitly) loaded
    if (_loaded != false) {
        ret = ::gbm_surface_has_free_buffers (surface);
    }
    else {
        // Error
        assert (false);
    }

    return ret;
}

#undef _PROXYEGL_PRIVATE
#undef _PROXYEGL_PUBLIC
} // Anonymous namespace

// EGL 1.4 / 1.5 extension support
__eglMustCastToProperFunctionPointerType eglGetProcAddress (const char* procname) {
    static void* (*_eglGetProcAddress) (const char*) = nullptr;

    static bool resolved = lookup ("eglGetProcAddress", reinterpret_cast <uintptr_t&> (_eglGetProcAddress));

    __eglMustCastToProperFunctionPointerType ret = nullptr;

    if (resolved != false) {
        // Intercept to be able to intercept the underlying functions
        if (procname != nullptr) {
            if (std::string (procname).compare ("eglGetPlatformDisplayEXT") == 0) {
                LOG (_2CSTR ("Intercepting eglGetProcAddress and replacing it with a local function"));

                ret = reinterpret_cast <__eglMustCastToProperFunctionPointerType> ( &eglGetPlatformDisplayEXT );
            }

            if (std::string (procname).compare ("eglCreatePlatformWindowSurfaceEXT") == 0) {
                LOG (_2CSTR ("Intercepting eglGetProcAddress and replacing it with a local function"));

                ret = reinterpret_cast <__eglMustCastToProperFunctionPointerType> ( &eglCreatePlatformWindowSurfaceEXT );
            }
        }

        if (ret == nullptr) {
            LOG (_2CSTR ("Calling Real eglGetProcAddress"));

            ret = reinterpret_cast <__eglMustCastToProperFunctionPointerType> ( _eglGetProcAddress (procname) );
        }
    }
    else {
        LOG (_2CSTR ("Real eglGetProcAddress not found"));
        assert (false);
    }

    return ret;
}

EGLDisplay eglGetPlatformDisplayEXT (EGLenum platform, void* native_display, const EGLAttrib* attrib_list) {
    static void* (*_eglGetProcAddress) (const char*) = nullptr;

    static EGLDisplay (*_eglGetPlatformDisplayEXT) (EGLenum, void*, const EGLAttrib*) = (lookup ("eglGetProcAddress", reinterpret_cast <uintptr_t&> (_eglGetProcAddress)) != true ? nullptr : reinterpret_cast <EGLDisplay (*) (EGLenum, void*, const EGLAttrib*)> ( _eglGetProcAddress("eglGetPlatformDisplayEXT") ) );

    static bool resolved = _eglGetPlatformDisplayEXT != nullptr;

    EGLDisplay ret = EGL_NO_DISPLAY;

    if (resolved != false) {
        LOG (_2CSTR ("Calling Real eglGetPlatformDisplayEXT"));

        ret = _eglGetPlatformDisplayEXT (platform, native_display, attrib_list);

//        static_assert (std::is_pointer <EGLNativeDisplayType>::value != false);
        if (ret != EGL_NO_DISPLAY && platform == EGL_PLATFORM_GBM_KHR && Platform::Instance ().isGBMdevice (reinterpret_cast <EGLNativeDisplayType> (native_display)) != false) {

            LOG (_2CSTR ("Detected GBM platform, hence, native_display is of gbm_device_t"));

            if (Platform::Instance ().Add (ret, reinterpret_cast <EGLNativeDisplayType> (native_display)) != false) {
                // Hand over the result
            }
            else {
                // Probably already added but not / never removed
                assert (false);
            }
        }
    }
    else {
        LOG (_2CSTR ("Real eglGetPlatformDisplayEXT not found"));
        assert (false);
    }

    return ret;
}

EGLSurface eglCreatePlatformWindowSurfaceEXT (EGLDisplay dpy, EGLConfig config, void* native_window, const EGLAttrib* attrib_list) {
    static void* (*_eglGetProcAddress) (const char*) = nullptr;

    static EGLSurface (*_eglCreatePlatformWindowSurfaceEXT) (EGLDisplay, EGLConfig, void*, const EGLAttrib*) = (lookup ("eglGetProcAddress", reinterpret_cast <uintptr_t&> (_eglGetProcAddress)) != true ? nullptr : reinterpret_cast <EGLSurface (*) (EGLDisplay, EGLConfig, void*, const EGLAttrib*)> ( _eglGetProcAddress("eglCreatePlatformWindowSurfaceEXT") ));

    static bool resolved = _eglCreatePlatformWindowSurfaceEXT != nullptr;

    EGLSurface ret = EGL_NO_SURFACE;

    if (resolved != false) {
        LOG (_2CSTR ("Calling Real eglCreatePlatformWindowSurfaceEXT"));

        ret = _eglCreatePlatformWindowSurfaceEXT (dpy, config, native_window, attrib_list);

        if (ret != EGL_NO_SURFACE && Platform::Instance ().isGBMsurface ( reinterpret_cast <EGLNativeWindowType> (native_window) ) != false) {

            if (Platform::Instance ().Add (dpy, ret, reinterpret_cast <EGLNativeWindowType> (native_window)) != false) {
                // Hand over the result
            }
            else {
                // Probably already added but not / never removed
                LOG (_2CSTR ("Surface already exists"));

                assert (false);
            }
        }

    }
    else {
        LOG (_2CSTR ("Real egliCreatePlatformWindowSurfaceEXT not found"));
        assert (false);
    }

    return ret;
}

// EGL 1.4 support

EGLDisplay eglGetDisplay (EGLNativeDisplayType display_id) {
    static EGLDisplay (*_eglGetDisplay) (EGLNativeDisplayType) = nullptr;

    static bool resolved = lookup ("eglGetDisplay", reinterpret_cast <uintptr_t&> (_eglGetDisplay));

    EGLDisplay ret = EGL_NO_DISPLAY;

    if (resolved != false) {
#ifndef _MESADEBUG
        LOG (_2CSTR ("Calling Real eglGetDisplay"));

        ret = _eglGetDisplay (display_id);

        if (ret != EGL_NO_DISPLAY && Platform::Instance ().isGBMdevice (display_id) != false) {
            if (Platform::Instance ().Add (ret, display_id) != false) {
                // Hand over the result
            }
            else {
                // Probably already added but not / never removed
                LOG (_2CSTR ("Display already exists"));

                assert (false);
            }
        }
#else
        if (Platform::Instance ().isGBMdevice (display_id) != false) {
            // Force eglGetPlatformDisplay or eglGetPlatformDisplayEXT to avoid the MESA bug
            // Make it explicit that the platform is GBM

            // Default to the implementation defaults; required attributes are implicitly specified
            const EGLAttrib _attribs[] = { EGL_NONE };

            ret = eglGetPlatformDisplayEXT (EGL_PLATFORM_GBM_KHR, display_id, &_attribs[0]);

            if (ret == EGL_NO_DISPLAY) {
                ret = eglGetPlatformDisplay (EGL_PLATFORM_GBM_MESA, display_id, &_attribs[0]);
            }
        }

        // Fallback(s)

        if (ret == EGL_NO_DISPLAY) {
            ret = _eglGetDisplay (display_id);

            if (ret != EGL_NO_DISPLAY) {
                if (Platform::Instance ().Add (ret, display_id) != false) {
                    // Hand over the result
                }
                else {
                    // Probably already added but not / never removed
                    assert (false);
                }
            }
        }
#endif
    }
    else {
        LOG (_2CSTR ("Real eglGetDisplay not found"));
        assert (false);
    }

    return ret;
}

EGLBoolean eglTerminate (EGLDisplay dpy) {
    static EGLBoolean (*_eglTerminate) (EGLDisplay) = nullptr;

    static bool resolved = lookup ("eglTerminate", reinterpret_cast <uintptr_t&> (_eglTerminate));

    EGLBoolean ret = EGL_FALSE;

    if (resolved != false) {
        LOG (_2CSTR ("Calling Real eglTerminate"));

        std::lock_guard < decltype (Platform::Instance ().SyncObject ()) > _lock (Platform::Instance ().SyncObject ());

        ret = _eglTerminate (dpy);

        if (ret != EGL_FALSE) {
            // All resources are marked for deletion; EGLDisplay handles remain valid. Other handles are invalidated and once used may result in errors
            // eglReleaseThread and eglMakeCurrent can be called to complete deletion of resources

            ret = Platform::Instance ().Terminate (dpy);
        }
    }
    else {
        LOG (_2CSTR ("Real eglTerminate not found"));
        assert (false);
    }

    return ret;
}

EGLBoolean eglChooseConfig (EGLDisplay dpy, const EGLint* attrib_list, EGLConfig* configs, EGLint config_size, EGLint* num_config) {
    static EGLBoolean (*_eglChooseConfig) (EGLDisplay, const EGLint*, EGLConfig*, EGLint, EGLint*) = nullptr;

    static bool resolved = lookup ("eglChooseConfig", reinterpret_cast <uintptr_t&> (_eglChooseConfig));

    EGLBoolean ret = EGL_FALSE;

    if (resolved != false) {

        LOG (_2CSTR ("Calling Real eglChooseConfig"));

        ret = eglGetConfigs (dpy, nullptr, config_size, num_config);

        if (ret != EGL_FALSE && *num_config > 0) {

            EGLConfig _configs [*num_config];

            ret = _eglChooseConfig (dpy, attrib_list, &_configs [0], *num_config, num_config);

            // Do not filter for (platform unrelated) pbuffers
            bool _available = false;

            if (attrib_list != nullptr) {
                for (size_t i = 0; attrib_list [i] != EGL_NONE && _available != true; i++) {
                    if (i > 1 && attrib_list [i-1] == EGL_SURFACE_TYPE) {
                        _available = (attrib_list [i] & EGL_PBUFFER_BIT) == EGL_PBUFFER_BIT;
                    }
                }
            }

            // Temporary placeholder
            std::vector <EGLConfig> _vector;

            if (_available != true) {

                if (ret != EGL_FALSE) {

                    _vector.insert (_vector.end (), &_configs[0], &_configs[*num_config]);

                    // Filter the configs
                    Platform::Instance ().FilterConfigs (dpy, _vector);

                    *num_config = _vector.size ();
                }

            }
            else {
                LOG (_2CSTR ("Off screen pbuffer support requested. Frame buffer configuration NOT filtered."));
            }

            if (ret != EGL_FALSE && configs != nullptr) {
                *num_config = config_size > *num_config ? *num_config : config_size;

                /* void* */ memcpy (configs, _vector.data (), *num_config * sizeof (EGLConfig));
            }
        }
    }
    else {
        LOG (_2CSTR ("Real eglChooseConfig not found"));
        assert (false);
    }

    return ret;
}

EGLSurface eglCreateWindowSurface (EGLDisplay dpy, EGLConfig config, EGLNativeWindowType win, const EGLint* attrib_list) {
    static EGLSurface (*_eglCreateWindowSurface) (EGLDisplay, EGLConfig, EGLNativeWindowType, const EGLint*) = nullptr;

    static bool resolved = lookup ("eglCreateWindowSurface", reinterpret_cast <uintptr_t&> (_eglCreateWindowSurface));

    EGLSurface ret = EGL_NO_SURFACE;

    if (resolved != false) {
#ifndef _MESADEBUG
        LOG (_2CSTR ("Calling Real eglCreateWindowSurface"));

        ret = _eglCreateWindowSurface(dpy, config, win, attrib_list);

        if (ret != EGL_NO_SURFACE && Platform::Instance ().isGBMsurface (win) != false) {
            if (Platform::Instance ().Add (dpy, ret, win) != false) {
                // Hand over the result
            }
            else {
                // Probably already added but not / never removed
                assert (false);
            }
        }
#else
        if (Platform::Instance ().isGBMsurface (win) != false) {
            // Force eglCreatePlatformWindowSurface or eglCreatePlatformWindowSurfaceEXT
            ret = eglCreatePlatformWindowSurfaceEXT (dpy, config, win, attrib_list);

            if (ret == EGL_NO_SURFACE) {
                ret = eglCreatePlatformWindowSurface (dpy, config, win, attrib_list);
            }

            // Fallback(s)

            if (ret == EGL_NO_SURFACE) {
                ret = _eglCreateWindowSurface(dpy, config, win, attrib_list);

                if (ret != EGL_NO_SURFACE) {
                    if (Platform::Instance ().Add (ret, win) != false) {
                        // Hand over the result
                    }
                    else {
                        // Probably already added but not / never removed
                        assert (false);
                    }
                }
            }
        }
#endif
    }
    else {
        LOG (_2CSTR ("Real eglCreateWindowSurface not found"));
        assert (false);
    }

    return ret;
}

EGLBoolean eglDestroySurface (EGLDisplay dpy, EGLSurface surface) {
    static EGLBoolean (*_eglDestroySurface) (EGLDisplay, EGLSurface) = nullptr;

    static bool resolved = lookup ("eglDestroySurface", reinterpret_cast <uintptr_t&> (_eglDestroySurface));

    EGLBoolean ret = EGL_FALSE;

    if (resolved != false) {
        LOG (_2CSTR ("Calling Real eglDestroySurface"));

        ret = _eglDestroySurface(dpy, surface);

        if (ret != EGL_FALSE) {
            if (Platform::Instance ().Remove (dpy, surface) != true) {
                assert (false);
            }
        }
    }
    else {
        LOG (_2CSTR ("Real eglDestroySurface not found"));
        assert (false);
    }

    return ret;
}

EGLBoolean eglSwapBuffers (EGLDisplay dpy, EGLSurface surface) {
    static EGLBoolean (*_eglSwapBuffers) (EGLDisplay, EGLSurface) = nullptr;

    static bool resolved = lookup ("eglSwapBuffers", reinterpret_cast <uintptr_t&> (_eglSwapBuffers));

    EGLBoolean ret = EGL_FALSE;

    if (resolved != false) {
#ifdef _MESADEBUG
        if ( eglGetCurrentContext ()         != EGL_NO_CONTEXT && \
             eglGetCurrentDisplay ()         == dpy            && \
             eglGetCurrentSurface (EGL_READ) == surface        && \
             eglGetCurrentSurface (EGL_DRAW) == surface) {

            LOG (_2CSTR ("Valid current context / display / surface"));

            EGLint _value;
            if (EGL_FALSE != eglQueryContext (dpy, eglGetCurrentContext(), EGL_RENDER_BUFFER, &_value)) {
                switch (_value) {
                    case EGL_BACK_BUFFER    : LOG (_2CSTR ("Back buffer being used"));   break; // Possibly double buffering
                    case EGL_SINGLE_BUFFER  : LOG (_2CSTR ("Single buffer being used")); break; // No double, triple, ... buffering
                    case EGL_NONE           :
                    default                 : LOG (_2CSTR ("Context not bound to surface"));
                }
            }

            if (EGL_FALSE != eglQuerySurface (dpy, surface, EGL_WIDTH, &_value)) {
                LOG (_2CSTR ("Surface witdh "), _value);
            }

            if (EGL_FALSE != eglQuerySurface (dpy, surface, EGL_HEIGHT, &_value)) {
                LOG (_2CSTR ("Surface height "), _value);
            }

            if (EGL_FALSE != eglQuerySurface (dpy, surface, EGL_SWAP_BEHAVIOR, &_value)) {
                constexpr char _prefix [] = "Surface color buffer behavior is ";
                constexpr char _postfix [] = ", but ancillary buffer behavior is always UNKNOWN";
                switch (_value) {
                    case EGL_BUFFER_DESTROYED   : LOG (_prefix, _2CSTR ("DESTROY") , _postfix);  break;
                    case EGL_BUFFER_PRESERVED   : LOG (_prefix, _2CSTR ("PRESERVE"), _postfix); break;
                    default                     : LOG (_prefix, _2CSTR ("UNKNOWN") , _postfix);
                }
            }

            LOG (_2CSTR ("Calling Real eglSwapBuffers for EGLSurface "), surface, _2CSTR (" on thread "), syscall (SYS_gettid));
#else
            LOG (_2CSTR ("Calling Real eglSwapBuffers"));
#endif

            // MESA expects a call to the gbm_surface_lock_front_buffer prior any subseqent eglSwapBuffers to avoid an internal error
            ret = _eglSwapBuffers (dpy, surface);

            if (ret != EGL_FALSE && Platform::Instance ().ScanOut (surface) != false) {
                // Nothing
            }
            else {
                LOG (_2CSTR ("Not performing a platform enabled scan out"));
            }
#ifdef _MESADEBUG
        }
        else {
            // Has an eglMakeCurrent been called?
            LOG (_2CSTR ("No Valid context / display / surface detected"));
        }
#endif
    }
    else {
        LOG (_2CSTR ("Real eglSwapBuffers not found"));
        assert (false);
    }

    return ret;
}

#ifdef _MESADEBUG
EGLContext eglCreateContext (EGLDisplay dpy, EGLConfig config, EGLContext share_context, const EGLint* attrib_list) {
    static EGLContext (*_eglCreateContext) (EGLDisplay, EGLConfig, EGLContext, const EGLint*) = nullptr;

    static bool resolved = lookup ("eglCreateContext", reinterpret_cast <uintptr_t&> (_eglCreateContext));

    EGLContext ret = EGL_NO_CONTEXT;

    if (resolved != false) {
        LOG (_2CSTR ("Calling Real eglCreateContext"));

        EGLint _value;
        if (EGL_TRUE != eglGetConfigAttrib (dpy, config, EGL_CONFIG_ID, &_value)) {
            // Error
            LOG (_2CSTR ("Unable to determine EGL_CONFIG_ID"));
        }
        else {
            LOG (_2CSTR ("EGL config : "), config, _2CSTR (" : EGL_CONFIG_ID : "), _value);
        }

        if (EGL_TRUE != eglGetConfigAttrib (dpy, config, EGL_BUFFER_SIZE, &_value)) {
            LOG (_2CSTR ("Unable to determine buffer size"));
        }
        else {
            LOG (_2CSTR ("EGL config : "), config, _2CSTR (" : EGL_BUFFER_SIZE : "), _value);
        }

        if (EGL_TRUE != eglGetConfigAttrib (dpy, config, EGL_ALPHA_SIZE, &_value)) {
            LOG (_2CSTR ("Unable to determine alpha size"));
        }
        else {
            LOG (_2CSTR ("EGL config : "), config, _2CSTR (" : EGL_ALPHA_SIZE : "), _value);
        }

        if (EGL_TRUE != eglGetConfigAttrib (dpy, config, EGL_RED_SIZE, &_value)) {
            LOG (_2CSTR ("Unable to determine red size"));
        }
        else {
            LOG (_2CSTR ("EGL config : "), config, _2CSTR (" : EGL_RED_SIZE : "), _value);
        }

        if (EGL_TRUE != eglGetConfigAttrib (dpy, config, EGL_BLUE_SIZE, &_value)) {
            LOG (_2CSTR ("Unable to determine blue size"));
        }
        else {
            LOG (_2CSTR ("EGL config : "), config, _2CSTR (" : EGL_BLUE_SIZE : "), _value);
        }

        if (EGL_TRUE != eglGetConfigAttrib (dpy, config, EGL_GREEN_SIZE, &_value)) {
            LOG (_2CSTR ("Unable to determine green size"));
        }
        else {
            LOG (_2CSTR ("EGL config : "), config, _2CSTR (" : EGL_GREEN_SIZE : "), _value);
        }

        ret = _eglCreateContext (dpy, config, share_context, attrib_list);
    }
    else {
        LOG (_2CSTR ("Real eglCreateContext not found"));
        assert (false);
    }

    return ret;
}

EGLBoolean eglDestroyContext (EGLDisplay dpy, EGLContext ctx) {
    static EGLBoolean (*_eglDestroyContext) (EGLDisplay, EGLContext) = nullptr;

    static bool resolved = lookup ("eglDestroyContext", reinterpret_cast <uintptr_t&> (_eglDestroyContext));

    EGLBoolean ret = EGL_FALSE;

    if (resolved != false) {

        // EGL (resources) are only marked for deletion.
        // Shared context can still use them

        LOG (_2CSTR ("Calling Real eglDestroyContext"));

        ret = _eglDestroyContext (dpy, ctx);
    }
    else {
        LOG (_2CSTR ("Real eglDestroyContext not found"));
        assert (false);
    }

    return ret;
}

EGLSurface eglCreatePbufferSurface (EGLDisplay dpy, EGLConfig config, const EGLint* attrib_list) {
    static EGLSurface (*_eglCreatePbufferSurface) (EGLDisplay, EGLConfig, const EGLint*) = nullptr;

    static bool resolved = lookup ("eglCreatePbufferSurface", reinterpret_cast <uintptr_t&> (_eglCreatePbufferSurface));

    EGLSurface ret = EGL_NO_SURFACE;

    if (resolved != false) {
        LOG (_2CSTR ("Calling Real eglCreatePbufferSurface"));

        ret = _eglCreatePbufferSurface(dpy, config, attrib_list);
    }
    else {
        LOG (_2CSTR ("Real eglCreatePbufferSurface not found"));
        assert (false);
    }

    return ret;
}

EGLBoolean eglMakeCurrent (EGLDisplay dpy, EGLSurface draw, EGLSurface read, EGLContext ctx) {
    static EGLBoolean (*_eglMakeCurrent) (EGLDisplay, EGLSurface, EGLSurface, EGLContext) = nullptr;

    static bool resolved = lookup ("eglMakeCurrent", reinterpret_cast <uintptr_t&> (_eglMakeCurrent));

    EGLBoolean ret = EGL_FALSE;

    if (resolved != false) {
        LOG (_2CSTR ("Calling Real eglMakeCurrent for surface (draw/read) "), draw, _2CSTR (" / "), read, _2CSTR (" on thread "), syscall (SYS_gettid));

         ret = _eglMakeCurrent (dpy, draw, read, ctx);
    }
    else {
        LOG (_2CSTR ("Real eglMakeCurrent not found"));
        assert (false);
    }

    return ret;
}
#endif

// EGL 1.5 support

EGLDisplay eglGetPlatformDisplay (EGLenum platform, void* native_display, const EGLAttrib* attrib_list) {
    static EGLDisplay (*_eglGetPlatformDisplay) (EGLenum, void*, const EGLAttrib*) = nullptr;

    static bool resolved = lookup ("eglGetPlatformDisplay", reinterpret_cast <uintptr_t&> (_eglGetPlatformDisplay));

    EGLDisplay ret = EGL_NO_DISPLAY;

    if (resolved != false) {

        LOG (_2CSTR ("Calling Real eglGetPlatformDisplay"));

        ret = _eglGetPlatformDisplay (platform, native_display, attrib_list);

        static_assert (EGL_PLATFORM_GBM_KHR == EGL_PLATFORM_GBM_MESA);

        if (ret != EGL_NO_SURFACE && platform == EGL_PLATFORM_GBM_KHR) {

            LOG (_2CSTR ("Detected GBM platform, hence, native_display is of gbm_device_t"));

//            static_assert (std::is_pointer <EGLNativeDisplayType>::value != false);
            if (Platform:: Instance ().Add (ret, reinterpret_cast <EGLNativeDisplayType> (native_display)) != false) {
                // Hand over the result
            }
            else {
                // Probably already added but not / never removed
                assert (false);
            }
        }

        ret = _eglGetPlatformDisplay (platform, native_display, attrib_list);
    }
    else {
        LOG (_2CSTR ("Real eglGetPlatformDisplay not found"));
        assert (false);
    }

    return ret;
}

EGLSurface eglCreatePlatformWindowSurface (EGLDisplay dpy, EGLConfig config, void* native_window, const EGLAttrib* attrib_list) {
    static EGLSurface (*_eglCreatePlatformWindowSurface) (EGLDisplay, EGLConfig, void*, const EGLAttrib*) = nullptr;

    static bool resolved = lookup ("eglCreatePlatformCreateWindowSurface", reinterpret_cast <uintptr_t&> (_eglCreatePlatformWindowSurface));

    EGLSurface ret = EGL_NO_SURFACE;

    if (resolved != false) {

        LOG (_2CSTR ("Calling Real eglCreatePlatformWindowSurface"));

        ret = _eglCreatePlatformWindowSurface (dpy, config, native_window, attrib_list);

        if (ret != EGL_NO_SURFACE && Platform::Instance ().isGBMsurface ( reinterpret_cast <EGLNativeWindowType> (native_window) ) != false) {

            LOG (_2CSTR ("Detected GBM platform, hence, native_window is of gbm_surface_t"));

//            static_assert (std::is_pointer <EGLNativeWindowType>::value != false);
            if (Platform::Instance ().Add (dpy, ret, reinterpret_cast <EGLNativeWindowType> (native_window)) != false) {
                // Hand over the result
            }
            else {
                // Probably already added but not / never removed
                assert (false);
            }
        }
    }
    else {
        LOG (_2CSTR ("Real eglCreatePlatformWindowSurface not found"));
#ifndef _MESADEBUG
        assert (false);
#endif
    }

    return ret;
}
