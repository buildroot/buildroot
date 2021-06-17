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
Just a multi-process example of DMA supported buffer sharing. One process
acts as the mode setter and it does the scan out, whereas the other 
processes do some GLESv2 supported rendering.

There is much room for improvement!
*/

#include <string>
#include <cstring>
#include <ios>
#include <iostream>
#include <limits>
#include <cmath>
#include <type_traits>
#include <array>
#include <functional>
#include <atomic>

#ifdef __cplusplus
extern "C" {
#endif

#include <unistd.h>
#include <drm/drm_fourcc.h>
#include <xf86drm.h>
#include <xf86drmMode.h>
#include <EGL/egl.h>
#include <EGL/eglext.h>
#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>
#include <fcntl.h>
#include <gbm.h>

#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>

#ifdef __cplusplus
}
#endif

template <class T>
struct remove_pointer {
    typedef T type;
};

template <class T>
struct remove_pointer <T*> {
    typedef T type;
};

template <class T>
struct remove_pointer <T const *>  {
    typedef T type;
};

template <class T>
struct remove_reference {
    typedef T type;
};

template <class T>
struct remove_reference <T&> {
    typedef T type;
};

template <class T>
struct remove_reference <T const &> {
    typedef T type;
};

template <class T, class U>
struct is_same {
    static constexpr bool value = false;
};

template <class T>
struct is_same <T, T> {
    static constexpr bool value = true;
};

template <class T>
struct remove_const {
    typedef T type;
};

template <class T>
struct remove_const <T const> {
    typedef T type;
};

template< size_t N >
// Address of const array
constexpr size_t length (char const (&) [N]) {
      return N - 1;
}

class DRM {
    public:

        using fb_id_t = remove_pointer < decltype (drmModeFB::fb_id) >::type;
        using crtc_id_t = remove_pointer < decltype (drmModeCrtc::crtc_id) >::type;
        using enc_id_t = remove_pointer < decltype (drmModeEncoder::encoder_id) >::type;
        using conn_id_t = remove_pointer < decltype (drmModeConnector::connector_id) >::type;

        using width_t = remove_pointer < decltype (drmModeFB2::width) >::type;
        using height_t = remove_pointer < decltype (drmModeFB2::height) >::type;
        using frmt_t = remove_pointer < decltype (drmModeFB2::pixel_format) >::type;
//        using mod_t = remove_pointer < decltype (drmModeFB2::modifier) >::type;
        using pitch_t = remove_pointer < std::decay < decltype (drmModeFB2::pitches) >::type >::type;
        using handle_t = remove_pointer < std::decay < decltype (drmModeFB2::handles) >::type >::type;

// TODO: absent in FB2
        using bpp_t = remove_pointer < decltype (drmModeFB::bpp) >::type;

        using x_t = remove_pointer < decltype (drmModeCrtc::x) >::type;
        using y_t = remove_pointer < decltype (drmModeCrtc::y) >::type;

        using duration_t = remove_pointer < decltype (timespec::tv_sec) >::type;

        static_assert (is_same < fb_id_t, remove_pointer < decltype (drmModeFB2::fb_id) >::type >::value != false);

    private :

        bool const _priv;

        std::string const _path;

        int32_t _fd;

        fb_id_t _fb;
        crtc_id_t _crtc;
        enc_id_t _enc;
        conn_id_t _conn;

        width_t _width;
        height_t _height;
        frmt_t _frmt;

        x_t _x;
        y_t _y;

        bool const _valid;

    public :

        using priv_t = decltype (_priv);
        using path_t = decltype (_path);
        using fd_t = decltype (_fd);
        using valid_t = decltype (_valid);

        // GBM higly depends on DRM and vice versa
        class GBM {

            public :
                using fd_t = remove_pointer < decltype (gbm_import_fd_data::fd) >::type;

                using width_t = remove_pointer < decltype (gbm_import_fd_data::width) >::type;
                using height_t = remove_pointer < decltype (gbm_import_fd_data::height) >::type;
                using stride_t = remove_pointer < decltype (gbm_import_fd_data::stride) >::type;
                using frmt_t = remove_pointer < decltype (gbm_import_fd_data::format) >::type const;

                using dev_t = struct gbm_device *;
                using surf_t = struct  gbm_surface *;
                using buf_t = struct gbm_bo *;

                using handle_t = decltype (gbm_bo_handle::u32);

            private :

                fd_t const _fd;

                dev_t _dev;
                surf_t _surf;
                buf_t _buf;

                struct prime {
                    buf_t _buf;
                    fd_t _fd;

                    width_t _width;
                    height_t _height;

//                    std::function < width_t () > Width = [this] () { return this->_width; };
//                    std::function < height_t () > Height = [this] () { return this->_height; };

                    stride_t _stride;
//                    frmt_t _frmt;

                    bool operator != (struct prime const & rhs) const { return /*_buf != rhs._buf || */ _fd != rhs._fd /* _width != InvalidWidth () || _height != InvalidHeight () */; }
                } _prime;

                width_t const _width;
                height_t const _height;
                stride_t _stride;
                frmt_t _frmt;

                static_assert (is_same <decltype (GBM_BO_USE_SCANOUT), decltype (GBM_BO_USE_RENDERING)>::value != false);

                static_assert (sizeof (gbm_bo_flags) >= sizeof (decltype (GBM_BO_USE_SCANOUT)));
                static_assert (std::numeric_limits < decltype (GBM_BO_USE_SCANOUT) >::min () >= std::numeric_limits < gbm_bo_flags >::min ());
                static_assert (std::numeric_limits < decltype (GBM_BO_USE_SCANOUT) >::max () <= std::numeric_limits < gbm_bo_flags >::max ());

                static constexpr gbm_bo_flags _flags = static_cast <gbm_bo_flags> (GBM_BO_USE_SCANOUT | GBM_BO_USE_RENDERING);

                bool const _valid;

            public:

                using prime_t = decltype (_prime);
                using _valid_t = decltype (_valid);

                using flags_t = decltype (_flags);

                using valid_t = decltype (_valid);

                using bpp_t = decltype (gbm_bo_get_bpp (_buf)); 

                static_assert (is_same <fd_t, DRM::fd_t>::value != false);

                GBM () = delete;
                explicit GBM (DRM::fd_t const & fd, width_t width, height_t height, frmt_t frmt) : _fd {fd}, _width {width}, _height {height}, _frmt {frmt}, _valid {Init ()} {}
                ~GBM () { /* bool */ Deinit (); }

                // DRM provides a reference, so be careful with local copies that go out of scope
                GBM (GBM const &) = delete;
                GBM & operator = (GBM const &) = delete;

                static constexpr dev_t InvalidDev () { return nullptr; }
                static constexpr surf_t InvalidSurf () { return nullptr; }
                static constexpr buf_t InvalidBuf () { return nullptr; }
                static constexpr fd_t InvalidFd () { return -1; }
                static constexpr prime_t InvalidPrime () { return { InvalidBuf (), InvalidFd (), InvalidWidth (), InvalidHeight (), InvalidStride () /*, InvalidFrmt () */ }; }

                static constexpr width_t InvalidWidth () { return 0; }
                static constexpr height_t InvalidHeight () { return 0; }
                static constexpr stride_t InvalidStride () { return 0; }
                static constexpr frmt_t InvalidFrmt () { return 0; }

                valid_t const Status () const { return _valid; }

                dev_t const & Device () const { return _dev; }
                surf_t const & Surface () const { return _surf; }

                buf_t const & Buffer () const { return _buf; }
                prime_t const & Prime () const { return _prime; }

                width_t const Width () const { return _width; }

                static width_t const Width (buf_t const & buf) { return buf != DRM::GBM::InvalidBuf () ? gbm_bo_get_width (buf) : DRM::GBM::InvalidWidth (); }

                height_t const Height () const { return _height; }

                static height_t const Height (buf_t const & buf) { return buf != DRM::GBM::InvalidBuf () ? gbm_bo_get_height (buf) : DRM::GBM::InvalidHeight (); }

                frmt_t const Format () const { return _frmt; }

                stride_t const Pitch () const { return _stride; }
                // Taken from plane 0
                static stride_t const Pitch (buf_t const buf) { return buf != DRM::GBM::InvalidBuf () ? gbm_bo_get_stride (buf) : DRM::GBM::InvalidHeight (); }

                // Lock / unlock scan out buffer for access
                bool Lock ();
                bool Unlock ();

                bool CreatePrime ();
                bool ImportPrime (prime_t const & prime);
                bool DestroyPrime ();

            private :

                bool Clear ();

                bool Init ();
                bool Deinit ();

                bool CreateBuffer ();
                bool DestroyBuffer ();
        };

        DRM () = delete;
// TODO: allow more GPUs
        explicit DRM (bool priv = false) : _priv {priv}, _path {(_priv != true ? "/dev/dri/renderD128" : "/dev/dri/card1")}, _fd {InvalidFd ()}, _valid {Init ()}, _gbm {_fd, (_priv != false ? _width : DefaultWidth ()), (_priv != false ? _height : DefaultHeight ()), ColorFormat ()} {}
        ~DRM () { /* bool */ Deinit (); }

        static constexpr fd_t InvalidFd () { return GBM::InvalidFd (); }
        static constexpr fb_id_t  InvalidFb () { return  0; }
        static constexpr crtc_id_t InvalidCrtc () { return 0; }
        static constexpr enc_id_t InvalidEncoder () { return 0; }
        static constexpr conn_id_t InvalidConnector () { return 0; }

        static constexpr width_t InvalidWidth () { return 0; }
        static constexpr height_t InvalidHeight () { return 0; }
//        static constexpr frm_t InvalidFrmt () { return 0; }

        // Especially, required for headless / off-screen without a mode set
// TODO: instead of default communicated values and use in  platform initialization
        static constexpr width_t DefaultWidth () { return 1920; }
        static constexpr height_t DefaultHeight () { return 1080; }

// TODO: match FB and gbm_bo
// TODO: configurable GBM format
        static constexpr uint32_t ColorFormat () {
            static_assert (sizeof (uint32_t) >= sizeof (DRM_FORMAT_XRGB8888));
            static_assert (sizeof (uint32_t) >= sizeof (DRM_FORMAT_ARGB8888));

            static_assert (std::numeric_limits <decltype (DRM_FORMAT_XRGB8888)>::min () >= std::numeric_limits <uint32_t>::min ());
            static_assert (std::numeric_limits <decltype (DRM_FORMAT_XRGB8888)>::max () <= std::numeric_limits <uint32_t>::max ());

            static_assert (std::numeric_limits <decltype (DRM_FORMAT_ARGB8888)>::min () >= std::numeric_limits <uint32_t>::min ());
            static_assert (std::numeric_limits <decltype (DRM_FORMAT_ARGB8888)>::max () <= std::numeric_limits <uint32_t>::max ());

            // Formats might not be truly interchangeable
            // static_assert (DRM_FORMAT_XRGB8888 == DRM_FORMAT_ARGB8888);

            return static_cast <uint32_t> (DRM_FORMAT_ARGB8888);
        }

        static constexpr duration_t FrameDurationMax () { return 1; }

        width_t const Width () { return _width; }
        height_t const height () { return _height; }
// TODO: initialize at construction
        frmt_t const format () { return _frmt != false ? _frmt : ColorFormat (); }

        bool Status () const { return _valid && _gbm.Status (); }

        GBM /*const*/ & Get () { return _gbm; }

        // Scan out the internal buffer
        bool ScanOut ();
        // Scan out the specified buffer
        bool ScanOut (GBM::buf_t & buf);

    private :

        GBM _gbm;

        bool Clear ();

        bool Init ();
        bool Deinit ();

        bool ValidModeSet ();
};

class EGL {
    private :

        DRM::GBM /*const*/ & _gbm;

        EGLDisplay _dpy;
        EGLConfig _cfg;
        EGLContext _ctx;
        EGLSurface _surf;

        struct img {
            EGLImageKHR _khr;
            EGLint _width;
            EGLint _height;

            bool operator != (struct img const & rhs) const { return _khr != rhs._khr /*|| _width != rhs._width || _height != rhs._height */;}
        } _img;

        bool const _valid;

    public :

        using dpy_t = decltype (_dpy);
        using cfg_t = decltype (_cfg);
        using ctx_t = decltype (_ctx);
        using surf_t = decltype (_surf);
        using img_t = decltype (_img);

        using valid_t = decltype (_valid);

    public :

        EGL () = delete;
        explicit EGL (DRM::GBM /*const*/ & gbm) : _gbm {gbm}, _valid {Init ()} {}
        ~EGL () { /* bool */ Deinit (); }

        static constexpr dpy_t InvalidDisplay () { return EGL_NO_DISPLAY; }
//        static constexpr cfg_t InvalidConfig () { return EGL_NO_CONFIG; EGL_BAD_CONFIG }
        static constexpr ctx_t InvalidContext () { return EGL_NO_CONTEXT; }
        static constexpr surf_t InvalidSurface () { return EGL_NO_SURFACE; }

        // Possible narrowing
//        using width_t = std::common_type <EGLint, DRM::GBM::width_t>::type;
// TODO: print warning or fail
//        static_assert (is_same < DRM::GBM::width_t, width_t >::value != false);
//        static_assert (is_same < EGLint, width_t >::value != false);

        static constexpr img_t InvalidImage () { return { EGL_NO_IMAGE_KHR, DRM::GBM::InvalidWidth (), DRM::GBM::InvalidHeight ()}; }

//        static_assert (is_same <DRM::GBM::valid_t, valid_t>::value != false);
        valid_t Status () const { return _gbm.Status () && _valid; }

        img_t const & Image () const { return _img; };

        bool ImportBuffer (DRM::GBM::prime_t const & prime);
        bool ImportBuffer (DRM::GBM::buf_t const & buf);

        bool Render ();

    private :

        bool Clear ();

        bool Init ();
        bool Deinit ();
};

class GLES {
    public :

        // x, y, z
        static constexpr uint8_t VerticeDimensions = 3;

    private:

        GLenum const _tgt;
        GLuint _fbo;
        GLuint _tex;

        struct offset {
            using coordinate_t =  float;

            coordinate_t _x;
            coordinate_t _y;
            coordinate_t _z;

            offset () : offset (0.0f, 0.0f, 0.0f) {}
            offset (coordinate_t x, coordinate_t y, coordinate_t z) : _x {x}, _y {y}, _z {z} {}
        } _offset;

        bool const _valid;

    public :

        using tgt_t = decltype (_tgt);
        using fbo_t = decltype (_fbo);
        using tex_t = decltype (_tex);

        using offset_t = decltype (_offset);

        using valid_t = decltype (_valid);

        // Supported texture targets
// TODO: start using
        enum class TARGETS : tgt_t { TEXTURE_2D = GL_TEXTURE_2D, TEXTURE_OES = GL_TEXTURE_EXTERNAL_OES };

    public :

        GLES () = delete;
// TODO limit options to GL_TEXTURE_EXTERNAL_OES and GL_TEXTURE_2D
       explicit  GLES (tgt_t tgt) : _tgt {tgt}, _fbo {InvalidFbo ()}, _tex {InvalidTex ()}, _valid {Init ()} {}
        ~GLES () { /* bool */ Deinit (); };

//        static constexpr fgt_t InvalidTgt () {...}
        static constexpr fbo_t InvalidFbo () { return 0; }
        static constexpr tex_t InvalidTex () { return 0; }

        valid_t Status () const { return _valid; }

        bool RenderTile ();
        bool RenderEGLImage (EGL::img_t const  & img);
        bool BufferColorFill (bool red = true, bool green = true, bool blue = true);

        // Valus used at render stages of different objects
        static offset InitialOffset () { return offset (0.0f, 0.0f, 0.0f); }
        bool UpdateOffset (struct offset const & off);

    private:

        bool Clear ();

        bool Init ();
        bool Deinit ();

        bool SetupProgram ();
};

class Base {
    protected:

        DRM _drm;

        int const & _sv;

        EGL _egl;

        uint8_t const _id;

        bool const _valid;

    public :

        using sv_t = decltype (_sv);

        using id_t = decltype (_id);

        using valid_t = decltype (_valid);

    public :

        Base () = delete;
        // User responsible for unique id
        explicit Base (sv_t const & sv, bool priv, id_t id) : _drm {priv}, _sv {sv},_egl {_drm.Get ()}, _id {id}, _valid {Init ()} {}
        virtual ~Base () {/* bool */ Deinit ();} ;

//        static_assert (is_same <DRM::GBM::valid_t, valid_t>::value != false);
//        static_assert (is_same <EGL::valid_t, valid_t>::value != false);
        valid_t Status () const { return _drm.Status () && _egl.Status () && _valid; }

        virtual bool Run () = 0;

    protected :

//TODO: enum
        bool ShareBuffer (bool mode);

        virtual bool Render () = 0;

        // Message size
        static constexpr uint8_t Length () {
            return 255;
        }

        // See ReadKey
        static constexpr char Delim () { return '\n'; }

        bool ReadKey (std::string const & message, char & key);

        bool Send (std::string const & msg, DRM::GBM::fd_t const & fd);
        bool Receive (std::string & msg, DRM::GBM::fd_t & fd);

    private :

        bool Clear ();

        bool Init ();
        bool Deinit ();
};

class RenderClient : public Base {
    private :

        bool const _priv;

        GLES _gles;

        bool const _valid;

    public :

        using priv_t = decltype (_priv);
        using valid_t = decltype (_valid);

        static_assert (is_same <DRM::priv_t, priv_t>::value != false);
        RenderClient () = delete;
        explicit RenderClient (Base::sv_t const & sv, DRM::priv_t priv, Base::id_t id) : Base {sv, priv, id}, _priv {priv}, _gles {static_cast <GLES::tgt_t> (priv != true ? GL_TEXTURE_2D : GL_TEXTURE_EXTERNAL_OES)}, _valid{Init ()} {}
        virtual ~RenderClient () { /* bool */ Deinit (); };

//        static_assert (is_same <Base::valid_t, valid_t>::value != false);
//        static_assert (is_same <GLES::valid_t, valid_t>::value != false);
        valid_t Status () const { return Base::Status () && _gles.Status () & _valid; }

        bool Run () override;

    private :

        bool Clear ();

        bool Init ();
        bool Deinit ();

        bool ShareBuffer ();

        bool Render () override;
};

// TODO: Only one system wide, within this unit per construction
class Compositor: public Base {
    private :
        bool const _priv;

        GLES _gles;

        bool const _valid;

    public :

        using priv_t = decltype (_priv);
        using valid_t = decltype (_valid);

        static_assert (is_same <DRM::priv_t, priv_t>::value != false);

        Compositor () = delete;
        explicit Compositor (Base::sv_t const & sv, bool priv, Base::id_t id = 0) : Base {sv, true, id}, _priv {priv}, _gles {GL_TEXTURE_EXTERNAL_OES}, _valid{Init ()} {}
        virtual ~Compositor () { /* bool */ Deinit (); }

//        static_assert (is_same <Base::valid_t, valid_t>::value != false);
//        static_assert (is_same <GLES::valid_t, valid_t>::value != false);
        valid_t Status () const { return Base::Status () && _gles.Status () & _valid; }

        bool Run () override;

    private :
        bool Clear ();

        bool Init ();
        bool Deinit ();

        // Per client
        bool CreateSharedBuffer ();
        bool DestroySharedBuffer ();

        bool ShareBuffer ();
        bool Render () override;
};

bool Base::Init () {
    bool _ret = false;

    _ret = _drm.Status () && _egl.Status ();

    return _ret;
}

bool Base::Deinit () {
    bool _ret = Clear ();

    return _ret;
}

bool Base::ShareBuffer (bool mode) {
    bool _ret = false;
// TODO: define max size
    std::string _msg (255, '\0');

    DRM::GBM::prime_t _prime = DRM::GBM::InvalidPrime ();

    constexpr char _id_tag [] = "ID:";
    constexpr char _width_tag [] = ";Width:";
    constexpr char _height_tag [] = ";Height:";
    constexpr char _stride_tag [] = ";Stride:";

    constexpr uint8_t _id_count = length (_id_tag);
    constexpr uint8_t _width_count = length (_width_tag);
    constexpr uint8_t _height_count = length (_height_tag);
    constexpr uint8_t _stride_count = length (_stride_tag);

    if (mode != false) {
        // Privileged

        DRM::GBM & _gbm = _drm.Get ();

        _prime = _gbm.Prime ();

// TODO: invalid dimensions

        if (_prime != DRM::GBM::InvalidPrime ()) {
            std::string const _fd_s = std::to_string (_prime._fd);

            // Buffer was created as a pixmap so dimensions can be queried
            std::string const _id_s = std::to_string (_id);
            std::string const _width_s = std::to_string (_prime._width);
            std::string const _height_s = std::to_string (_prime._height);
            std::string const _stride_s = std::to_string (_prime._stride);

// TODO: total message size
// TODO: more efficient message implementation

            if (_id_s.size () != 0 && _width_s.size () > 0 && _height_s.size () > 0 && _stride_s.size () > 0) {
                // Client / compositor ID
                _msg.replace (0, _id_count, _id_tag);
                _msg.replace (_id_count, _id_s.size (), _id_s.c_str ());

                // Width
                _msg.replace (_id_count + _id_s.size (), _width_count, _width_tag);
                _msg.replace ((_id_count + _width_count) + _id_s.size (), _width_s.size (), _width_s.c_str ());

                // Height
                _msg.replace ((_id_count + _width_count) + _id_s.size () + _width_s.size (), _height_count, _height_tag);
                _msg.replace ((_id_count + _width_count + _height_count) + _id_s.size () + _width_s.size (), _height_s.size (), _height_s.c_str ());

                // Stride / Pitchh
                _msg.replace ((_id_count + _width_count + _height_count) + _id_s.size () + _width_s.size () + _height_s.size (), _stride_count, _stride_tag);
                _msg.replace ((_id_count + _width_count + _height_count + _stride_count) + _id_s.size () + _width_s.size () + _height_s.size (), _stride_s.size (), _stride_s.c_str ());

                _ret = Send (_msg, _prime._fd) && _egl.ImportBuffer (_prime._buf);
            }
            else {
                // Error
            }
        }
    }
    else {
        // Unprivileged
        // Anything not being an invalid FD triggers the sharing of primes
        _prime._fd = ~DRM::GBM::InvalidFd ();

        _ret = Receive (_msg, _prime._fd);

        if (_ret != false) {
            size_t _id_p = _msg.find (_width_tag);
            size_t _width_p = _msg.find (_width_tag);
            size_t _height_p = _msg.find (_height_tag);
            size_t _stride_p = _msg.find (_stride_tag);

            if (_id_p != std::string::npos && _width_p != std::string::npos && _height_p != std::string::npos && _stride_p != std::string::npos) {
                std::string const _id_s = _msg.substr (_id_p + _id_count, _width_p - _id_p - _id_count);
                std::string const _width_s = _msg.substr (_width_p + _width_count, _height_p - _width_p - _width_count);
                std::string const _height_s = _msg.substr (_height_p + _height_count, _stride_p - _height_p - _height_count);
                std::string const _stride_s = _msg.substr (_stride_p + _stride_count, std::string::npos);

                // Client / compositor ID
                long _val = std::atol (_id_s.c_str ());
// TODO: assign

                // Underlying buffer width
                /* long */ _val = std::atol (_width_s.c_str ());
                _prime._width = _val != 0 ? _val : DRM::GBM::InvalidWidth ();

                // Underlying buffer height
                /* long */ _val = std::atol (_height_s.c_str ());
                _prime._height = _val != 0 ? _val : DRM::GBM::InvalidHeight ();

                // Underlying buffer stride / pitch
                /* long */ _val = std::atol (_stride_s.c_str ());
                _prime._stride = _val != 0 ? _val : DRM::GBM::InvalidStride ();

// TODO: invalid dimensions
// TODO: narrowing

                _ret = _egl.ImportBuffer (_prime);
            }
            else {
                // Error
                _ret = false; 
            }
        }
    }

    // A valid prime fd should always be imported
    if (_ret != false) {
        _ret = _prime._fd != DRM::GBM::InvalidFd ();
    }

    return _ret;
}

bool Base::ReadKey (std::string const & message, char& key) {
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
                                                                key = 0xD; // CR
                                                                _ret = true;
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

bool Base::Send (std::string const & msg, DRM::GBM::fd_t const & fd) {
    using fd_t = remove_reference < decltype (fd) >::type;

    bool _ret = false;

    // Logical const
    char * _buf  = const_cast <char *> ( & msg [0] );

    size_t const _bufsize = msg.size ();

    if (_bufsize > 0) {

        // Scatter array for vector I/O
        struct iovec _iov;

        // Starting address
        _iov.iov_base = reinterpret_cast <void *> (_buf);
        // Number of bytes to transfer
        _iov.iov_len = _bufsize;

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
        char _control [CMSG_SPACE (sizeof (fd_t))];

        bool _valid = false;

        if (fd != DRM::GBM::InvalidFd ()) {
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
                _cmsgh->cmsg_len = CMSG_LEN (sizeof (fd_t));

                // Initialize the payload
                // Pointer to the data portion of a cmsghdr, ie unsigned char []
                * reinterpret_cast < fd_t * > ( CMSG_DATA (_cmsgh) ) = fd;

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
            _size = sendmsg (_sv, &_msgh, 0);

            if (_size < 0) {
                // Error
                std::cout << "Error: sendmsg (" << strerror (errno) << ")" << std::endl;
            }
        }

        _ret = _size != -1;
    }

    return _ret;
}

bool Base::Receive (std::string & msg, DRM::GBM::fd_t & fd) {
    using fd_t = remove_reference < decltype (fd) >::type;

    bool _ret = false;

    // Logical const
    char * _buf  = const_cast <char *> ( & msg [0]);
    size_t const _bufsize = msg.size ();

    if (_bufsize > 0) {

        // Scatter array for vector I/O
        struct iovec _iov;

        // Starting address
        _iov.iov_base = reinterpret_cast <void *> (_buf);
        // Number of bytes to transfer
        _iov.iov_len = _bufsize;


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
        char _control [CMSG_SPACE (sizeof (fd_t))];

        // Ancillary data, pointer
        _msgh.msg_control = _control;

        // Ancillery data buffer length
        _msgh.msg_controllen = sizeof (_control);


        ssize_t _size = -1;

        bool _valid = false;

        if (fd != DRM::GBM::InvalidFd ()) {
            // Expecting message with extra paylod

            // No flags set
            _size = recvmsg (_sv, &_msgh, 0);

            if (_size >= 0) {

                // Pointer to the first cmsghdr in the ancillary data buffer associated with the passed msgh
                struct cmsghdr* _cmsgh = CMSG_FIRSTHDR( &_msgh);

                // Check for the expected properties the client should have set

                if (_cmsgh != nullptr) {
                    _valid = true;

                    _valid = _cmsgh->cmsg_len == CMSG_LEN (sizeof (fd_t));

                    if (_cmsgh->cmsg_level != SOL_SOCKET) {
                        _valid = false;
                    }

                    if (_cmsgh->cmsg_type != SCM_RIGHTS) {
                        _valid = false;
                    }

                    if (_valid != false) {
                        // The macro returns a pointer to the data portion of a cmsghdr.
                        fd = * reinterpret_cast < fd_t * > ( CMSG_DATA (_cmsgh) );

                        _valid = true;
                    }
                    else {
                        fd = DRM::GBM::InvalidFd ();
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

            _size = read (_sv, _buf, _bufsize);

            if (_size < 0) {
                // Error
                std::cout << "Error: read (" << strerror (errno) << ")" << std::endl;
            }

        }

        if (_valid != true) {
            _size = -1;
        }

        _ret = _size != -1;
    }

    return _ret;
}

bool Base::Clear () {
    bool _ret = false;

    const_cast <remove_const <valid_t>::type &> (_valid) = false;

    _ret = Status () != true;

    return _ret;
}

bool DRM::Init () {
    bool _ret = Clear () && drmAvailable () > 0;

    if (_ret != false) {
        _fd = (_path.size () > 0 ? open (_path.c_str () , O_RDWR) : InvalidFd ());
    }

    if (_ret != false) {
        _ret = _fd != InvalidFd ();
    }

    if (_ret != false) {
        if (_priv != true) {
            /* int */ drmDropMaster (_fd);

            _ret = true;
        }
        else {
            /* int */ drmSetMaster (_fd);

            _ret = ValidModeSet ();// && _gbm.Status ();;
        }
    }

    return _ret;
}

bool DRM::Deinit () {
    bool _ret = false;

    if (_fd == InvalidFd ()) {
        // Error
        _ret = false;
    }
    else {
// TODO: restore mode
        _ret = close (_fd) == 0;
    }

    _ret = Clear () && _ret;

    return _ret;
}

bool DRM::ScanOut () {
    bool _ret = false;

    _ret = _gbm.Lock ();

    if (_ret != false) {

        // Logical const
        DRM::GBM::buf_t & _buf = const_cast <DRM::GBM::buf_t &> (_gbm.Buffer ());

        _ret = ScanOut (_buf);

        /* bool */ _gbm.Unlock ();
    }

    return _ret;
}

bool DRM::ScanOut (DRM::GBM::buf_t & buf) {
    bool _ret = false;

    if (_fd != DRM::InvalidFd () && buf != DRM::GBM::InvalidBuf ()) {

        static_assert (is_same < std::decay < DRM::width_t >::type, std::decay < DRM::GBM::width_t >::type>::value != false);
        static_assert (is_same < std::decay < DRM::height_t >::type, std::decay < DRM::GBM::height_t >::type>::value != false);
        static_assert (is_same < std::decay < DRM::frmt_t >::type, std::decay < DRM::GBM::frmt_t >::type>::value != false);
        static_assert (is_same < std::decay < DRM::bpp_t >::type, std::decay < DRM::GBM::bpp_t >::type>::value != false);
        static_assert (is_same < std::decay < DRM::pitch_t >::type, std::decay < DRM::GBM::stride_t >::type>::value != false);
        static_assert (is_same < std::decay < DRM::handle_t >::type, std::decay < DRM::GBM::handle_t >::type>::value != false);

// TODO correct place?
        DRM::GBM::width_t _width = gbm_bo_get_width (buf);
        DRM::GBM::height_t _height = gbm_bo_get_height (buf);
        DRM::GBM::frmt_t _format = gbm_bo_get_format (buf);
        DRM::GBM::bpp_t _bpp = gbm_bo_get_bpp (buf);

        DRM::GBM::handle_t _handle = gbm_bo_get_handle (buf).u32;
        DRM::GBM::stride_t _stride = gbm_bo_get_stride (buf);

        if (_fb != DRM::InvalidFb ()) {
// TODO: Do no remove the current FB before the FLIP otherwise EBUSY
//            /* void */ drmModeRmFB (_fd, _fb);
            _fb = DRM::InvalidFb ();
        }

        fb_id_t _fb;

        if (drmModeAddFB (_fd, _width, _height, _format != DRM::ColorFormat () ? _bpp - 8 : _bpp, _bpp, _stride, _handle, &_fb) == 0) {
            static std::atomic <bool> _callback_data (true);
            _callback_data = true;

            int _err = drmModePageFlip (_fd, _crtc, _fb, DRM_MODE_PAGE_FLIP_EVENT, &_callback_data);

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

                                    struct timespec _timeout = { .tv_sec = DRM::FrameDurationMax (), .tv_nsec = 0 };
//TODO: guarantee at least the EVENTS are processes
                                    while (_waiting != false) {
                                        FD_ZERO (&_fds);
                                        FD_SET (_fd, &_fds);

                                        _err  = pselect (_fd + 1, &_fds, nullptr, nullptr, &_timeout, nullptr);

                                        if (_err < 0) {
                                                break;
                                        }
                                        else {
                                            if (_err == 0) {
                                                // Timeout; retry
                                            }
                                            else { // ret > 0
                                                if (FD_ISSET (_fd, &_fds) != 0) {
                                                    if (drmHandleEvent (_fd, &_context) != 0) {
                                                        _ret = false;
                                                        break;
                                                    }

                                                    _ret = true;

                                                    // Remove the previous frame buffer

                                                    // Possibly, the underlying buffer has already been removed
                                                    if (DRM::_fb != DRM::InvalidFb ()) {
                                                        /* void */ drmModeRmFB (_fd, DRM::_fb);
                                                        DRM::_fb = DRM::InvalidFb ();
                                                    }

                                                }
                                            }
                                        }

                                        _waiting = _callback_data;
                                    }

                                    break;
                                }
                case EINVAL :
                                {   // Probably a missing drmModeSetCrtc or an invalid _crtc
                                    // Likely to happens once or not at all
                                    drmModeCrtcPtr _ptr = drmModeGetCrtc (_fd, _crtc);

                                    if (_ptr != nullptr) {
                                        constexpr uint32_t _count = 1;

                                        _ret = drmModeSetCrtc (_fd, _crtc, _fb, _ptr->x, _ptr->y, &_conn, _count, &_ptr->mode) == 0;

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

            DRM::_fb = _fb;
        }
        else {
            std::cout << "Error: scan out impossible" << std::endl;
            _ret = false;
        }
    }

    return _ret;
}

bool DRM::Clear () {
    bool _ret = false;

//    _path.clear ();

    if (_priv != false ) {
        _fd = InvalidFd ();

        _fb = InvalidFb ();
        _crtc = InvalidCrtc ();
        _enc = InvalidEncoder ();
        _conn = InvalidConnector ();

        _width = InvalidWidth ();
        _height = InvalidHeight ();
// TODO:
//        _frmt = InvalidFrmt ();

//        _x = InvalidOffset ().X;
//        _y = InvalidOffset ().Y;
    }

    const_cast <remove_const <valid_t>::type &> (_valid) = false;

    _ret = Status () != true;

    return _ret;
}

bool DRM::ValidModeSet () {
    bool _ret = true;

    if (_fd != InvalidFd ()) {
        drmModeResPtr _pres = drmModeGetResources (_fd);

        if (_pres != nullptr) {
            using conn_count_t = remove_pointer < decltype (drmModeRes::count_connectors) >::type;

            for (conn_count_t i = 0; i < _pres->count_connectors; i++) {
                // Do not probe
                drmModeConnectorPtr _pcon = drmModeGetConnectorCurrent (_fd, _pres->connectors [i]);

                if (_pcon != nullptr) {
                    // Only consider HDMI
                    if ( (_pcon->connector_type == DRM_MODE_CONNECTOR_HDMIA  || \
                        _pcon->connector_type == DRM_MODE_CONNECTOR_HDMIB) && \
                         DRM_MODE_CONNECTED == _pcon->connection) {

                        // Encoder currently connected to
                        drmModeEncoderPtr _penc = drmModeGetEncoder (_fd, _pcon->encoder_id);

                        if (_penc != nullptr) {
                            _crtc = _penc->crtc_id;
                            _enc = _penc->encoder_id;
                            _conn = _pcon->connector_id;

                            drmModeFreeEncoder (_penc);
                        }
                    }

                    drmModeFreeConnector (_pcon);
                }

                // For now, do not considerer multiple viable options
                if (_crtc != InvalidCrtc () && _enc != InvalidEncoder () && _conn != InvalidConnector ()) {

                    drmModeCrtcPtr _pcrtc = drmModeGetCrtc (_fd, _crtc);

                    if (_pcrtc != nullptr) {

                        _fb = _pcrtc->buffer_id;
                        _x = _pcrtc->x;
                        _y = _pcrtc->y;

                        if (_fb != InvalidFb ()) {
                            drmModeFB2Ptr _pfb2 = drmModeGetFB2 (_fd, _fb);

                            if (_pfb2 != nullptr) {
                                _width = _pfb2->width;
                                _height = _pfb2->height;

                                // It is not guarantueed that pixel format matches DRM_FORMAT_ARGB888 or DRM_FORMAT_XRGB888, which are the only supported formats for GBM
                                _frmt = _pfb2->pixel_format;

                                // Possibly no match with the only two options for GBM
                                // VC4 supported formats
                                // https://github.com/raspberrypi/linux/blob/rpi-<version>.y/drivers/gpu/drm/vc4/vc4_firmware_kms.c
                                //
                                // static_assert (_frmt != DRM::GBM::ColorFormat ());

                                drmModeFreeFB2 (_pfb2);
                            }

                        }

                        drmModeFreeCrtc (_pcrtc);
                    }

                    _ret = true;

                    break;
                }
            }

        }
        else {
            _ret = false;
        }

        drmModeFreeResources (_pres);
    }

    return _ret;
}

bool DRM::GBM::Init () {
    bool _ret = Clear ();

    if (_ret != false) {
        _dev = (_fd != DRM:: InvalidFd () ? gbm_create_device (_fd) : InvalidDev ());

        _ret = _dev != InvalidDev ();
    }

    if (_ret != false) {

        _ret = gbm_device_is_format_supported (_dev, _frmt, _flags) != 0;
    }

    if (_ret != false) {
        // It might work headless but lets keep clients similar in contructon as compositor
        _surf = gbm_surface_create (_dev, Width (), Height (), ColorFormat (), _flags);

        _ret = _surf != InvalidSurf ();
    }

    if (_ret != true) {
        /* bool */ Deinit ();
    }

    return _ret;
}

bool DRM::GBM::Deinit () {
    bool _ret = _dev != InvalidDev ();

    if (_ret != false) {
        if (_buf != InvalidBuf ()) {
            gbm_bo_destroy (_buf);
        }

        if (_surf != InvalidSurf ()) {
            gbm_surface_destroy (_surf);
        }

        if (_dev != InvalidDev ()) {
            gbm_device_destroy (_dev);
        }
    }

    _ret = Clear () && _ret;

    return _ret;
}

bool DRM::GBM::Lock () {
    bool _ret = _surf != InvalidSurf () && _buf == InvalidBuf ();

// TODO keep trackk of _buf here so it does not get lost with unlock

    if (_ret != false) {
        _buf = gbm_surface_lock_front_buffer (_surf);

        _ret = _buf != InvalidBuf ();
    }

    return _ret;
}

bool DRM::GBM::Unlock () {
    bool _ret = _surf != InvalidSurf () && _buf != InvalidBuf ();

    if (_ret != false) {
        /* void */ gbm_surface_release_buffer (_surf, _buf);

        _buf = InvalidBuf ();

        _ret = _buf != InvalidBuf ();
    }

    return _ret;
}

bool DRM::GBM::CreatePrime () {
    bool _ret = _dev != InvalidDev ();

    /* bool */ DestroyPrime ();

    _ret = CreateBuffer ();

    if (_ret != false) {
        _prime._fd = gbm_bo_get_fd (_prime._buf);

        _ret = _prime != InvalidPrime ();

        if (_ret != true) {
            /* bool */ DestroyBuffer ();
        }
    }

    return _ret;
}

bool DRM::GBM::ImportPrime (DRM::GBM::prime_t const & prime) {
    bool _ret = prime != InvalidPrime ();

    /* bool */ DestroyPrime ();

    if (_ret != false) {
        _prime = prime;
    }

    return _ret;
}

bool DRM::GBM::DestroyPrime () {
    bool _ret = _dev != InvalidDev () && _prime._fd != InvalidFd ();

    if (_ret != false) {
        _ret = close (_prime._fd) != -1;

        _prime._fd = InvalidFd ();

        /* bool */ DestroyBuffer ();

        _ret = true;
    }

    return _ret;
}

bool DRM::GBM::Clear () {
    bool _ret = false;

    _dev = InvalidDev ();
    _surf = InvalidSurf ();
    _buf = InvalidBuf ();
    _prime = InvalidPrime ();

// TODO
//    _stride = InvalidStride ();
//    _frmt = InvalidFrtm ();

    const_cast <remove_const <valid_t>::type &> (_valid) = false;

    _ret = Status () != true;

    return _ret;
}

bool DRM::GBM::CreateBuffer () {
    bool _ret = _dev != InvalidDev ();

    if (_ret != false) {

        _prime._buf = gbm_bo_create (_dev, Width (), Height (), ColorFormat (), _flags);

        if (_prime._buf != InvalidBuf ()) {
            _prime._width = Width ();
            _prime._height = Height ();
            _prime._stride = Pitch (_prime._buf); 
        }

        _ret = _prime._buf != InvalidBuf ();
    }

    return _ret;
}

bool DRM::GBM::DestroyBuffer () {
    bool _ret = _dev != InvalidDev () && _prime._buf != InvalidBuf ();

    if (_ret != false) {
        /* void */ gbm_bo_destroy (_prime._buf); 

        _prime._buf = InvalidBuf ();

        _ret = true;
    }

    return _ret;
}

bool EGL::Init () {
    bool _ret = Clear ();

// TODO: add extentions support

    if (_ret != false) {
        if (_gbm.Device () != DRM::GBM::InvalidDev ()) {
            _dpy = eglGetDisplay (_gbm.Device ());
        }

        if (_dpy == InvalidDisplay ()) {
            // Error
            std::cout << "Error: eglGetDisplay (0x" << std::hex << eglGetError () << ")" << std::endl;

            _ret = false;
        }
        else {
            EGLint _major, _minor;
            if (eglInitialize (_dpy, &_major, &_minor) != EGL_TRUE) {
                // Error
                std::cout << "Error: eglInitialize (0x" << std::hex << eglGetError () << ")" << std::endl;
            }

            if (eglBindAPI (EGL_OPENGL_ES_API) != EGL_TRUE) {
                // Error
                std::cout << "Error: eglBindAPI (0x" << std::hex << eglGetError () << ")" << std::endl;
            }

            EGLint const _ecfg_attr [] = {
                EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
                EGL_RENDERABLE_TYPE, EGL_OPENGL_ES2_BIT,
// TODO: obtain these magic constance from the actual pixel format
                EGL_RED_SIZE, 8,
                EGL_RED_SIZE, 8,
                EGL_RED_SIZE, 8,
                EGL_ALPHA_SIZE, 8,
                EGL_BUFFER_SIZE, 32,
                EGL_NONE
            };

            EGLint _count = 1;
            if (eglChooseConfig (_dpy, _ecfg_attr, &(_cfg), _count, &_count) != EGL_TRUE) {
                // Error
                std::cout << "Error: eglChooseConfig (0x" << std::hex << eglGetError () << ")" << std::endl;
            }

            EGLint const _ectx_attr [] = {
                EGL_CONTEXT_CLIENT_VERSION, 2,
                EGL_NONE
            };

            _ctx = eglCreateContext (_dpy, _cfg, EGL_NO_CONTEXT, _ectx_attr);
            if (_ctx == InvalidContext ()) {
                // Error
                std::cout << "Error: eglCreateContex (0x" << std::hex << eglGetError () << ")" << std::endl;
            }

            _surf = eglCreateWindowSurface (_dpy, _cfg, reinterpret_cast <EGLNativeWindowType> (_gbm.Surface ()), nullptr);
            if (_surf == InvalidSurface ()) {
                // Error
                std::cout << "Error: eglCreateWindowSurface (0x" << std::hex << eglGetError () << ")" << std::endl;
            }

            EGLint _err = EGL_SUCCESS;

            if (eglMakeCurrent (_dpy, _surf, _surf, _ctx) != EGL_TRUE) {
                // Error
                _err = eglGetError ();
                std::cout << "Error: eglMakeCurrent (0x" << std::hex << _err << ")" << std::endl;
            }

            // Force an early allocation (of resources)

            // Fails if previous errors exist
            if (/* _err == EGL_SUCCESS && */ eglSwapBuffers (_dpy, _surf) != EGL_TRUE) {
                // Error
                _err = eglGetError ();
                std::cout << "Error: eglSwapBuffers (0x" << std::hex << _err << ")" << std::endl;
            }

            _ret = _err == EGL_SUCCESS;

        }

        if (_ret != true) {
            /* bool */ Deinit ();
            
        }
    }

    return _ret;
}

bool EGL::Deinit () {
    bool _ret = false;

    if (eglMakeCurrent (_dpy, InvalidSurface (), InvalidSurface (), _ctx) != EGL_TRUE) {
        // Error
        _ret = false;
    }

    if (eglTerminate (_dpy) != EGL_FALSE) {
        // Error
        _ret = false;
    }

    _ret = Clear () && _ret;

    return _ret;
}

bool EGL::ImportBuffer (DRM::GBM::buf_t const & buf) {
// TODO:
    bool _ret = false;

    if (buf != DRM::GBM::InvalidBuf ()) {

        if (_img != EGL::InvalidImage ()) {
            static EGLBoolean (* _eglDestroyImageKHR) (EGLDisplay, EGLImageKHR) = reinterpret_cast < EGLBoolean (*) (EGLDisplay, EGLImageKHR) > (eglGetProcAddress ("eglDestroyImageKHR"));

            if (_eglDestroyImageKHR != nullptr) {
                /*EGLBoolean*/ _eglDestroyImageKHR (_dpy, _img._khr);
                _img = EGL::InvalidImage ();
            }
        }

        // Possible narrowing
//        using width_t = std::common_type <EGLint, DRM::GBM::width_t>::type;
// TODO: print warning or fail
//        static_assert (is_same < DRM::GBM::width_t, width_t >::value != false);
//        static_assert (is_same < EGLint, width_t >::value != false);

        _img._width = DRM::GBM::Width (buf);
        _img._height = DRM::GBM::Height (buf);

        EGLint _attrs [] = {
            EGL_WIDTH, _img._width,
            EGL_HEIGHT, _img._height,
            EGL_NONE
        };

        static EGLImageKHR (* _eglCreateImageKHR) (EGLDisplay, EGLContext, EGLenum, EGLClientBuffer, EGLint const * ) = reinterpret_cast < EGLImageKHR (*) (EGLDisplay, EGLContext, EGLenum, EGLClientBuffer, EGLint const * ) > (eglGetProcAddress ("eglCreateImageKHR"));

        if (_eglCreateImageKHR != nullptr) {
            _img._khr = _eglCreateImageKHR (_dpy, EGL_NO_CONTEXT, EGL_NATIVE_PIXMAP_KHR, buf, _attrs);
        }

        _ret = _img != EGL::InvalidImage ();

    }

    return _ret;
}

bool EGL::ImportBuffer (DRM::GBM::prime_t const & prime) {
    bool _ret = false;

// TODO invalid dimension and color formats

    // Destruction also done via ImportPrime
    if (prime != DRM::GBM::InvalidPrime () /*&& DestroyPrime () */){

        if (_img != EGL::InvalidImage ()) {
            static EGLBoolean (* _eglDestroyImageKHR) (EGLDisplay, EGLImageKHR) = reinterpret_cast < EGLBoolean (*) (EGLDisplay, EGLImageKHR) > (eglGetProcAddress ("eglDestroyImageKHR"));

            if (_eglDestroyImageKHR != nullptr) {
                /*EGLBoolean*/ _eglDestroyImageKHR (_dpy, _img._khr);
                _img = EGL::InvalidImage ();
            }
        }

        // Possible narrowing
//        using width_t = std::common_type <EGLint, DRM::GBM::width_t>::type;
// TODO: print warning or fail
//        static_assert (is_same < DRM::GBM::width_t, width_t >::value != false);
//        static_assert (is_same < EGLint, width_t >::value != false);

        EGLint _attrs [] = {
            EGL_WIDTH,  prime._width,
            EGL_HEIGHT, prime._height,
            EGL_LINUX_DRM_FOURCC_EXT, DRM::ColorFormat (), //prime._frmt,
            EGL_DMA_BUF_PLANE0_FD_EXT, prime._fd,
// TODO: magic constant ?
            EGL_DMA_BUF_PLANE0_OFFSET_EXT, 0,
            EGL_DMA_BUF_PLANE0_PITCH_EXT, prime._stride,
            EGL_NONE
        };

        static EGLImageKHR (* _eglCreateImageKHR) (EGLDisplay, EGLContext, EGLenum, EGLClientBuffer, EGLint const * ) = reinterpret_cast < EGLImageKHR (*) (EGLDisplay, EGLContext, EGLenum, EGLClientBuffer, EGLint const * ) > (eglGetProcAddress ("eglCreateImageKHR"));

        if (_eglCreateImageKHR != nullptr) {
            _img._khr = _eglCreateImageKHR (_dpy, EGL_NO_CONTEXT, EGL_LINUX_DMA_BUF_EXT, 0, _attrs);
        }

        _ret = _img != EGL::InvalidImage () && _gbm.ImportPrime (prime) != false;
    }

    return _ret;
}

bool EGL::Render () {
    bool _ret = false;

    // eglMakeCurrent has been called at Init
    _ret = eglSwapBuffers (_dpy, _surf) != EGL_FALSE;

    return _ret;
}

bool EGL::Clear () {
    bool _ret = false;

    _dpy = InvalidDisplay ();;
//    _cfg = EGL_NO_CONFIG
    _surf = InvalidSurface ();
    _ctx = InvalidContext ();;
    _img = InvalidImage ();;

    const_cast <remove_const <valid_t>::type &> (_valid) = false;

    _ret = Status () != true;

    return _ret;
}

bool GLES::Init () {
    bool _ret = Clear ();

    return _ret;
}

bool GLES::Deinit () {
    bool _ret = Clear ();

    return _ret;
}

bool GLES::RenderTile () {
    bool _ret = glGetError () == GL_NO_ERROR;

    if (_ret != false) {
        glClear (GL_COLOR_BUFFER_BIT);
        _ret = glGetError () == GL_NO_ERROR;
    }

    if (_ret != false) {
        _ret = SetupProgram ();
    }

// TODO: range
    static_assert (is_same <GLfloat, GLES::offset::coordinate_t>:: value != false);
    std::array <GLfloat, 4 * VerticeDimensions> const _vert = {-0.5f + _offset._x, -0.5f + _offset._y, 0.0f + _offset._z /* v0 */, -0.5f + _offset._x, 0.5f + _offset._y, 0.0f + _offset._z /* v1 */, 0.5f + _offset._x, -0.5f + _offset._y, 0.0f + _offset._z /* v2 */, 0.5f + _offset._x, 0.5f + _offset._y, 0.0f + _offset._z /* v3 */};

    if (_ret != false) {
        GLuint _prog = 0;

        if (_ret != false) {
            glGetIntegerv (GL_CURRENT_PROGRAM, reinterpret_cast <GLint *> (&_prog));
            _ret = glGetError () == GL_NO_ERROR;
        }

        GLint _loc = 0;
        if (_ret != false) {
            _loc = glGetAttribLocation (_prog, "position");
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false) {
            glVertexAttribPointer (_loc, VerticeDimensions, GL_FLOAT, GL_FALSE, 0, _vert.data ());
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false) {
            glEnableVertexAttribArray (_loc);
            _ret = glGetError () == GL_NO_ERROR;
        }
    }

    if (_ret != false) {
        glDrawArrays (GL_TRIANGLE_STRIP, 0, _vert.size () / VerticeDimensions);
        _ret = glGetError () == GL_NO_ERROR;
    }

    return _ret;
}

bool GLES::RenderEGLImage (EGL::img_t const  & img) {
    bool _ret = glGetError () == GL_NO_ERROR && img != EGL::InvalidImage ();

// TODO: add check ?
//    fbo = _tgt != GL_TEXTURE_EXTERNAL_OES;

    if (_ret != false) {
        glActiveTexture (GL_TEXTURE0);
        _ret = glGetError () == GL_NO_ERROR;
    }

    if (_ret != false) {
        if (_tex != InvalidTex ()) {
            glDeleteTextures (1, &_tex);
            _ret = glGetError () == GL_NO_ERROR;
        }

        _tex = InvalidTex ();

        if (_ret != false) {
            glGenTextures (1, &_tex); 
            _ret = glGetError () == GL_NO_ERROR;
        }
    }

    if (_ret != false) {
        glBindTexture (_tgt, _tex);
        _ret = glGetError () == GL_NO_ERROR;
    }

    if (_ret != false) {
        glTexParameteri (_tgt, GL_TEXTURE_WRAP_S,GL_CLAMP_TO_EDGE);
        _ret = glGetError () == GL_NO_ERROR;
    }

    if (_ret != false) {
        glTexParameteri (_tgt, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        _ret = glGetError () == GL_NO_ERROR;
    }

    if (_ret != false) {
        glTexParameteri (_tgt, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        _ret = glGetError () == GL_NO_ERROR;
    }

    if (_ret != false) {
        glTexParameteri (_tgt, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        _ret = glGetError () == GL_NO_ERROR;
    }

    // Requires EGL 1.2 and either the EGL_OES_image or EGL_OES_image_base
    // Use eglGetProcAddress, or dlsym for the function pointer of this GL extenstion
    // https://www.khronos.org/registry/OpenGL/extensions/OES/OES_EGL_image_external.txt
    static void (* _EGLImageTargetTexture2DOES) (GLenum, GLeglImageOES) = reinterpret_cast < void (*) (GLenum, GLeglImageOES) > (eglGetProcAddress ("glEGLImageTargetTexture2DOES"));

    if (_ret != false && _EGLImageTargetTexture2DOES != nullptr) {
        _EGLImageTargetTexture2DOES (_tgt, reinterpret_cast <GLeglImageOES> (img._khr));
        _ret = glGetError () == GL_NO_ERROR;
    }
    else {
        _ret = false;
    }

    if (_ret != false) {
        if (_tgt != GL_TEXTURE_EXTERNAL_OES) {
            if (_fbo != InvalidFbo ()) {
                glDeleteFramebuffers (1, &_fbo);
                _ret = glGetError () == GL_NO_ERROR;
            }

            if (_ret != false) {
                glGenFramebuffers(1, &_fbo);
                _ret = glGetError () == GL_NO_ERROR;
            }

            if (_ret != false) {
                glBindFramebuffer(GL_FRAMEBUFFER, _fbo);
                _ret = glGetError () == GL_NO_ERROR;
            }

            if (_ret != false) {
                glFramebufferTexture2D (GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, _tgt, _tex, 0 /* level */);
                _ret = glGetError () == GL_NO_ERROR;
            }
        }
    }

    if (_ret != false) {
        // Image to full size
        glViewport (0, 0, img._width, img._height);
        _ret = glGetError () == GL_NO_ERROR;
    }

    if (_ret != false) {
        if (_tgt == GL_TEXTURE_EXTERNAL_OES) {
            _ret = RenderTile ();
        }
    }

    return _ret;
}

bool GLES::Clear () {
    bool _ret = false;

    _fbo = InvalidFbo ();

    _offset = GLES::InitialOffset ();

    const_cast <remove_const <valid_t>::type &> (_valid) = false;

    _ret = Status () != true;

    return _ret;
}

bool GLES::BufferColorFill (bool red, bool green, bool blue) {
    bool _ret = false;

    constexpr float OMEGA = 3.14159265 / 180;
    constexpr uint16_t ROTATION = 360;
    constexpr uint16_t DELTA = 10;

    static uint16_t _degree = 0;

    _degree = (_degree + DELTA) % ROTATION;

    // Here, for C(++) these type should be identical
    // Type information: https://www.khronos.org/opengl/wiki/OpenGL_Type
    static_assert (std::is_same <float, GLfloat>::value);

    static_assert (std::numeric_limits <uint16_t>::max () <= std::numeric_limits <float>::max ());

    // Avoid total darness
    constexpr GLfloat _delta = 0.25f;
    constexpr GLfloat _amplitude = 0.75f;

    // Loosing precision
    // _amplitude * [0..1] + _delta

    GLfloat _rad = static_cast <GLfloat> (_delta + ( _amplitude * cos (_degree * OMEGA) * cos (_degree * OMEGA)));

    // The function clamps the input to [0, 1]

    constexpr GLfloat _default_color = 0.0f;

    /* void */ glClearColor (red != false ? _rad : _default_color, green != false ? _rad : _default_color, blue != false ? _rad : _default_color, 1.0);

    _ret = glGetError () == GL_NO_ERROR;

    if (_ret != false) {
        /* void */ glClear (GL_COLOR_BUFFER_BIT);

        _ret = glGetError () == GL_NO_ERROR;
    }

    return _ret;
}

bool GLES::UpdateOffset (struct offset const & off) {
    bool _ret = false;

    // Ramge check without taking into account rounding errors
    if ( ((off._x - -0.5f) * (off._x - 0.5f) <= 0.0f) 
        && ((off._y - -0.5f) * (off._y - 0.5f) <= 0.0f) 
        && ((off._z - -0.5f) * (off._z - 0.5f) <= 0.0f) ){

        _offset = off;

        _ret = true;
    }

    return _ret;
}

bool GLES::SetupProgram () {
    auto LoadShader = [] (GLuint type, GLchar const code []) -> GLuint {
        bool _ret = glGetError () == GL_NO_ERROR;

        GLuint _shader = 0;
        if (_ret != false) {
            _shader = glCreateShader (type);
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false && _shader != 0) {
            glShaderSource (_shader, 1, &code, nullptr);
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false) {
            glCompileShader (_shader);
            _ret = glGetError () == GL_NO_ERROR;
        }

        return _shader;
    };

    auto ShadersToProgram = [] (GLuint vertex, GLuint fragment) -> bool {
        bool _ret = glGetError () == GL_NO_ERROR;

        GLuint _prog = 0;

        if (_ret != false) {
            glGetIntegerv (GL_CURRENT_PROGRAM, reinterpret_cast <GLint *> (&_prog));
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false && _prog != 0) {
            glDeleteProgram (_prog);
            _ret = glGetError () == GL_NO_ERROR;
        }

        _prog = 0;

        if (_ret != false) {
            _prog = glCreateProgram ();
            _ret = _prog != 0;
        }

        if (_ret != false) {
            glAttachShader (_prog, vertex);
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false) {
            glAttachShader (_prog, fragment);
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false) {
            glBindAttribLocation (_prog, 0, "position");
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false) {
            glLinkProgram (_prog);
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != true) {
            glDeleteProgram (_prog);
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false) {
            glUseProgram (_prog);
            _ret = glGetError () == GL_NO_ERROR;
        }
        else {
            glDeleteShader (vertex);
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false) {
            glDeleteShader (fragment);
            _ret = glGetError () == GL_NO_ERROR;
        }

        return _ret;
    };


    glClearColor (0.0f, 1.0f, 0.0f, 0.5f);

    bool _ret = glGetError () == GL_NO_ERROR;


    constexpr char const _vtx_src [] =
        "#version 100                               \n"
        "attribute vec3 position;                   \n"
        "varying vec2 coordinates;                  \n"
        "void main () {                             \n"
            "gl_Position = vec4 (position.xyz, 1);  \n"
            "coordinates = position.xy;             \n"
        "}                                          \n"
        ;

// TODO: For normal rendering no extention

    constexpr char  const _frag_src [] =
        "#version 100                                                           \n"
        "#extension GL_OES_EGL_image_external : require                         \n"
        "precision mediump float;                                               \n"
        "uniform samplerExternalOES sampler;                                    \n"
        "varying vec2 coordinates;                                              \n"
        "void main () {                                                         \n"
            "gl_FragColor = vec4 (texture2D (sampler, coordinates).rgb, 1.0f);  \n"
        "}                                                                      \n"
        ;

    GLuint _vtxShader = LoadShader (GL_VERTEX_SHADER, _vtx_src);
    GLuint _fragShader = LoadShader (GL_FRAGMENT_SHADER, _frag_src);

// TODO: inefficient on every call, reuse compiled program
    _ret = ShadersToProgram(_vtxShader, _fragShader);

    // Color on error
    if (_ret != true) {
        glClearColor (1.0f, 0.0f, 0.0f, 0.5f);
        _ret = glGetError () == GL_NO_ERROR;
    }

     return _ret;
}

bool RenderClient::Init () {
    bool _ret = Clear () && Base::Status () && _gles.Status ();

    if (_ret != true) {
        /* bool */ Deinit ();
    }

    return _ret;
}

bool RenderClient::Deinit () {
    bool _ret = Clear ();

    return _ret;
}

bool RenderClient::Run () {
    bool _ret = Status ();

    if (_ret != false) {

        // Breaks on error like a disconnected communication channel
        while (_ret != false) {
            _ret = ShareBuffer () != false && Render () != false;

// TODO: communicate value via communication channels
            if (_ret != false) {
                std::string const _id_s = std::to_string (_id);
                std::cout << "Client [" << _id_s << "] completed rendering frame." << std::endl;

#ifdef DEBUG
                // Simulate some (additional) processing
                constexpr unsigned int _nanoseconds = 1000 * 1000 * 1000;

                struct timespec _timeout {0, _nanoseconds};

                // Simulate some (additional) processing
                _timeout.tv_nsec = static_cast <int> ( static_cast <double> ( rand () ) / static_cast <double> ( RAND_MAX ) * 1000 * 1000 * 1000 * 2);

                _timeout.tv_sec = _timeout.tv_nsec / (1000 * 1000 * 1000);
                _timeout.tv_nsec = _timeout.tv_nsec % (1000 * 1000 * 1000);

                struct timespec _remaining = {0, 0};
                if (nanosleep ( &_timeout, &_remaining ) != 0) {
                    std::cout << "Error: RenderClient [" << std::to_string (_id) << "] is unable to complete time out of : " << std::to_string (_timeout.tv_nsec) << " [nsec]. Remaining time [nsec] : " << std::to_string (_remaining.tv_nsec) << std::endl;
                }
#endif
            }
        }

    }
    else {
        // Error
        std::cout << "Error: unable to initialize." << std::endl;
    }

    return _ret;
}

bool RenderClient::ShareBuffer () {
    bool _ret = Base::ShareBuffer (_priv);

    return _ret;
}

bool RenderClient::Render () {
    // Three color channels for three clients

    bool _red = false, _green = false, _blue = false;

    // Different colors help to identify client
    // Primaries are used elsewhere
    switch (_id) {
        case 0  : _red = true;  _green = true;  _blue = false;  break;
        case 1  : _red = false; _green = true;  _blue = true;   break;
        case 2  : _red = true;  _green = false; _blue = true;   break;
        default : _red = true;  _green = true;  _blue = true;   break;
    }

    bool _ret = _gles.RenderEGLImage (_egl.Image ()) != false  && _gles.BufferColorFill (_red, _green, _blue) && _egl.Render () != false;

    return _ret;
}

bool RenderClient::Clear () {
    bool _ret = false;

    const_cast <remove_const <valid_t>::type &> (_valid) = false;

    _ret = Status () != true;

    return _ret;
}

bool Compositor::Init () {
    bool _ret = Clear () && Base::Status () && _gles.Status ();

    if (_ret != true) {
        /* bool */ Deinit ();
    }

    return _ret;
}

bool Compositor::Deinit () {
    bool _ret = Clear ();

    return _ret;
}

bool Compositor::Run () {
    bool _ret = Status ();

    if ( _ret != false) {
        char key = ' ';

// TODO: the client should request a buffer
        while (ReadKey ("Press 'c' to create a buffer to be sent, 'Enter' or 'q' to quit", key) != false && key != 'q') {

            if (key != 'c') {
                continue;
            }

// TODO : sync via communication channel, ie, the client should signal it is complete
            _ret = CreateSharedBuffer () != false && ShareBuffer () != false && ReadKey ("Press a key once the client (s) complete", key) != false && Render () != false;

            if (_ret != true) {
                std::cout << "Error: cannot render a shared buffer" << std::endl;
                break;
            }

        }

    }
    else {
        // Error
        std::cout << "Error: unable to initialize." << std::endl;
    }

    return _ret;
}

bool Compositor::CreateSharedBuffer () {
    bool _ret = false;

// TODO: Re-use an existing buffer to be more efficient
    /* bool */ DestroySharedBuffer ();

    DRM::GBM & _gbm = _drm.Get ();

    _ret = _gbm.CreatePrime ();

    return _ret;
}

bool Compositor::DestroySharedBuffer () {
    DRM::GBM & _gbm = _drm.Get ();

    bool _ret = _gbm.DestroyPrime ();

    return _ret;
}

bool Compositor::ShareBuffer () {
    bool _ret = false;

    _ret = Base::ShareBuffer (!_priv);

    return _ret;
}

bool Compositor::Render () {
    bool _ret = false;

// TODO: the offset is client based in multi client setup
    _ret = _gles.UpdateOffset (GLES::InitialOffset ()) != false && _gles.RenderEGLImage (_egl.Image ()) != false && _egl.Render () != false && _drm.ScanOut () != false;

    return _ret;
}

bool Compositor::Clear () {
    bool _ret = false;

    const_cast <remove_const <valid_t>::type &> (_valid) = false;

    _ret = Status () != true;

    return _ret;
}

static_assert (is_same <decltype (EXIT_SUCCESS), decltype (EXIT_FAILURE)>::value != false);
using main_ret_t = decltype (EXIT_SUCCESS);

main_ret_t main (int argc, char* argv []) {
    main_ret_t _ret = EXIT_FAILURE;

    remove_reference < Base::sv_t >::type _sv [2];

    if (socketpair (AF_LOCAL, SOCK_STREAM, 0, _sv) < 0) {
        std::cout << "Error: socketpair" << std::endl;
    }
    else {

#ifdef DEBUG
        constexpr unsigned int TIMEOUT = 1;
#endif

// TODO: no control which client takes the buffer so some form of synchronization / identification is required
    constexpr uint8_t _max_childs = 2;

    uint8_t _num_childs = 1;

_create_next_child_entry_point:

        pid_t _pid = fork ();

// TODO: make _priv configurable
        constexpr bool _priv = false;

        switch (_pid)  {
            case -1 :   {
                            std::cout << "Error: fork" << std::endl;
                            _ret = EXIT_FAILURE;
                            break;
                        }
            case  0 :   {
#ifdef DEBUG
                            bool _flag = true;
                            while ( _flag != false ) { sleep ( TIMEOUT ); };
#endif

                            /* int */ close (_sv [0]);
                            RenderClient _client (_sv [1], _priv, _num_childs);
                            _ret = _client.Run () != false ? EXIT_SUCCESS : EXIT_FAILURE;
                            break;
                        }
            default :   {
#ifdef DEBUG
                            bool _flag = true;
                            while ( _flag != false ) { sleep ( TIMEOUT ); };
#endif

                            if (_num_childs < _max_childs ) {
                                _num_childs++;
                                goto _create_next_child_entry_point;
                            }

                            /* int */ close (_sv [1]);
                            Compositor _compositor (_sv [0], _priv, 0);
                            _ret = _compositor.Run () != false ? EXIT_SUCCESS : EXIT_FAILURE;
                            break;
                        }
        }
    }

    return _ret;
}
