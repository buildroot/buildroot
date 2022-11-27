import checksymbolslib.br as br


def handle_eval(db, filename, lineno, line):
    def add_multiple_symbol_usages(package, prefixes=None, suffixes=None):
        for prefix in prefixes or ['']:
            for sufix in suffixes or ['']:
                symbol = prefix + package + sufix
                db.add_symbol_usage(symbol, filename, lineno)

    package = br.get_package_from_filename(filename)
    if '$(rootfs)' in line:
        suffixes = [''] + br.suffixes_not_defined_for_all_rootfs_types
        add_multiple_symbol_usages(package, prefixes=[br.rootfs_prefix], suffixes=suffixes)
        return
    if '$(kernel-module)' in line:
        add_multiple_symbol_usages(package, prefixes=[br.package_prefix])
        return
    if '$(barebox-package)' in line:
        add_multiple_symbol_usages(package, prefixes=[br.boot_prefix], suffixes=br.barebox_infra_suffixes)
        return

    if '-package)' not in line:
        return
    if package == 'LINUX':
        # very special case at package/pkg-generic.mk
        add_multiple_symbol_usages('BR2_LINUX_KERNEL')
        return

    # mimic package/pkg-generic.mk and package/pkg-virtual.mk
    if '$(virtual-' in line:
        prefixes = ['BR2_PACKAGE_PROVIDES_', 'BR2_PACKAGE_HAS_']
        if filename.startswith('toolchain/'):
            prefix = br.toolchain_prefix
        else:
            prefix = br.package_prefix
        symbol = prefix + package
        db.add_symbol_virtual(symbol, filename, lineno)
        prefixes.append(prefix)
    elif '$(host-virtual-' in line:
        prefixes = ['BR2_PACKAGE_HOST_', 'BR2_PACKAGE_PROVIDES_HOST_', 'BR2_PACKAGE_HAS_HOST_']
    elif '$(host-' in line:
        prefixes = ['BR2_PACKAGE_HOST_']
    elif filename.startswith('boot/'):
        prefixes = [br.boot_prefix]
    elif filename.startswith('toolchain/'):
        prefixes = [br.toolchain_prefix]
    elif '$(toolchain-' in line:
        prefixes = [br.toolchain_prefix]
    else:
        prefixes = [br.package_prefix]

    add_multiple_symbol_usages(package, prefixes=prefixes)


def handle_definition(db, filename, lineno, line, legacy):
    symbols = br.re_makefile_symbol_attribution.findall(line)
    symbols += br.re_makefile_symbol_export.findall(line)
    for symbol in symbols:
        if legacy:
            db.add_symbol_legacy_definition(symbol, filename, lineno)
        else:
            db.add_symbol_definition(symbol, filename, lineno)


def handle_usage(db, filename, lineno, line, legacy):
    if br.re_makefile_eval.search(line):
        handle_eval(db, filename, lineno, line)
        return

    symbols = br.re_makefile_symbol_usage.findall(line)
    for symbol in symbols:
        if legacy:
            db.add_symbol_usage_in_legacy(symbol, filename, lineno)
        else:
            db.add_symbol_usage(symbol, filename, lineno)


def populate_db(db, filename, file_content):
    legacy = filename.endswith('.legacy')
    for lineno, raw_line in file_content:
        line = br.re_comments.sub('', raw_line)
        handle_definition(db, filename, lineno, line, legacy)
        handle_usage(db, filename, lineno, line, legacy)


def check_filename(filename):
    if filename.endswith('.mk'):
        return True
    if filename.endswith('.mk.in'):
        return True
    if filename.startswith('arch/arch.mk.'):
        return True
    if filename in [
            'Makefile',
            'Makefile.legacy',
            'package/Makefile.in'
            ]:
        return True
    return False
