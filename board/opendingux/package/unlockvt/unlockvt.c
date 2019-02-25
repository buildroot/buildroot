#include <fcntl.h>
#include <linux/fb.h>
#include <linux/kd.h>
#include <linux/vt.h>
#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <unistd.h>

#define FB_TTY "/dev/tty%i"
#define FRAMEBUFFER "/dev/fb0"

int main(int argc, char **argv)
{
	int i;
	int fd;
	char tty[10];
	struct fb_var_screeninfo vinfo;
	void *fb;
	size_t len;

#if 0
	fd = open(FRAMEBUFFER, O_RDWR);
	if (fd < 0) {
		fprintf(stderr, "Unable to open framebuffer\n");
		return 1;
	}

	if (ioctl(fd, FBIOGET_VSCREENINFO, &vinfo) < 0) {
		fprintf(stderr, "Could not get framebuffer info\n");
		close(fd);
		return 1;
	}

	vinfo.bits_per_pixel = 32;
	vinfo.blue.offset = 0;
	vinfo.green.offset = 8;
	vinfo.red.offset = 16;
	vinfo.transp.offset = 24;
	vinfo.red.length = vinfo.green.length = vinfo.blue.length = 8;
	vinfo.transp.length = 0;
	vinfo.xoffset = vinfo.yoffset = 0;

	len = vinfo.xres_virtual * vinfo.yres_virtual * 4;
	fb = mmap(NULL, len, PROT_WRITE, MAP_SHARED, fd, 0);
	if (fb == MAP_FAILED) {
		fprintf(stderr, "Could not map framebuffer\n");
		close(fd);
		return 1;
	}

	memset(fb, 0, len);
	munmap(fb, len);

	ioctl(fd, FBIOPUT_VSCREENINFO, &vinfo);
	close(fd);
#endif

	for (i=0; i < 10; i++) {
		int mode;

		sprintf(tty, FB_TTY, i);
		fd = open(tty, O_RDWR);
		if (fd < 0)
		  continue;

		if (ioctl(fd, KDGETMODE, &mode) < 0) {
			fprintf(stderr, "Unable to get mode for tty %i.\n", i);
			close(fd);
			return 1;
		}

		if (mode != KD_TEXT)
		  break;

		close(fd);
	}

	if (i==10) {
		printf("No graphic tty found.\n");
		return 1;
	}

	printf("Graphic tty found on %s.\n", tty);

	if (ioctl(fd, KDSETMODE, KD_TEXT) < 0)
		fprintf(stderr, "Unable to set keyboard mode.\n");

	if (ioctl(fd, VT_UNLOCKSWITCH, 1) < 0)
		fprintf(stderr, "Unable to unlock terminal.\n");

	close(fd);
	return 0;
}
