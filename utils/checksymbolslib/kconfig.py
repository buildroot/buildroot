import os

import checksymbolslib.br as br


def all_symbols_from(line):
    clean_line = br.re_comments.sub('', line)
    symbols = br.re_kconfig_symbol.findall(clean_line)
    return symbols


def handle_definition(db, filename, lineno, line, legacy):
    for symbol in all_symbols_from(line):
        if legacy:
            db.add_symbol_legacy_definition(symbol, filename, lineno)
        else:
            db.add_symbol_definition(symbol, filename, lineno)


def handle_usage(db, filename, lineno, line, legacy):
    for symbol in all_symbols_from(line):
        if legacy:
            db.add_symbol_usage_in_legacy(symbol, filename, lineno)
        else:
            db.add_symbol_usage(symbol, filename, lineno)


def handle_default(db, filename, lineno, line, legacy):
    if legacy:
        handle_usage(db, filename, lineno, line, legacy)
        return
    if not br.re_kconfig_default_legacy_comment.search(line):
        handle_usage(db, filename, lineno, line, legacy)
        return
    after = br.re_kconfig_default_before_conditional.sub('', line)
    for symbol in all_symbols_from(after):
        db.add_symbol_legacy_usage(symbol, filename, lineno)


def handle_select(db, filename, lineno, line, legacy):
    handle_usage(db, filename, lineno, line, legacy)
    before = br.re_kconfig_select_conditional.sub('', line)
    for symbol in all_symbols_from(before):
        db.add_symbol_select(symbol, filename, lineno)


line_type_handlers = {
    br.re_kconfig_config: handle_definition,
    br.re_kconfig_default: handle_default,
    br.re_kconfig_depends: handle_usage,
    br.re_kconfig_if: handle_usage,
    br.re_kconfig_select: handle_select,
    br.re_kconfig_source: handle_usage,
}


def handle_line(db, filename, lineno, line, legacy):
    if not br.re_kconfig_symbol.search(line):
        return

    for regexp, line_type_handler in line_type_handlers.items():
        if regexp.search(line):
            line_type_handler(db, filename, lineno, line, legacy)


def handle_config_helper(db, filename, file_content):
    symbol = None
    lineno = None
    state = 'none'
    for cur_lineno, line in file_content:
        if state == 'none':
            m = br.re_kconfig_config.search(line)
            if m is not None:
                symbol = m.group(2)
                lineno = cur_lineno
                state = 'config'
            continue
        if state == 'config':
            if br.re_kconfig_select.search(line):
                db.add_symbol_helper(symbol, filename, lineno)
                state = 'none'
                continue
            m = br.re_kconfig_config.search(line)
            if m is not None:
                symbol = m.group(2)
                lineno = cur_lineno
            continue


def handle_config_choice(db, filename, file_content):
    state = 'none'
    for lineno, line in file_content:
        if state == 'none':
            if br.re_kconfig_choice.search(line):
                state = 'choice'
                continue
        if state == 'choice':
            if br.re_kconfig_endchoice.search(line):
                state = 'none'
                continue
            m = br.re_kconfig_config.search(line)
            if m is not None:
                symbol = m.group(2)
                db.add_symbol_choice(symbol, filename, lineno)
                continue


def handle_note(db, filename, file_content):
    state = 'none'
    for lineno, line in file_content:
        if state == 'none':
            if br.re_menu.search(line):
                state = 'menu'
                continue
        if state == 'menu':
            if br.re_endmenu.search(line):
                state = 'none'
                continue
            m = br.re_legacy_special_comment.search(line)
            if m is not None:
                symbol = m.group(1)
                db.add_symbol_legacy_note(symbol, filename, lineno)
                continue


def populate_db(db, filename, file_content):
    legacy = filename.endswith('.legacy')
    for lineno, line in file_content:
        handle_line(db, filename, lineno, line, legacy)
    handle_config_helper(db, filename, file_content)
    handle_config_choice(db, filename, file_content)
    if legacy:
        handle_note(db, filename, file_content)


def check_filename(filename):
    if os.path.basename(filename).startswith('Config.'):
        return True
    return False
