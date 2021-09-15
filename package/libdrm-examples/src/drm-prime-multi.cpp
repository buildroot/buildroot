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

template <class FROM, class TO, bool ENABLE>
struct _narrowing {
    static_assert (( std::is_arithmetic < FROM > :: value && std::is_arithmetic < TO > :: value ) != false);

    // Not complete, assume zero is minimum for unsigned
    // Common type of signed and unsigned typically is unsigned
    using common_t = typename std::common_type < FROM, TO > :: type;
    static constexpr bool value =   ENABLE
                                    && (
                                        ( std::is_signed < FROM > :: value && std::is_unsigned < TO > :: value )
                                        || static_cast < common_t > ( std::numeric_limits < FROM >::max () ) >= static_cast < common_t > ( std::numeric_limits < TO >::max () )
                                    )
                                    ;
};

class DRM {
    public:

        using fb_id_t = remove_pointer < decltype (drmModeFB::fb_id) >::type;
        using crtc_id_t = remove_pointer < decltype (drmModeCrtc::crtc_id) >::type;
        using enc_id_t = remove_pointer < decltype (drmModeEncoder::encoder_id) >::type;
        using conn_id_t = remove_pointer < decltype (drmModeConnector::connector_id) >::type;

        using width_t = remove_pointer < decltype (drmModeFB2::width) >::type;
        using height_t = remove_pointer < decltype (drmModeFB2::height) >::type;
        using frmt_t = remove_pointer < decltype (drmModeFB2::pixel_format) >::type;
        using modifier_t = remove_pointer < decltype (drmModeFB2::modifier) >::type;

        using handle_t = remove_pointer < std::decay < decltype (drmModeFB2::handles) >::type >::type;
        using pitch_t = remove_pointer < std::decay < decltype (drmModeFB2::pitches) >::type >::type;
        using offset_t = remove_pointer < std::decay < decltype (drmModeFB2::offsets) >::type >::type;

// TODO: absent in FB2
//        using bpp_t = remove_pointer < decltype (drmModeFB::bpp) >::type;

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

                using width_t = remove_pointer < decltype (gbm_import_fd_modifier_data::width) >::type;
                using height_t = remove_pointer < decltype (gbm_import_fd_modifier_data::height) >::type;
                using frmt_t = remove_pointer < decltype (gbm_import_fd_modifier_data::format) >::type;

                // See xf86drmMode.h for magic constant
                static_assert (GBM_MAX_PLANES == 4);

                using fd_t = remove_pointer < std::decay < decltype (gbm_import_fd_modifier_data::fds) > :: type >::type;
                using stride_t = remove_pointer < std::decay < decltype (gbm_import_fd_modifier_data::strides) > :: type >::type;
                using offset_t = remove_pointer < std::decay < decltype (gbm_import_fd_modifier_data::offsets) > :: type >::type;
                using modifier_t = remove_pointer < decltype (gbm_import_fd_modifier_data::modifier) >::type;

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
                    frmt_t _frmt;
                    modifier_t _modifier;

                    bool operator != (struct prime const & rhs) const { return /*_buf != rhs._buf || */ _fd != rhs._fd /* _width != InvalidWidth () || _height != InvalidHeight () */; }
                } _prime;

                width_t const _width;
                height_t const _height;
                stride_t _stride;
                frmt_t _frmt;
                modifier_t _modifier;

                static_assert (is_same <decltype (GBM_BO_USE_SCANOUT), decltype (GBM_BO_USE_RENDERING)>::value != false);

                static_assert (sizeof (gbm_bo_flags) >= sizeof (decltype (GBM_BO_USE_SCANOUT)));
                static_assert (std::numeric_limits < decltype (GBM_BO_USE_SCANOUT) >::min () >= std::numeric_limits < gbm_bo_flags >::min ());
                static_assert (std::numeric_limits < decltype (GBM_BO_USE_SCANOUT) >::max () <= std::numeric_limits < gbm_bo_flags >::max ());

                static constexpr gbm_bo_flags _flags = static_cast <gbm_bo_flags> (GBM_BO_USE_SCANOUT | GBM_BO_USE_RENDERING | GBM_BO_USE_LINEAR);

                bool const _valid;

            public:

                using prime_t = decltype (_prime);
                using _valid_t = decltype (_valid);

                using flags_t = decltype (_flags);

                using valid_t = decltype (_valid);

//                static_assert (is_same <fd_t, DRM::fd_t>::value != false);

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
                static constexpr stride_t InvalidFrmt () { return DRM::InvalidFrmt (); }
                static constexpr stride_t InvalidModifier () { return DRM::InvalidModifier (); }

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
        static constexpr frmt_t InvalidFrmt () { return DRM_FORMAT_INVALID; }
        static constexpr modifier_t InvalidModifier () { return DRM_FORMAT_MOD_INVALID; }

        // Especially, required for headless / off-screen without a mode set
// TODO: instead of default communicated values and use in  platform initialization
        static constexpr width_t DefaultWidth () { return 1920; }
        static constexpr height_t DefaultHeight () { return 1080; }

// TODO: match FB and gbm_bo
        static_assert (_narrowing < decltype (DRM_FORMAT_ARGB8888), frmt_t, true > :: value != false);
        static frmt_t ColorFormat () { return static_cast <frmt_t> (DRM_FORMAT_ARGB8888); }

        static_assert (_narrowing < decltype (DRM_FORMAT_MOD_LINEAR), frmt_t, true > :: value != false);
        static modifier_t FormatModifier () { return static_cast <modifier_t> (DRM_FORMAT_MOD_LINEAR); }

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
    public :

        static constexpr uint8_t _max_images = 2;

    private :

        DRM::GBM /*const*/ & _gbm;

        EGLDisplay _dpy;
        EGLConfig _cfg;
        EGLContext _ctx;
        EGLSurface _surf;

        // Multiple are allowed, possible one for every client
        struct img {
            EGLImageKHR _khr;
            EGLint _width;
            EGLint _height;

            DRM::GBM::frmt_t _format;
            DRM::GBM::modifier_t _modifier;

//            static constexpr width_t InvalidWidth () { return DRM::GBM::InvalidWidth (); }
//            static constexpr height_t InvalidHeight () { return DRM::GBM::InvalidHeight (); }

            bool operator != (struct img const & rhs) const { return _khr != rhs._khr /*|| _width != rhs._width || _height != rhs._height */;}
        }; std::array <struct img, _max_images> _img;

        bool const _valid;

    public :

        using dpy_t = decltype (_dpy);
        using cfg_t = decltype (_cfg);
        using ctx_t = decltype (_ctx);
        using surf_t = decltype (_surf);
        using img_t = img;

        using width_t = decltype (img::_width);
        using height_t = decltype (img::_height);

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

// TODO:: narrowing, range
        static constexpr img_t InvalidImage () { return { EGL_NO_IMAGE_KHR, static_cast <width_t> (DRM::GBM::InvalidWidth ()), static_cast <height_t> (DRM::GBM::InvalidHeight ())}; }

//        static_assert (is_same <DRM::GBM::valid_t, valid_t>::value != false);
        valid_t Status () const { return _gbm.Status () && _valid; }

        img_t const & Image (decltype (_max_images) index = 0) const { return _img [index]; };

        bool ImportBuffer (DRM::GBM::prime_t const & prime, decltype (_max_images) index = 0);
        bool ImportBuffer (DRM::GBM::buf_t const & buf, decltype (_max_images) index = 0);

        bool Render ();

        static constexpr uint8_t _max_textures = EGL::_max_images;

    private :

        bool Clear ();

        bool Init ();
        bool Deinit ();
};

class GLES {
    public :

        // x, y, z
        static constexpr uint8_t VerticeDimensions = 3;

        static constexpr decltype (EGL::_max_images) _max_textures = EGL::_max_images;

    private:

        GLenum const _tgt;
        GLuint _fbo;
// TODO: possibly same number as number of EGL images
        std::array <GLuint, _max_textures> _tex;

        struct offset {
            using coordinate_t = GLfloat;

            coordinate_t _x;
            coordinate_t _y;
            coordinate_t _z;

            static_assert (_narrowing <float, coordinate_t, true> :: value != false);
            offset () : offset (0.0f, 0.0f, 0.0f) {}
            offset (coordinate_t x, coordinate_t y, coordinate_t z) : _x {x}, _y {y}, _z {z} {}
        } _offset;

        struct scale {
            using fraction_t = GLclampf;

            fraction_t _horiz;
            fraction_t _vert;

            static_assert (_narrowing <float, fraction_t, true> :: value != false);
            scale () : scale (1.0f, 1.0f) {};
            scale (fraction_t horiz, fraction_t vert) : _horiz {horiz}, _vert {vert} {}
        } _scale;

        bool const _valid;

    public :

        using tgt_t = decltype (_tgt);
        using fbo_t = decltype (_fbo);
        using tex_t = GLuint;

        using offset_t = decltype (_offset);
        using scale_t = decltype (_scale);

        using valid_t = decltype (_valid);

        // Supported texture targets
// TODO: start using
        enum class TARGETS : tgt_t { TEXTURE_2D = GL_TEXTURE_2D, TEXTURE_OES = GL_TEXTURE_EXTERNAL_OES };

    public :

        GLES () = delete;
// TODO limit options to GL_TEXTURE_EXTERNAL_OES and GL_TEXTURE_2D
       explicit GLES (tgt_t tgt) : _tgt {tgt}, _fbo {InvalidFbo ()}, _valid {Init ()} {}
        ~GLES () { /* bool */ Deinit (); };

//        static constexpr fgt_t InvalidTgt () {...}
        static constexpr fbo_t InvalidFbo () { return 0; }
        static constexpr tex_t InvalidTex () { return 0; }

        valid_t Status () const { return _valid; }

        bool RenderTile ();
        bool RenderTriangle ();
        bool RenderEGLImage (EGL::img_t const & img, decltype (_max_textures) index = 0);
        bool RenderColor (bool red = true, bool green = true, bool blue = true);

        // Valus used at render stages of different objects
        static offset InitialOffset () { return offset (0.0f, 0.0f, 0.0f); }
        bool UpdateOffset (offset_t const & off);
        bool UpdateScale (scale_t const & scale);

    private:

        bool Clear ();

        bool Init ();
        bool Deinit ();

        bool SetupProgram (char const vtx_src [], char const frag_src []);

        template <size_t N>
        bool RenderPolygon (std::array <GLfloat, N> const & vert);
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

        bool CreateRemoteBuffer ();
        bool DestroyRemoteBuffer ();

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

        static constexpr uint8_t _max_renderclients = 2;

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

        bool AwaitRequestCreateSharingBuffer ();
        bool AwaitRequestCompleteSharingBuffer ();

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
    constexpr char _format_tag [] = ";Format:";
    constexpr char _modifier_tag [] = ";Modifier:";

    constexpr uint8_t _id_count = length (_id_tag);
    constexpr uint8_t _width_count = length (_width_tag);
    constexpr uint8_t _height_count = length (_height_tag);
    constexpr uint8_t _stride_count = length (_stride_tag);
    constexpr uint8_t _format_count = length (_format_tag);
    constexpr uint8_t _modifier_count = length (_modifier_tag);

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
            std::string const _format_s = std::to_string (_prime._frmt);
            std::string const _modifier_s = std::to_string (_prime._modifier);

// TODO: total message size
// TODO: more efficient message implementation

            if (_id_s.size () != 0 && _width_s.size () > 0 && _height_s.size () > 0 && _stride_s.size () > 0 && _format_s.size () > 0 && _modifier_s.size () > 0) {
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

                // Format
                _msg.replace ((_id_count + _width_count + _height_count + _stride_count) + _id_s.size () + _width_s.size () + _height_s.size () + _stride_s.size (), _format_count, _format_tag);
                _msg.replace ((_id_count + _width_count + _height_count + _stride_count + _format_count) + _id_s.size () + _width_s.size () + _height_s.size () + _stride_s.size (), _format_s.size (), _format_s.c_str ());

                // Modifier
                _msg.replace ((_id_count + _width_count + _height_count + _stride_count + _format_count) + _id_s.size () + _width_s.size () + _height_s.size () + _stride_s.size () + _format_s.size (), _modifier_count, _modifier_tag);
                _msg.replace ((_id_count + _width_count + _height_count + _stride_count + _format_count + _modifier_count) + _id_s.size () + _width_s.size () + _height_s.size () + _stride_s.size () + _format_s.size (), _modifier_s.size (), _modifier_s.c_str ());

                _ret = Send (_msg, _prime._fd);
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
            size_t _id_p = _msg.find (_id_tag);
            size_t _width_p = _msg.find (_width_tag);
            size_t _height_p = _msg.find (_height_tag);
            size_t _stride_p = _msg.find (_stride_tag);
            size_t _format_p = _msg.find (_format_tag);
            size_t _modifier_p = _msg.find (_modifier_tag);

            if (_id_p != std::string::npos && _width_p != std::string::npos && _height_p != std::string::npos && _stride_p != std::string::npos && _format_p != std::string::npos && _modifier_p != std::string::npos) {
                std::string const _id_s = _msg.substr (_id_p + _id_count, _width_p - _id_p - _id_count);
                std::string const _width_s = _msg.substr (_width_p + _width_count, _height_p - _width_p - _width_count);
                std::string const _height_s = _msg.substr (_height_p + _height_count, _stride_p - _height_p - _height_count);
                std::string const _stride_s = _msg.substr (_stride_p + _stride_count, _format_p - _stride_p - _stride_count );
                std::string const _format_s = _msg.substr (_format_p + _format_count, _modifier_p - _format_p - _format_count);
                std::string const _modifier_s = _msg.substr (_modifier_p + _modifier_count, std::string::npos);

                // Client / compositor ID
                long _val = std::atol (_id_s.c_str ());

                // Underlying buffer width
                /* long */ _val = std::atol (_width_s.c_str ());
                _prime._width = _val != 0 ? _val : DRM::GBM::InvalidWidth ();

                // Underlying buffer height
                /* long */ _val = std::atol (_height_s.c_str ());
                _prime._height = _val != 0 ? _val : DRM::GBM::InvalidHeight ();

                // Underlying buffer stride / pitch
                /* long */ _val = std::atol (_stride_s.c_str ());
                _prime._stride = _val != 0 ? _val : DRM::GBM::InvalidStride ();
                // Underlying buffer stride / pitch

                /// FourCC format
                /* long */ _val = std::atol (_format_s.c_str ());
                _prime._frmt = _val != 0 ? _val : DRM::GBM::InvalidFrmt ();

                /* long */ _val = std::atol (_modifier_s.c_str ());
//                _prime._modifier = _val != 0 ? _val : DRM::GBM::InvalidModifier ();
// TODO: error condition coincides with DRM::GBM::InvalidFormat ();
                _prime._modifier = _val;

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
            else {
                _valid = true;
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

        static_assert (is_same < DRM::width_t, DRM::GBM::width_t > :: value != false);
        static_assert (is_same < DRM::height_t, DRM::GBM::height_t > :: value != false);
        static_assert (is_same < DRM::frmt_t, DRM::GBM::frmt_t > :: value != false);
        static_assert (is_same < DRM::handle_t, DRM::GBM::handle_t > :: value != false);
        static_assert (is_same < DRM::modifier_t, DRM::GBM::modifier_t > :: value != false);

        // Possibly always failing
        if (_narrowing <DRM::pitch_t, DRM::GBM::stride_t, true> :: value != false) {
            std::cout << __FILE__ << " : " << __LINE__ << " : Possible narrowing detected." << std::endl;
        }

// TODO correct place?
        DRM::GBM::width_t _width = gbm_bo_get_width (buf);
        DRM::GBM::height_t _height = gbm_bo_get_height (buf);
        DRM::GBM::frmt_t _format = gbm_bo_get_format (buf);
        DRM::GBM::handle_t _handle = gbm_bo_get_handle (buf).u32;
        DRM::GBM::stride_t _stride = gbm_bo_get_stride (buf);
        DRM::GBM::modifier_t _modifier = gbm_bo_get_modifier (buf);

        if (_fb != DRM::InvalidFb ()) {
// TODO: Do no remove the current FB before the FLIP otherwise EBUSY
//            /* void */ drmModeRmFB (_fd, _fb);
            _fb = DRM::InvalidFb ();
        }

        fb_id_t _fb;

        static_assert (GBM_MAX_PLANES == 4);
        DRM::handle_t const _handles [GBM_MAX_PLANES] = { static_cast < DRM::handle_t > (_handle), 0, 0, 0 };
        DRM::pitch_t const _pitches [GBM_MAX_PLANES] = { static_cast < DRM::pitch_t > (_stride), 0, 0, 0 };
        DRM::offset_t  const _offsets [GBM_MAX_PLANES] = { static_cast < DRM::offset_t > (0), 0, 0, 0 };
        DRM::modifier_t const _modifiers [GBM_MAX_PLANES] = { static_cast < DRM::modifier_t > (_modifier), 0, 0, 0};

        // Possibly always failing
        if (_narrowing <DRM::pitch_t, DRM::GBM::stride_t, true> :: value != false) {
            std::cout << __FILE__ << " : " << __LINE__ << " : Possible narrowing detected." << std::endl;
        }

        if (drmModeAddFB2WithModifiers (_fd, _width, _height, _format, &_handles [0], &_pitches [0], &_offsets [0], &_modifiers [0], &_fb, 0) == 0) {
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
        modifier_t _modifiers [1] = { DRM::FormatModifier () };
        _surf = gbm_surface_create_with_modifiers (_dev, Width (), Height (), _frmt, &_modifiers [0], 1);

// TODO: match EGL
        _ret = _surf != InvalidSurf () && gbm_device_get_format_modifier_plane_count (_dev, _frmt, _modifiers [0]) == 1;
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
        _prime._frmt = gbm_bo_get_format (_prime._buf);
        _prime._modifier = gbm_bo_get_modifier (_prime._buf);

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

        modifier_t _modifiers [1] = { DRM::FormatModifier () };
        _prime._buf = gbm_bo_create_with_modifiers (_dev, Width (), Height (), ColorFormat (), &_modifiers [0], 1);

        if (_prime._buf != InvalidBuf ()) {
            _prime._width = Width ();
            _prime._height = Height ();
            _prime._stride = Pitch (_prime._buf); 
        }

// TODO: match EGL
        _ret = _prime._buf != InvalidBuf () && gbm_bo_get_plane_count (_prime._buf) == 1;
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

bool EGL::ImportBuffer (DRM::GBM::buf_t const & buf, decltype (_max_images) index) {
    bool _ret = false;

    if (index < _max_images) {

    if (buf != DRM::GBM::InvalidBuf ()) {

        using img_t = struct img &; img_t _img = EGL::_img [index];

        if (_img != EGL::InvalidImage ()) {
            static EGLBoolean (* _eglDestroyImageKHR) (EGLDisplay, EGLImageKHR) = reinterpret_cast < EGLBoolean (*) (EGLDisplay, EGLImageKHR) > (eglGetProcAddress ("eglDestroyImageKHR"));

            if (_eglDestroyImageKHR != nullptr) {
                /*EGLBoolean*/ _eglDestroyImageKHR (_dpy, _img._khr);
                _img = EGL::InvalidImage ();
            }
        }

        _img._width = DRM::GBM::Width (buf);
        _img._height = DRM::GBM::Height (buf);

        // Possible narrowing
        if (_narrowing < decltype (_img._width), EGLint, true> :: value
         && _narrowing < decltype (_img._height), EGLint, true> :: value) {
            // Narrowing detectedd
            std::cout << __FILE__ << " : " << __LINE__ << " : Possible narrowing detected." << std::endl;
        }

        EGLint _attrs [] = {
            EGL_WIDTH, static_cast <EGLint> (_img._width),
            EGL_HEIGHT, static_cast <EGLint> (_img._height),
            EGL_IMAGE_PRESERVED_KHR, static_cast <EGLint> (EGL_TRUE),
            EGL_NONE
        };

        static EGLImageKHR (* _eglCreateImageKHR) (EGLDisplay, EGLContext, EGLenum, EGLClientBuffer, EGLint const * ) = reinterpret_cast < EGLImageKHR (*) (EGLDisplay, EGLContext, EGLenum, EGLClientBuffer, EGLint const * ) > (eglGetProcAddress ("eglCreateImageKHR"));

        if (_eglCreateImageKHR != nullptr) {
            _img._khr = _eglCreateImageKHR (_dpy, EGL_NO_CONTEXT, EGL_NATIVE_PIXMAP_KHR, buf, _attrs);
        }

        _ret = _img != EGL::InvalidImage ();

    }

    }

    return _ret;
}

bool EGL::ImportBuffer (DRM::GBM::prime_t const & prime, decltype (_max_images) index) {
    bool _ret = false;

    if (index < _max_images) {

// TODO invalid dimension and color formats

    // Destruction also done via ImportPrime
    if (prime != DRM::GBM::InvalidPrime () /*&& DestroyPrime () */){

        using img_t = struct img &; img_t _img = EGL::_img [index];

        if (_img != EGL::InvalidImage ()) {
            static EGLBoolean (* _eglDestroyImageKHR) (EGLDisplay, EGLImageKHR) = reinterpret_cast < EGLBoolean (*) (EGLDisplay, EGLImageKHR) > (eglGetProcAddress ("eglDestroyImageKHR"));

            if (_eglDestroyImageKHR != nullptr) {
                /*EGLBoolean*/ _eglDestroyImageKHR (_dpy, _img._khr);
                _img = EGL::InvalidImage ();
            }
        }

        // Possible narrowing
        if (_narrowing < decltype (prime._width), EGLint, true> :: value
         && _narrowing < decltype (prime._height), EGLint, true> :: value
         && _narrowing < decltype (prime._stride), EGLint, true> :: value
         && _narrowing < decltype (prime._modifier), EGLuint64KHR, true> :: value
         ) {
            // Narrowing detectedd
            std::cout << __FILE__ << " : " << __LINE__ << " : Possible narrowing detected." << std::endl;
        }

        EGLint _attrs [] = {
            EGL_WIDTH,  static_cast <EGLint> (prime._width),
            EGL_HEIGHT, static_cast <EGLint> (prime._height),
            EGL_LINUX_DRM_FOURCC_EXT, static_cast <EGLint> (prime._frmt),
            EGL_DMA_BUF_PLANE0_FD_EXT, static_cast <EGLint> (prime._fd),
// TODO: magic constant ?
            EGL_DMA_BUF_PLANE0_OFFSET_EXT, 0,
            EGL_DMA_BUF_PLANE0_PITCH_EXT, static_cast <EGLint> (prime._stride),
            EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT, static_cast <EGLint> (prime._modifier & 0xFFFFFFFF),
            EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT, static_cast <EGLint> (prime._modifier >> 32),
            EGL_IMAGE_PRESERVED_KHR, static_cast <EGLint >(EGL_TRUE),
            EGL_NONE
        };

        static EGLImageKHR (* _eglCreateImageKHR) (EGLDisplay, EGLContext, EGLenum, EGLClientBuffer, EGLint const * ) = reinterpret_cast < EGLImageKHR (*) (EGLDisplay, EGLContext, EGLenum, EGLClientBuffer, EGLint const * ) > (eglGetProcAddress ("eglCreateImageKHR"));

        if (_eglCreateImageKHR != nullptr) {
            _img._khr = _eglCreateImageKHR (_dpy, EGL_NO_CONTEXT, EGL_LINUX_DMA_BUF_EXT, 0, _attrs);
            _img._width = prime._width;
            _img._height = prime._height;
        }

        _ret = _img != EGL::InvalidImage ();
    }

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

    for (size_t _index = 0; _index < _max_images; _index++) {
        EGL::_img [_index] = InvalidImage ();
    }

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

    static_assert (is_same <GLfloat, GLES::offset::coordinate_t>:: value != false);
    std::array <GLfloat, 4 * VerticeDimensions> const _vert = {
        0.0f, 0.0f, 0.0f /* v0 */,
        1.0f, 0.0f, 0.0f /* v1 */,
        0.0f, 1.0f, 0.0f /* v2 */,
        1.0f, 1.0f, 0.0f /* v3 */};

    bool _ret = glGetError () == GL_NO_ERROR
                && RenderColor (true, false, false)
                && SetupProgram (_vtx_src, _frag_src)
                && RenderPolygon (_vert);

    return _ret;
}

bool GLES::RenderTriangle () {
    constexpr char const _vtx_src [] =
        "#version 100                               \n"
        "attribute vec3 position;                   \n"
        "void main () {                             \n"
            "gl_Position = vec4 (position.xyz, 1);  \n"
        "}                                          \n"
        ;

    constexpr char  const _frag_src [] =
        "#version 100                                                           \n"
        "precision mediump float;                                               \n"
        "void main () {                                                         \n"
            "gl_FragColor = vec4 (0.0f, 1.0f, 0.0f, 1.0f);                      \n"
        "}                                                                      \n"
        ;

    static_assert (is_same <GLfloat, GLES::offset::coordinate_t>:: value != false);
    std::array <GLfloat, 3 * VerticeDimensions> const _vert = {
        -1.0f, -1.0f, 0.0f /* v0 */,
        1.0f, -1.0f, 0.0f /* v1 */,
        -1.0f, 1.0f, 0.0f /* v2 */ };

    bool _ret = glGetError () == GL_NO_ERROR
                && RenderColor (false, false, true)
                && SetupProgram (_vtx_src, _frag_src)
                && RenderPolygon (_vert);

    return _ret;
}

// TODO: Code growth if N differs

template <size_t N>
bool GLES::RenderPolygon (std::array <GLfloat, N> const & vert) {
    bool _ret = glGetError () == GL_NO_ERROR;

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
            glVertexAttribPointer (_loc, VerticeDimensions, GL_FLOAT, GL_FALSE, 0, vert.data ());
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false) {
            glEnableVertexAttribArray (_loc);
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false) {
            glDrawArrays (GL_TRIANGLE_STRIP, 0, vert.size () / VerticeDimensions);
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false) {
            glDisableVertexAttribArray (_loc);
            _ret = glGetError () == GL_NO_ERROR;
        }
    }

    return _ret;
}

bool GLES::RenderEGLImage (EGL::img_t const  & img, decltype (_max_textures) index) {
    bool _ret = glGetError () == GL_NO_ERROR && img != EGL::InvalidImage ();
// TODO: add check ?
//    fbo = _tgt != GL_TEXTURE_EXTERNAL_OES;

    if (index < _max_textures) {

        if (_ret != false) {
            glBindTexture(GL_TEXTURE_2D, 0);
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false) {
            glBindFramebuffer (GL_FRAMEBUFFER, 0);
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false) {
            glActiveTexture (GL_TEXTURE0);
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false) {
            if (_tex [index] != InvalidTex ()) {
                glDeleteTextures (1, &_tex [index]);
                _ret = glGetError () == GL_NO_ERROR;
            }

            _tex [index] = InvalidTex ();

            if (_ret != false) {
                glGenTextures (1, &_tex [index]);
                _ret = glGetError () == GL_NO_ERROR;
            }
        }

        if (_ret != false) {
            glBindTexture (_tgt, _tex [index]);
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
                    glFramebufferTexture2D (GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, _tgt, _tex [index], 0 /* level */);
                    _ret = glGetError () == GL_NO_ERROR;
                }
            }
        }

        EGLDisplay _dpy = EGL::InvalidDisplay ();

        if (_ret != false) {
            _dpy = eglGetCurrentDisplay ();
            _ret = eglGetError () == EGL_SUCCESS
                   && _dpy != EGL::InvalidDisplay ();
        }

        EGLSurface _surf = EGL::InvalidSurface ();

        if (_ret != false) {
            _surf = eglGetCurrentSurface (EGL_DRAW);
            _ret  = eglGetError () == EGL_SUCCESS
                    && _surf != EGL::InvalidSurface ();
        }

        EGLint _width = 0, _height = 0;

        if (_ret != false) {
            _ret = eglQuerySurface (_dpy, _surf, EGL_WIDTH, &_width) != EGL_FALSE
                   && eglQuerySurface (_dpy, _surf, EGL_HEIGHT, &_height) != EGL_FALSE
                   && eglGetError () == EGL_SUCCESS;
        }

        GLint _dims [2] = {0, 0};

        if (_ret != false) {
            glGetIntegerv (GL_MAX_VIEWPORT_DIMS, &_dims [0]);
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false) {
            if (_tgt == GL_TEXTURE_EXTERNAL_OES) {
                // Compositor side; Image rendered on surface

#ifdef _QUIRKS
                // glViewport (x, y, width, height)
                //
                // Applied width = width / 2
                // Applied height = height / 2
                // Applied origin's x = width / 2 + x
                // Applied origin's y = height / 2 + y
                //
                // Compensate to origin bottom left and true size by
                // glViewport (-width, -height, width * 2, height * 2)
                //
                // _offset is in the range -1..1 wrt to origin, so the effective value maps to -width to width, -height to height

                constexpr uint8_t _mult = 2;

                using common_t = std::common_type < decltype (_width), decltype (_height), decltype (_mult), decltype (_scale._horiz), decltype (_scale._vert), decltype (_offset._x), decltype (_offset._y), remove_pointer < std::decay < decltype (_dims) > :: type > :: type > :: type;

                common_t _quirk_width = static_cast <common_t> (_width) * static_cast <common_t> (_mult) * static_cast <common_t> (_scale._horiz);
                common_t _quirk_height = static_cast <common_t> (_height) * static_cast <common_t> (_mult) * static_cast <common_t> (_scale._vert);

                common_t _quirk_x = ( static_cast <common_t> (-_width) * static_cast <common_t> (_scale._horiz) ) + ( static_cast <common_t> (_offset._x) * static_cast <common_t> (_width) );
                common_t _quirk_y = ( static_cast <common_t> (-_height) * static_cast <common_t> (_scale._vert) ) + ( static_cast <common_t> (_offset._y) * static_cast <common_t> (_height) );

                if (    _quirk_x < ( -_quirk_width / static_cast <common_t> (_mult) )
                     || _quirk_y < ( -_quirk_height / static_cast <common_t> (_mult) )
                     || _quirk_x  > static_cast <common_t> (0)
                     || _quirk_y  > static_cast <common_t> (0)
                     || _quirk_width > ( static_cast <common_t> (_width) * static_cast <common_t> (_mult) )
                     || _quirk_height > ( static_cast <common_t> (_height) * static_cast <common_t> (_mult) )
                     || static_cast <common_t> (_width) > static_cast <common_t> (_dims [0])
                     || static_cast <common_t> (_height) > static_cast <common_t> (_dims [1])
                ) {
                    // Clipping, or undefined / unknown behavior
                    std::cout << "Warning: possible clipping or unknown behavior detected. [" << _quirk_x << ", " << _quirk_y << ", " << _quirk_width << ", " << _quirk_height << ", " << _width << ", " << _height << ", " << _dims [0] << ", " << _dims [1] << "]" << std::endl;
                }

                glViewport (static_cast <GLint> (_quirk_x), static_cast <GLint> (_quirk_y), static_cast <GLsizei> (_quirk_width), static_cast <GLsizei> (_quirk_height));
#else
                glViewport (0, 0, _width, _height);
#endif

                _ret = glGetError () == GL_NO_ERROR && RenderTile () != false;

                glFinish ();

                _ret = _ret != false && glGetError () == GL_NO_ERROR;
            }
            else {
                // Client side, EGLImage as color attachment

                // Center in the smallest possible dimensions

                constexpr uint8_t _mult = 2;

                using common_t = std::common_type < decltype (_width), decltype (_height), decltype (_mult), remove_pointer < std::decay < decltype (_dims) > :: type > :: type > :: type;

                common_t _prop_width = static_cast <common_t> (_width) > static_cast <common_t> (_dims [0]) ? static_cast <common_t> (_dims [0]) : static_cast <common_t> (_width);
                common_t _prop_height = static_cast <common_t> (_height) > static_cast <common_t> (_dims [1]) ? static_cast <common_t> (_dims [1]) : static_cast <common_t> (_height);

                common_t _prop_x = ( static_cast <common_t> (_width) - _prop_width ) / static_cast <common_t> (_mult);
                common_t _prop_y = ( static_cast <common_t> (_height) - _prop_height ) / static_cast <common_t> (_mult);

                if (   _prop_x > static_cast <common_t> (0)
                    || _prop_y > static_cast <common_t> (0)
                ) {
                    // Clipping
                    std::cout << "Warning: possible clipping detected. [" << _prop_x << ", " << _prop_y << ", " << _prop_width << ", " << _prop_height << ", " << _width << ", " << _height << "]" << std::endl;
                }

                // Image scaled to 'full' size
                glViewport (static_cast <GLint> (_prop_x), static_cast <GLint> (_prop_y), static_cast <GLsizei> (_prop_width), static_cast <GLsizei> (_prop_height));

                _ret = glGetError () == GL_NO_ERROR && RenderTriangle ();

                glFinish ();

                _ret = _ret != false && glGetError () == GL_NO_ERROR;
            }
        }

    }

    return _ret;
}

bool GLES::Clear () {
    bool _ret = false;

    _fbo = InvalidFbo ();

    for (size_t _index = 0; _index < _max_textures; _index++) {
        _tex [_index] = InvalidTex ();
    }

    _offset = GLES::InitialOffset ();

    const_cast <remove_const <valid_t>::type &> (_valid) = false;

    _ret = Status () != true;

    return _ret;
}

bool GLES::RenderColor (bool red, bool green, bool blue) {
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

bool GLES::UpdateOffset (offset_t const & off) {
    bool _ret = false;

    // Ramge check without taking into account rounding errors
    if (    (off._x + 1.0f >= 0.0f)
         && (off._x - 1.0f <= 0.0f)
         && (off._y + 1.0f >= 0.0f)
         && (off._y - 1.0f <= 0.0f) ) {

        _offset = off;

        _ret = true;
    }

    return _ret;
}

bool GLES::UpdateScale (scale_t const & scale) {
    bool _ret = false;

    // Ramge check without taking into account rounding errors

    if (    (scale._horiz <= 1.0f)
         && (scale._vert <= 1.0f) ) {

        _scale = scale;

        _ret = true;
    }

    return _ret;
}

bool GLES::SetupProgram (char const vtx_src [], char const frag_src []) {
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

        if (_ret != false) {
            glUseProgram (_prog);
            _ret = glGetError () == GL_NO_ERROR;
        }

        return _ret;
    };

    auto DeleteCurrentProgram = [] () -> bool {
        bool _ret = glGetError () == GL_NO_ERROR;

        GLuint _prog = 0;

        if (_ret != false) {
            glGetIntegerv (GL_CURRENT_PROGRAM, reinterpret_cast <GLint *> (&_prog));
            _ret = glGetError () == GL_NO_ERROR;
        }

        if (_ret != false && _prog != 0) {

            GLint _count = 0;

            glGetProgramiv (_prog, GL_ATTACHED_SHADERS, &_count);
            _ret = glGetError () == GL_NO_ERROR && _count > 0;

            if (_ret != false) {
                GLuint _shaders [_count];

                glGetAttachedShaders (_prog, _count, static_cast <GLsizei *> (&_count), &_shaders [0]);
                _ret = glGetError () == GL_NO_ERROR;

                if (_ret != false) {
                    for (_count--; _count >= 0; _count--) {
                        glDetachShader (_prog, _shaders [_count]);
                        _ret = _ret && glGetError () == GL_NO_ERROR;
                        glDeleteShader (_shaders [_count]);
                        _ret = _ret && glGetError () == GL_NO_ERROR;
                    }
                }

                if (_ret != false) {
                    glDeleteProgram (_prog);
                    _ret = glGetError () == GL_NO_ERROR;
                }
            }

        }

        return _ret;
    };

    bool _ret = DeleteCurrentProgram ();

    if (_ret != false) {
        GLuint _vtxShader = LoadShader (GL_VERTEX_SHADER, vtx_src);
        GLuint _fragShader = LoadShader (GL_FRAGMENT_SHADER, frag_src);

// TODO: inefficient on every call, reuse compiled program
        _ret = ShadersToProgram(_vtxShader, _fragShader);
    }

    if (_ret != false) {
        glEnable (GL_BLEND);
        _ret = glGetError () == GL_NO_ERROR;
    }

    if (_ret != false) {
        glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
        _ret = glGetError () == GL_NO_ERROR;
    }

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
            _ret = CreateRemoteBuffer () != false && ShareBuffer () != false && Render () != false && DestroyRemoteBuffer () != false;

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

// TODO: signal completion
            }
        }

    }
    else {
        // Error
        std::cout << "Error: unable to initialize." << std::endl;
    }

    return _ret;
}

bool RenderClient::CreateRemoteBuffer () {
    bool _ret = true;

// TODO: communicate over channel

    std::cout << "RenderClient [" << std::to_string (_id) << "] has requested to create a remote buffer" << std::endl;

    return _ret;
}

bool RenderClient::DestroyRemoteBuffer () {
    bool _ret = true;

// TODO: communicate over channel

    std::cout << "RenderClient [" << std::to_string (_id) << "] has requested to destroy a remote buffer" << std::endl;

    return _ret;
}

bool RenderClient::ShareBuffer () {
    bool _ret = Base::ShareBuffer (_priv);

    if (_ret != false) {
        std::cout << "RenderClient [" << std::to_string (_id) << "] has received access to the remote buffer" << std::endl;
    }

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

    constexpr decltype (EGL::_max_images) _index = 0;

    bool _ret = _gles.RenderEGLImage (_egl.Image (_index)) != false && _egl.Render () != false;

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

        while (AwaitRequestCreateSharingBuffer () != false) {

            _ret = CreateSharedBuffer () != false && ShareBuffer () != false && AwaitRequestCompleteSharingBuffer () != false  && Render () != false /* && DestroySharedBuffer () */;

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

bool Compositor::AwaitRequestCreateSharingBuffer () {
    bool _ret = false;

// TODO: communicate over channel

    char _key = '\0';

    while (ReadKey ("Press 'c' to create a shared buffer after a client has requested one, 'Enter' or 'q' to quit", _key) != false && _key != 'q') {
        switch (_key) {
            case 'c'    :   {
                                _ret = true;
                                break;
                            }
            default     :   {
                                continue;
                            }
        }

        break;
    }

    return _ret;
}

bool Compositor::AwaitRequestCompleteSharingBuffer () {
    bool _ret = false;

// TODO: communicate over channel

    char _key = '\0';

    remove_const <decltype (EGL::_max_images) >::type _index = 0;

    while (ReadKey ("Enter the number (id) of the client that has requested and received the shared buffer, 'Enter' or 'q' to quit", _key) != false && _key != 'q') {
        switch (_key) {
           case '0'                        :   /* minimum */
                                                {
                                                    continue;
                                                }
            case '1'                        :   {
                                                    _index = 0;
                                                    break;
                                                }
            case '2'                        :   {
                                                    _index = 1;
                                                    break;
                                                }
            case '0' + EGL::_max_images + 1 :   /* maximum */
            default                         :   /* somewhere between minimum and maximum but not defined */
                                                {
                                                    continue;
                                                }
        }

        break;
    }

    DRM::GBM & _gbm = _drm.Get ();

    DRM::GBM::prime_t _prime = _gbm.Prime ();

    _ret =_egl.ImportBuffer (_prime, _index);

    return _ret;
}

bool Compositor::ShareBuffer () {
    bool _ret = false;

    _ret = Base::ShareBuffer (!_priv);

    return _ret;
}

bool Compositor::Render () {
    bool _ret = false;

    for (remove_const <decltype (EGL::_max_images)>::type _index = 0; _index < EGL::_max_images; _index++) {

// TODO: Images might be invalid or have undefined content

        _ret = _gles.RenderEGLImage (_egl.Image (_index)) || _ret;

        if (_ret != true) {

            break;
        }
    }

    _ret = _ret != false && _egl.Render () != false && _drm.ScanOut () != false;

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

// TODO: link with the additional communication bewteen compositor and clients, currently, just abstracted away in Await* and *RemoteBuffer functions
    constexpr decltype (Compositor::_max_renderclients) _max_childs = Compositor::_max_renderclients;

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
