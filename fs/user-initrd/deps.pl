#!/usr/bin/perl -w

use Getopt::Long;
use strict;

my @deps;
my $logh;
my $argc = $#ARGV + 1;

if ($argc < 7) {
	printf("Dependency finder for initrd.");
	printf("Error: not enough parameters. All the parameters below are obligatory.\n");
	printf("Usage:\n");
	printf("\nInput parameters:\n");
	printf("--ld-linux:	Full path to host ld-linux.so dynamic linker\n");
	printf("		example: --ld-linux=/devel/buildroot/output/host/ld-linux-x86-64.so.2\n");
	printf("--lib-dir:	Full path to \"lib\" source directory with the target libraries for resolving libraries dependencies\n");
	printf("		example: --lib-dir=/devel/buildroot/output/target/lib\n");
	printf("--bin-dir:	Full path to \"bin\" source directory with binary ELF executables that will be placed in initrd\n");
	printf("		example: --bin-dir=/devel/buildroot/output/target/bin\n");
	printf("--src-rootfs:	Full path to rootfs source directory\n");
	printf("		example: --src-rootfs=/devel/buildroot/output/target\n");
	printf("--host-dir:	Full path to \"host\" directory \n");
	printf("		example: --host-dir=/devel/output/host\n");
	printf("\nOutput parameters:\n");
	printf("--output-dir:	Full path to output directory with target rootfs filesystem where \"lib\" directory will be filled with libraries\n");
	printf("		example: --output-dir=/devel/buildroot/output/build/user-initrd/skel\n");
	printf("--deps-file:	Full path to file where information about all the found dependencies will be stored\n");
	printf("		example: --deps-file=/devel/buildroot/output/build/user-initrd/deps.txt\n");
	exit;
}

GetOptions(
	'ld-linux=s' => \my $ld_linux,
	'lib-dir=s' => \my $lib_dir,
	'bin-dir=s' => \my $bin_dir,
	'output-dir=s' => \my $output_dir,
	'deps-file=s' => \my $deps_file,
	'src-rootfs=s' => \my $src_rootfs,
	'host-dir=s' => \my $host_dir,
);

if (defined $deps_file) {
	open($logh, ">", $deps_file);
	syswrite($logh, "List of dependencies of binaries and libraries:\n\n");
}

# Check for duplicates and conditionally insert new dependency (library) to @deps array.
sub insert_dependency
{
	my $lib = shift;
	my $i = 0;
	my $end = $#deps + 1;
	my $found = 0;

	while ($i < $end) {
		if ($deps[$i] eq $lib) {
			$found = 1;
			last;
		}
		$i++;
	}

	if (!$found) {
		push(@deps, $lib);
	}
}

# Check dependencies using ld-linux dynamic linker/loader, ldd and objdump.
sub ld_linux
{
	my $n = shift;
	my $objdump = "$host_dir/bin/objdump";
	my $ldd = "$host_dir/sysroot/bin/ldd";

	# Redirect stderrr to /dev/null
	open STDERR, '>/dev/null';

	my $ldlin_out = `$ld_linux --inhibit-cache --library-path $lib_dir --list $n`;

	# Chop ending eol if exists.
	if ($n =~ '[^\\n]+\\n') {
		chop($n);
	}

	# Maintain the libexec corner case.
	if ($ldlin_out eq '') {
		# Run "objdump -p <lib>" and look for RUNPATH.
		my $obj = `$objdump -p $n`;
		(my $runpath) = ($obj =~ '.*RUNPATH\s+([^\\n]+)\n.*');

		# Copy files from libexec directory.
		if (defined $runpath && $runpath ne '') {
			my $s = `ls -la $src_rootfs/$runpath`;
			`mkdir -p $output_dir/$runpath`;
			`cp -ar $src_rootfs/$runpath/* $output_dir/$runpath`;
		}

		# Run "ldd" on library and fetch rest of library's dependencies.
		$ldd = `$ldd $n`;

		# Paths from ldd have no target architecture prefix so add it here:
		my $line = sprintf("\n%s:\n", $n);
		syswrite($logh, $line);
		my @list = split('\n', $ldd);

		foreach my $i (@list) {
			(my $lib, my $path) = ($i =~ "([^ ]+) +=> +([^ ]+).*");
			if (defined $lib && defined $path && $path ne "not") {
				insert_dependency("$src_rootfs/$path");
				syswrite($logh, "	$src_rootfs/$path\n");
			}
		}
	} else {
		# Standard way: use ld-linux.
		# Print header line with the name of the ELF binary or library.
		my $line = sprintf("\n%s:\n", $n);
		syswrite($logh, $line);

		my @list = split('\n', $ldlin_out);
		foreach my $i (@list) {
			(my $lib, my $path) = ($i =~ "([^ ]+) +=> +([^ ]+).*");
			if (defined $lib && defined $path && $path ne "not") {
				insert_dependency($path);
				syswrite($logh, "	$path\n");
			}
		}
	}
}


# Main procedure.

my @elfs = `find $bin_dir/ -type f`;
foreach my $elf (@elfs) {
	my $f = `file -bi $elf`;

	# Only two executable type of files are taken into account:
	# 1. application/x-executable; charset=binary
	# 2. application/x-pie-executable; charset=binary
	my $x_exe = "application/x-executable; charset=binary";
	my $x_piexe = "application/x-pie-executable; charset=binary";
	if ($f =~ /$x_exe/ || $f =~ /$x_piexe/) {
		ld_linux($elf);
	}
}

# Check libraries dependencies.
my $start = 0;
my $end = $#deps + 1;
while (1) {
	while ($start < $end) {
		ld_linux($deps[$start]);
		$start++;
	}

	# Check if after ld_linux() number of elements in @deps array increased.
	# If yes then check dependencies of newly found libraries.
	if ($end != $#deps + 1) {
		$end = $#deps + 1;
	}

	# Exit main loop if all the dependencies already checked.
	if ($start >= $end) {
		last;
	}
}
close($logh);

# Remove ld-linux from @deps because it comes from host tools
# and it is not needed in "lib" directory.
for (my $i = 0; $i < $#deps + 1; $i++) {
	if ($deps[$i] =~ '.*/ld-linux.*') {
		splice(@deps, $i, 1);
	}
}

# Copy libraries to initrd target "lib" directory.
for (my $i = 0; $i < $#deps + 1; $i++) {
	(my $dir, my $libname) = ($deps[$i] =~ '(.*\/)([^\.]+)\..*');
	`cp -a $dir/$libname.*so* $output_dir/lib`;
	`cp -a $dir/$libname-*so* $output_dir/lib >& /dev/null`;
}

# Copy ld-linux from target dir.
`cp -a $lib_dir/ld-linux-* $output_dir/lib/`;
`cp -a $lib_dir/ld-linux.* $output_dir/lib/ >& /dev/null`;
`ln -sf ld-linux-x86-64.so.2 $output_dir/lib/ld-linux.so.2`;
`ln -sf ../lib/ld-linux-x86-64.so.2 $output_dir/bin/ld.so`;


# Make "/etc/ld.so.cache".
`ldconfig $output_dir/lib -r $output_dir`;
