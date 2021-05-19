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

/*
Just a multi-process exmaple of DMA supported buffer sharing. One process
acts as the mode setter and it does the scan out, whereas the other process
does some GLESv2 supported rendering.

There is much room for improvement!
*/

#include <string>
#include <cstring>
#include <ios>
#include <iostream>
#include <limits>
#include <cmath>
#include <type_traits>
#include <atomic>

#ifdef __cplusplus
extern "C" {
#endif

#include <unistd.h>
#include <drm/drm_fourcc.h>
#include <xf86drm.h>
#include <xf86drmMode.h>
#include <EGL/egl.h>
#include <GLES2/gl2.h>
#include <fcntl.h>
#include <gbm.h>

#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>

#ifdef __cplusplus
}
#endif

struct configuration {
    struct drm {
        std::string path;
        int32_t fd;
        uint32_t fb;
        uint32_t crtc;
        uint32_t connectors;
    } drm;

    struct gbm {
        struct gbm_device* dev;
        struct gbm_surface* surf;
        struct gbm_bo* bo;
        int32_t prime;
    } gbm;

    struct egl {
        EGLDisplay dpy;
        EGLConfig cfg;
        EGLContext ctx;
        EGLSurface surf;
    } egl;
};

static constexpr decltype (configuration::drm::fd) InvalidDRMfd () {
    return -1;
}

static constexpr decltype (configuration::drm::fb) InvalidDRMfb () {
    return 0;
}

static constexpr decltype (configuration::gbm::dev) InvalidGBMdev () {
    return nullptr;
}

static constexpr decltype (configuration::gbm::surf) InvalidGBMsurf () {
    return nullptr;
}

static constexpr decltype (configuration::gbm::bo) InvalidGBMbo () {
    return nullptr;
}

static constexpr decltype (configuration::gbm::prime) InvalidGBMprime () {
    return -1;
}

static constexpr uint32_t ColorFormat ()
{
    static_assert (sizeof (uint32_t) >= sizeof (DRM_FORMAT_XRGB8888));
    static_assert (sizeof (uint32_t) >= sizeof (DRM_FORMAT_ARGB8888));

    static_assert (std::numeric_limits <decltype (DRM_FORMAT_XRGB8888)>::min () >= std::numeric_limits <uint32_t>::min ());
    static_assert (std::numeric_limits <decltype (DRM_FORMAT_XRGB8888)>::max () <= std::numeric_limits <uint32_t>::max ());

    static_assert (std::numeric_limits <decltype (DRM_FORMAT_ARGB8888)>::min () >= std::numeric_limits <uint32_t>::min ());
    static_assert (std::numeric_limits <decltype (DRM_FORMAT_ARGB8888)>::max () <= std::numeric_limits <uint32_t>::max ());

    // Formats might not be truly interchangeable
//    static_assert (DRM_FORMAT_XRGB8888 == DRM_FORMAT_ARGB8888);

    return static_cast <uint32_t> (DRM_FORMAT_ARGB8888);
}

// Just hardcoded for simplicity
static constexpr uint32_t Width () {
    return 1920;
}

// Just hardcoded for simplicity
static constexpr uint32_t Height () {
    return 1080;
}

// Wait until the scan out happens
static constexpr uint8_t FrameDurationMax () {
    return 1;
}

// Message size
static constexpr uint8_t Length () {
    return 255;
}

// See ReadKey
static constexpr char Delim () {
    return '\n';
}

// Only for the Parent
static auto FindModeSet (struct configuration& settings) -> uint32_t {
    uint32_t _ret = 0; // Available sets

    drmModeResPtr _res = drmModeGetResources (settings.drm.fd);

    if (_res != nullptr) {
        for (int i = 0; i < _res->count_connectors; i++) {
            // Do not probe
            drmModeConnectorPtr _con = drmModeGetConnectorCurrent (settings.drm.fd, _res->connectors[i]);

            if (_con != nullptr) {
                // Only consider HDMI
                if ( (_con->connector_type == DRM_MODE_CONNECTOR_HDMIA  || \
                      _con->connector_type == DRM_MODE_CONNECTOR_HDMIB) && \
                      DRM_MODE_CONNECTED == _con->connection) {

                    // Encoder currently connected to
                    drmModeEncoderPtr _enc = drmModeGetEncoder (settings.drm.fd, _con->encoder_id);

                    if (_enc != nullptr) {
                        settings.drm.crtc = _enc->crtc_id;
                        settings.drm.connectors = _con->connector_id;

                        ++_ret;

                        drmModeFreeEncoder (_enc);
                    }
                }

                drmModeFreeConnector (_con);
            }

            // For now, do not considerer multiple viable options
            if (_ret > 0) {
                break;
            }
        }

        drmModeFreeResources (_res);
    }
    else {
        _ret = 0;
    }

    return _ret;
}

// Only for the Parent
static auto ScanOut (struct configuration settings) -> bool {
    bool _ret = false;

    uint32_t _width = gbm_bo_get_width (settings.gbm.bo);
    uint32_t _height = gbm_bo_get_height (settings.gbm.bo);
    uint32_t _format = gbm_bo_get_format (settings.gbm.bo);
    uint32_t _bpp = gbm_bo_get_bpp (settings.gbm.bo);
    uint32_t _handle = gbm_bo_get_handle (settings.gbm.bo).u32;
    uint32_t _stride = gbm_bo_get_stride (settings.gbm.bo);

    if (settings.drm.fb != InvalidDRMfb ()) {
        /* void */ drmModeRmFB (settings.drm.fd, settings.drm.fb);
        settings.drm.fb = InvalidDRMfb ();
    }

    if (drmModeAddFB (settings.drm.fd, _width, _height, _format != ColorFormat () ? _bpp - 8 : _bpp, _bpp, _stride, _handle, &settings.drm.fb) == 0) {
        static std::atomic <bool> _callback_data (true);

        int _err = drmModePageFlip (settings.drm.fd, settings.drm.crtc, settings.drm.fb, DRM_MODE_PAGE_FLIP_EVENT, &_callback_data);

        switch (0 - _err) {
            case 0      :   {
                                // Strictly speaking c++ linkage and not C linkage
                                auto handler = +[] (int fd, unsigned int frame, unsigned int sec, unsigned int usec, void* data) {
                                    if (data != nullptr) {
                                        decltype (_callback_data) * _data = reinterpret_cast <decltype (_callback_data) *> (data);
                                        *_data = false;
                                    }
                                    else {
                                        std::cout << "Error: invalid callback data" << std::endl;
                                    }
                                };

                                // Use the magic constant here because the struct is versioned!
                                drmEventContext _context = { .version = 2, . vblank_handler = nullptr, .page_flip_handler = handler };

                                bool _waiting = _callback_data;

                                fd_set _fds;

                                struct timespec _timeout = { .tv_sec = FrameDurationMax (), .tv_nsec = 0 };

                                while (_waiting != false) {
                                    FD_ZERO (&_fds);
                                    FD_SET (settings.drm.fd, &_fds);

                                    _err  = pselect (settings.drm.fd + 1, &_fds, nullptr, nullptr, &_timeout, nullptr);

                                    if (_err < 0) {
                                            break;
                                    }
                                    else {
                                        if (_err == 0) {
                                            // Timeout; retry
                                        }
                                        else { // ret > 0
                                            if (FD_ISSET (settings.drm.fd, &_fds) != 0) {
                                                if (drmHandleEvent (settings.drm.fd, &_context) != 0) {
                                                    _ret = false;
                                                    break;
                                                }

                                                _ret = true;
                                            }
                                        }
                                    }

                                    _waiting = _callback_data;
                                }

                                break;
                            }
            case EINVAL :
                            {   // Probably a missing drmModeSetCrtc or an invalid _crtc
                                drmModeCrtcPtr _ptr = drmModeGetCrtc (settings.drm.fd, settings.drm.crtc);

                                if (_ptr != nullptr) {
                                    constexpr uint32_t _count = 1;

                                    _ret = drmModeSetCrtc (settings.drm.fd, settings.drm.crtc, settings.drm.fb, _ptr->x, _ptr->y, &settings.drm.connectors, _count, &_ptr->mode) == 0;

                                    drmModeFreeCrtc (_ptr);
                                }

                                break;
                            }
            case EBUSY  :
            default     :
                            {
                                // There is nothing to be done about it
                            }
        }
    }
    else {
        _ret = false;
    }

    return _ret;
}

bool ReadKey (std::string const & message, char& key) {
    bool _ret = false;

    if (message.size () > 0) {
        std::cout << message << std::endl;
    }
    else {
        std::cout << "Press key" << std::endl;
    }

    char _str [Length ()];

    std::cin.getline (_str, Length (), Delim ());

    switch (std::cin.rdstate ()) {
        case        std::ios::goodbit   :
                                            switch (std::cin.gcount ()) {
                                                case    2   :
                                                                key = _str [0];
                                                                _ret = true;
                                                                break;
                                                default     :
                                                                _ret = false;
                                            }
                                            break;
        case        std::ios::eofbit    :;
        case        std::ios::failbit   :;
        case        std::ios::badbit    :;
        default                         :
                                            _ret = false;
    }

//    std::cin.clear( );

    return _ret;
}

bool Clear (struct configuration& settings) {
    bool _ret = true;
//    settings.drm.path.clear ();

    settings.drm.fd = InvalidDRMfd ();
    settings.drm.fb = InvalidDRMfb ();
    settings.drm.crtc = 0;
    settings.drm.connectors = 0;

    settings.gbm.dev = InvalidGBMdev ();
    settings.gbm.surf = InvalidGBMsurf ();
    settings.gbm.bo = InvalidGBMbo ();
    settings.gbm.prime = InvalidGBMprime ();

    settings.egl.dpy = EGL_NO_DISPLAY;
    settings.egl.surf = EGL_NO_SURFACE;
    settings.egl.ctx = EGL_NO_CONTEXT;

    return _ret;
}

// Parent and child are set up the same way!
bool Init (struct configuration& settings) {
    bool _ret = false;

    if (Clear (settings) != false && drmAvailable () > 0) {

        settings.drm.fd = (settings.drm.path.size () > 0 ? open (settings.drm.path.c_str () , O_RDWR) : InvalidDRMfd ());

        settings.gbm.dev = (settings.drm.fd != InvalidDRMfd () ? gbm_create_device (settings.drm.fd) : InvalidGBMdev ());

        settings.gbm.surf = (settings.gbm.dev != nullptr ? gbm_surface_create (settings.gbm.dev, Width (), Height (), ColorFormat (), GBM_BO_USE_SCANOUT /* presented on a screen */ | GBM_BO_USE_RENDERING /* used for rendering */) : nullptr );

        if (settings.gbm.surf != InvalidGBMsurf ()) {

            settings.egl.dpy = eglGetDisplay (settings.gbm.dev);

            if (settings.egl.dpy == EGL_NO_DISPLAY) {
                // Error
                std::cout << "Error: eglGetDisplay (0x" << std::hex << eglGetError () << ")" << std::endl;
            }

            EGLint _major, _minor;
            if (eglInitialize (settings.egl.dpy, &_major, &_minor) != EGL_TRUE) {
                // Error
                std::cout << "Error: eglInitialize (0x" << std::hex << eglGetError () << ")" << std::endl;
            }

            if (eglBindAPI (EGL_OPENGL_ES_API) != EGL_TRUE) {
                // Error
                std::cout << "Error: eglBindAPI (0x" << std::hex << eglGetError () << ")" << std::endl;
            }

            const EGLint _ecfg_attr [] = {
                EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
                EGL_RENDERABLE_TYPE, EGL_OPENGL_ES2_BIT,
                EGL_RED_SIZE, 8,
                EGL_RED_SIZE, 8,
                EGL_RED_SIZE, 8,
                EGL_ALPHA_SIZE, 8,
                EGL_NONE
            };

            EGLint _count = 1;
            if (eglChooseConfig (settings.egl.dpy, _ecfg_attr, &(settings.egl.cfg), _count, &_count) != EGL_TRUE) {
                // Error
                std::cout << "Error: eglChooseConfig (0x" << std::hex << eglGetError () << ")" << std::endl;
            }

            const EGLint _ectx_attr [] = {
                EGL_CONTEXT_CLIENT_VERSION, 2,
                EGL_NONE
            };

            settings.egl.ctx = eglCreateContext (settings.egl.dpy, settings.egl.cfg, EGL_NO_CONTEXT, _ectx_attr);
            if (settings.egl.ctx == EGL_NO_CONTEXT) {
                // Error
                std::cout << "Error: eglCreateContex (0x" << std::hex << eglGetError () << ")" << std::endl;
            }

            settings.egl.surf = eglCreateWindowSurface (settings.egl.dpy, settings.egl.cfg, reinterpret_cast <EGLNativeWindowType> (settings.gbm.surf), nullptr);
            if (settings.egl.surf == EGL_NO_SURFACE) {
                // Error
                std::cout << "Error: eglCreateWindowSurface (0x" << std::hex << eglGetError () << ")" << std::endl;
            }

            EGLint _err = EGL_SUCCESS;

            if (eglMakeCurrent (settings.egl.dpy, settings.egl.surf, settings.egl.surf, settings.egl.ctx) != EGL_TRUE) {
                // Error
                _err = eglGetError ();
                std::cout << "Error: eglMakeCurrent (0x" << std::hex << _err << ")" << std::endl;
            }

            _ret = _err == EGL_SUCCESS;
        }
        else {
            _ret = false;
        }
    }

    return _ret;
}

bool Deinit (struct configuration& settings) {
    bool _ret = true;

    if (eglMakeCurrent (settings.egl.dpy, settings.egl.surf, settings.egl.surf, settings.egl.ctx) != EGL_TRUE) {
        // Error
        _ret = false;
    }

    if (eglTerminate (settings.egl.dpy) != EGL_FALSE) {
        // Error
        _ret = false;
    }

    if (settings.gbm.surf != InvalidGBMsurf ()) {
        gbm_surface_destroy (settings.gbm.surf);
        settings.gbm.surf = InvalidGBMsurf ();
    }

    if (settings.gbm.dev != InvalidGBMdev ()) {
        gbm_device_destroy (settings.gbm.dev);
        settings.gbm.dev = InvalidGBMdev ();;
    }

    if (settings.drm.fd == InvalidDRMfd ()) {
        // Error
        _ret = false;
    }
    else {
        _ret = close (settings.drm.fd) == 0;
        settings.drm.fd = InvalidDRMfd ();
    }

    return _ret && Clear (settings);
}

// Write data and an optional file descriptor
// TODO: const
ssize_t SendFd (int sock, uint8_t /*const*/ buf [], size_t bufsize, int fd) {
    // Scatter array for vector I/O
    struct iovec _iov;

    // Starting address
    _iov.iov_base = reinterpret_cast <void *> (buf);
    // Number of bytes to transfer
    _iov.iov_len = bufsize;

    // Actual message
    struct msghdr _msgh = {0};

    // Optional address
    _msgh.msg_name = nullptr;
    // Size of address
    _msgh.msg_namelen = 0;
    // Elements in msg_iov
    _msgh.msg_iovlen = 1;
    // Scatter array
    _msgh.msg_iov = &_iov;


    // Ancillary data
    // The macro returns the number of bytes an ancillary element with payload of the passed in data length, eg size of ancillary data to be sent
    char _control [CMSG_SPACE (sizeof ( decltype (fd) ))];

    bool _valid = false;

    if (fd != InvalidDRMfd ()) {
        // Contruct ancillary data to be added to the transfer via the control message

        // Ancillary data, pointer
         _msgh.msg_control = _control;

        // Ancillery data buffer length
        _msgh.msg_controllen = sizeof ( _control );

        // Ancillary data should be access via cmsg macros
        // https://linux.die.net/man/2/recvmsg
        // https://linux.die.net/man/3/cmsg
        // https://linux.die.net/man/2/setsockopt
        // https://www.man7.org/linux/man-pages/man7/unix.7.html

        // Control message

        // Pointer to the first cmsghdr in the ancillary data buffer associated with the passed msgh
        struct cmsghdr* _cmsgh = CMSG_FIRSTHDR (&_msgh);

        if (_cmsgh != nullptr) {
            // Originating protocol
            // To manipulate options at the sockets API level
            _cmsgh->cmsg_level = SOL_SOCKET;

            // Protocol specific type
            // Option at the API level, send or receive a set of open file descriptors from another process
            _cmsgh->cmsg_type = SCM_RIGHTS;

            // The value to store in the cmsg_len member of the cmsghdr structure, taking into account any necessary alignmen, eg byte count of control message including header
            _cmsgh->cmsg_len = CMSG_LEN (sizeof ( decltype (fd) ));

            // Initialize the payload
            // Pointer to the data portion of a cmsghdr, ie unsigned char []
            * reinterpret_cast < decltype (fd) * > ( CMSG_DATA (_cmsgh) ) = fd;

            _valid = true;
        }
        else {
            // Error
            _valid = false;
        }
    } else {
        // No extra payload, ie  file descriptor(s), to include
        _msgh.msg_control = nullptr;
        _msgh.msg_controllen = 0;

        _valid = true;
    }

    ssize_t _size = -1;

    if (_valid != false) {
        // https://linux.die.net/man/2/sendmsg
        // https://linux.die.net/man/2/write
        // Zero flags is equivalent to write
        _size = sendmsg (sock, &_msgh, 0);

        if (_size < 0) {
            // Error
            std::cout << "Error: sendmsg (" << strerror (errno) << ")" << std::endl;
        }
    }
    else {
        _size = -1;
    }

    return _size;
}

// Receive data and an optional file descriptor
ssize_t ReceiveFd (int sock, uint8_t /*const*/ buf [], size_t bufsize, int* fd) {
    // Scatter array for vector I/O
    struct iovec _iov;

    // Starting address
    _iov.iov_base = reinterpret_cast <void *> (buf);
    // Number of bytes to transfer
    _iov.iov_len = bufsize;


    // Actual message
    struct msghdr _msgh = {0};

    // Optional address
    _msgh.msg_name = nullptr;
    // Size of address
    _msgh.msg_namelen = 0;
    // Elements in msg_iov
    _msgh.msg_iovlen = 1;
    // Scatter array
    _msgh.msg_iov = &_iov;


    // Ancillary data
    // The macro returns the number of bytes an ancillary element with payload of the passed in data length, eg size of ancillary data to be sent
    char _control [CMSG_SPACE (sizeof ( decltype (* fd) ))];

    // Ancillary data, pointer
    _msgh.msg_control = _control;

    // Ancillery data buffer length
    _msgh.msg_controllen = sizeof (_control);


    size_t _size = -1;

    bool _valid = false;

    if (fd != nullptr) {
        // Expecting message with extra paylod

        // No flags set
        _size = recvmsg (sock, &_msgh, 0);

        if (_size >= 0) {

            // Pointer to the first cmsghdr in the ancillary data buffer associated with the passed msgh
            struct cmsghdr* _cmsgh = CMSG_FIRSTHDR( &_msgh);

            // Check for the expected properties the client should have set

            if (_cmsgh != nullptr) {
                _valid = true;

                _valid = _cmsgh->cmsg_len == CMSG_LEN (sizeof (decltype (* fd) ));

                if (_cmsgh->cmsg_level != SOL_SOCKET) {
                    _valid = false;
                }

                if (_cmsgh->cmsg_type != SCM_RIGHTS) {
                    _valid = false;
                }

                if (_valid != false) {
                    // The macro returns a pointer to the data portion of a cmsghdr.
                    * fd  = * reinterpret_cast < decltype (fd) > ( CMSG_DATA (_cmsgh) );

                    _valid = true;
                }
                else {
                    *fd = InvalidDRMfd ();
                    _valid = false;
                }
            }
            else {
                _valid = false;
            }
        }
        else {
            // Error
            std::cout << "Error: recvmsg (" << strerror (errno) << ")" << std::endl;
        }

    }
    else {
        // Expecting just a regular message wihout payload

        _size = read (sock, buf, bufsize);

        if (_size < 0) {
            // Error
            std::cout << "Error: read (" << strerror (errno) << ")" << std::endl;
        }

    }

    if (_valid != true) {
        _size = -1;
    }

    return _size;
}

bool ImportBOFromFD (struct configuration& settings) {
    bool _ret = false;

    if (settings.gbm.prime != InvalidGBMprime ()) {

        struct gbm_import_fd_data _frame = {settings.gbm.prime /* fd */, Width () /* width */ , Height () /* height */, 7680 /* stride */, ColorFormat () /* format */};

        settings.gbm.bo = gbm_bo_import (settings.gbm.dev, GBM_BO_IMPORT_FD, &_frame, GBM_BO_USE_SCANOUT);

        _ret = settings.gbm.bo != InvalidGBMbo ();
    }

    return _ret;
}

// Just the renderer, eg, the client
void Child (int sock) {
    // It alsmost could not get simpler
    auto BufferColorFill = [] (float degree) -> bool {
        bool _ret = false;

        constexpr float OMEGA = 3.14159265 / 180;

        // Here, for C(++) these type should be identical
        // Type information: https://www.khronos.org/opengl/wiki/OpenGL_Type
        static_assert (std::is_same <float, GLfloat>::value);

        GLfloat _rad = static_cast <GLfloat> (cos (degree * OMEGA));

        // The function clamps the input to [0, 1]
        /* void */ glClearColor (_rad, _rad, _rad, 1.0);

        _ret = glGetError () == GL_NO_ERROR;

        if (_ret != false) {
            /* void */ glClear (GL_COLOR_BUFFER_BIT);
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false) {
            /* void */ glFlush ();
            _ret = glGetError () == GL_NO_ERROR;
        }

        return _ret;
    };


    struct configuration _settings;

    // Not all combinations with the Parent's node might be supported
//    _settings.drm.path = "/dev/dri/card10";
    _settings.drm.path = "/dev/dri/card1";
//    _settings.drm.path = "/dev/dri/renderD128";


    if (Init (_settings) != false && _settings.drm.fd != InvalidDRMfd ()) {

        if (drmIsMaster (_settings.drm.fd) != 0 && drmDropMaster (_settings.drm.fd) != 0) {
            std::cout << "Error: unable to drop master" << std::endl;
        }

        char key = ' ';

        // EGL and GLESv2 use float
        static_assert (std::numeric_limits <uint16_t>::max () <= std::numeric_limits <float>::max ());
        uint16_t _degree = 0;

        while (ReadKey ("Press 'c' to create a buffer to be sent, 'Enter' or 'q' to quit", key) != false && key != 'q') {

            if (key != 'c') {
                continue;
            }

            constexpr uint16_t ROTATION = 360;
            constexpr uint16_t DELTA = 10;

            _degree = (_degree + DELTA) % ROTATION;

            if (BufferColorFill (_degree) != true || eglSwapBuffers (_settings.egl.dpy, _settings.egl.surf) != EGL_TRUE) {
                // Error
                std::cout << "Error: eglSwapBuffers (0x" << std::hex << eglGetError () << ")" << std::endl;
            }
            else {

                if (_settings.gbm.bo != InvalidGBMbo ()) {
                    /* void */ gbm_surface_release_buffer (_settings.gbm.surf, _settings.gbm.bo);
                    _settings.gbm.bo = InvalidGBMbo ();
                }

#ifdef _0
                std::cout << "gbm_surface_has_free_buffers :" << gbm_surface_has_free_buffers (_settings.gbm.surf) << std::endl;
#endif

                // Only after a swap this API is defined, prepare for a segfault otherwise
                _settings.gbm.bo = gbm_surface_lock_front_buffer (_settings.gbm.surf);


                if (_settings.gbm.bo != InvalidGBMbo ()) {
                    // Export the GEM object

#ifdef _0
// TODO: export properties
                    std::cout << "stride " << gbm_bo_get_stride (_settings.gbm.bo) << std::endl;
                    std::cout << "height " << gbm_bo_get_height (_settings.gbm.bo) << std::endl;
                    std::cout << "width " << gbm_bo_get_width (_settings.gbm.bo) << std::endl;
                    std::cout << "format " << gbm_bo_get_format (_settings.gbm.bo) << std::endl;
#endif

                    if (_settings.gbm.prime != InvalidGBMprime ()) {
                        if (close (_settings.gbm.prime) < 0) {
                            std::cout << "Error: prime cannot be closed (" << strerror (errno) << ")" << std::endl;
                        }
                    }

                    _settings.gbm.prime = gbm_bo_get_fd (_settings.gbm.bo);

                    // Exports a dma-buf.
                    if (_settings.gbm.prime == InvalidGBMprime ()) {
                        std::cout << "Error: cannot create prime (" << strerror (errno) << ")" << std::endl;
                    }
                    else {
// TODO: uint8_t, vs char
// last char \0
                        std::string /*const*/ _message ("FD : "); _message.append (std::to_string (_settings.gbm.prime));

                        // Negative size indicates an error
                        /* ssize_t */ SendFd (sock, reinterpret_cast <uint8_t /*const*/ *> (&_message [0]), _message.size (), _settings.gbm.prime);
                    }

                }
                else {
                    std::cout << "Error: unable to lock font buffer" << std::endl;
                }
            }

        }

    }
    else {
        // Error
        std::cout << "Error: unable to initialize." << std::endl;
    }

    /* bool */ Deinit (_settings);
}


// Resposible for mode setting and thus scan out
void Parent (int sock, pid_t child) {
    struct configuration _settings;

    // KMS should be possible
//    _settings.drm.path = "/dev/dri/card10";
    _settings.drm.path = "/dev/dri/card1";

    if (Init (_settings) != false && _settings.drm.fd != InvalidDRMfd () && FindModeSet (_settings) > 0) {

        if (drmIsMaster (_settings.drm.fd) != 1 && drmSetMaster (_settings.drm.fd) != 0) {
            std::cout << "Error: unable to become master" << std::endl;
        }

        while (true) {
            std::string _message (255, '\0');

            if (_settings.gbm.prime != InvalidGBMprime ()) {
                if (close (_settings.gbm.prime) < 0) {
                    std::cout << "Error: prime cannot be closed (" << strerror (errno) << ")" << std::endl;
                }

                _settings.gbm.prime = InvalidGBMprime ();
            }


// TODO: size uint_8, char, and mmax 
            ssize_t _size = ReceiveFd (sock, reinterpret_cast <uint8_t /*const*/ *> (&_message[0]), sizeof (_message.size ()), &_settings.gbm.prime);

            if (_size <= 0) {
                break;
            }
            else {
#ifdef _0
                std::cout << "Message from client : " << _message << " : _prime : " << _settings.gbm.prime << std::endl;
#endif

                if (_settings.drm.fd != InvalidDRMfd ()) {

                    if (_settings.gbm.bo != InvalidGBMbo ()) {
                        /* void */ gbm_bo_destroy (_settings.gbm.bo);

                        _settings.gbm.bo = InvalidGBMbo ();
                    }

                    if (ImportBOFromFD (_settings) != true) {
                        std::cout << "Error: scan out impossible" << std::endl;
                    }
                    else {
                        ScanOut (_settings);
                    }
                }
            }
        }

    }
    else {
        // Error
    }

    /* bool */ Deinit (_settings);
}


int main (int argc, char* argv []) {
// TODO: present user options for entering nodes

    uint8_t _ret = EXIT_FAILURE;

    int _sv [2];

    if (socketpair (AF_LOCAL, SOCK_STREAM, 0, _sv) < 0) {
        std::cout << "Error: socketpair" << std::endl;
    }
    else {
#ifdef DEBUG
        constexpr unsigned int TIMEOUT = 1;
#endif

        pid_t _pid = fork ();

        switch (_pid)  {
            case -1 :{
                        std::cout << "Error: fork" << std::endl;
                        _ret = EXIT_FAILURE;
                        break;
                     }
            case  0 :{
                        bool _flag = true;
#ifdef DEBUG
                        while ( _flag != false ) { sleep ( TIMEOUT ); };
#endif

                        /* int */ close (_sv [0]);
                        /* void */ Child (_sv [1]);
                        _ret = EXIT_SUCCESS;
                        break;
                     }
            default :{
                        bool _flag = true;
#ifdef DEBUG
                        while ( _flag != false ) { sleep ( TIMEOUT ); };
#endif

                        /* int */ close (_sv [1]);
                        /* void */ Parent (_sv [0], _pid);
                        _ret = EXIT_SUCCESS;
                        break;
                     }
        }
    }

    return _ret;
}
