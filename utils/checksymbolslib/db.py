import re

import checksymbolslib.br as br


choice = 'part of a choice'
definition = 'definition'
helper = 'possible config helper'
legacy_definition = 'legacy definition'
legacy_note = 'legacy note'
legacy_usage = 'legacy usage'
select = 'selected'
usage = 'normal usage'
usage_in_legacy = 'usage inside legacy'
virtual = 'virtual'


class DB:
    def __init__(self):
        self.all_symbols = {}

    def __str__(self):
        return str(self.all_symbols)

    def add_symbol_entry(self, symbol, filename, lineno, entry_type):
        if symbol not in self.all_symbols:
            self.all_symbols[symbol] = {}
        if entry_type not in self.all_symbols[symbol]:
            self.all_symbols[symbol][entry_type] = {}
        if filename not in self.all_symbols[symbol][entry_type]:
            self.all_symbols[symbol][entry_type][filename] = []
        self.all_symbols[symbol][entry_type][filename].append(lineno)

    def add_symbol_choice(self, symbol, filename, lineno):
        self.add_symbol_entry(symbol, filename, lineno, choice)

    def add_symbol_definition(self, symbol, filename, lineno):
        self.add_symbol_entry(symbol, filename, lineno, definition)

    def add_symbol_helper(self, symbol, filename, lineno):
        self.add_symbol_entry(symbol, filename, lineno, helper)

    def add_symbol_legacy_definition(self, symbol, filename, lineno):
        self.add_symbol_entry(symbol, filename, lineno, legacy_definition)

    def add_symbol_legacy_note(self, symbol, filename, lineno):
        self.add_symbol_entry(symbol, filename, lineno, legacy_note)

    def add_symbol_legacy_usage(self, symbol, filename, lineno):
        self.add_symbol_entry(symbol, filename, lineno, legacy_usage)

    def add_symbol_select(self, symbol, filename, lineno):
        self.add_symbol_entry(symbol, filename, lineno, select)

    def add_symbol_usage(self, symbol, filename, lineno):
        self.add_symbol_entry(symbol, filename, lineno, usage)

    def add_symbol_usage_in_legacy(self, symbol, filename, lineno):
        self.add_symbol_entry(symbol, filename, lineno, usage_in_legacy)

    def add_symbol_virtual(self, symbol, filename, lineno):
        self.add_symbol_entry(symbol, filename, lineno, virtual)

    def get_symbols_with_pattern(self, pattern):
        re_pattern = re.compile(r'{}'.format(pattern))
        found_symbols = {}
        for symbol, entries in self.all_symbols.items():
            if not re_pattern.search(symbol):
                continue
            found_symbols[symbol] = entries
        return found_symbols

    def get_warnings_for_choices_selected(self):
        warnings = []
        for symbol, entries in self.all_symbols.items():
            if choice not in entries:
                continue
            if select not in entries:
                continue
            all_items = []
            all_items += entries.get(select, {}).items()
            for filename, linenos in all_items:
                for lineno in linenos:
                    msg = '{} is part of a "choice" and should not be "select"ed'.format(symbol)
                    warnings.append((filename, lineno, msg))
        return warnings

    def get_warnings_for_legacy_symbols_being_used(self):
        warnings = []
        for symbol, entries in self.all_symbols.items():
            if legacy_definition not in entries:
                continue
            if usage not in entries:
                continue
            all_items = []
            all_items += entries.get(usage, {}).items()
            for filename, linenos in all_items:
                for lineno in linenos:
                    msg = '{} is a legacy symbol and should not be referenced'.format(symbol)
                    warnings.append((filename, lineno, msg))
        return warnings

    def get_warnings_for_legacy_symbols_being_defined(self):
        warnings = []
        for symbol, entries in self.all_symbols.items():
            if legacy_definition not in entries:
                continue
            if definition not in entries:
                continue
            all_items = []
            all_items += entries.get(definition, {}).items()
            for filename, linenos in all_items:
                for lineno in linenos:
                    msg = '{} is a legacy symbol and should not be redefined'.format(symbol)
                    warnings.append((filename, lineno, msg))
        return warnings

    def get_warnings_for_symbols_without_definition(self):
        warnings = []
        for symbol, entries in self.all_symbols.items():
            if definition in entries:
                continue
            if legacy_definition in entries:
                continue
            if br.re_host_symbol.search(symbol):
                continue
            if br.is_an_optional_symbol_for_a_roofts(symbol):
                continue
            if symbol in br.symbols_defined_only_at_command_line:
                continue
            if symbol in br.symbols_defined_only_when_using_br2_external:
                continue
            if symbol in br.symbols_defined_only_for_barebox_variant:
                continue
            if symbol in br.symbols_not_defined_for_fake_virtual_packages:
                continue
            if virtual in entries:
                continue
            all_items = []
            all_items += entries.get(usage, {}).items()
            all_items += entries.get(legacy_usage, {}).items()
            all_items += entries.get(usage_in_legacy, {}).items()
            for filename, linenos in all_items:
                for lineno in linenos:
                    msg = '{} referenced but not defined'.format(symbol)
                    warnings.append((filename, lineno, msg))
        return warnings

    def get_warnings_for_symbols_without_usage(self):
        warnings = []
        for symbol, entries in self.all_symbols.items():
            if usage in entries:
                continue
            if usage_in_legacy in entries:
                continue
            if legacy_usage in entries:
                continue
            if symbol in br.symbols_used_only_in_source_code:
                continue
            if symbol in br.symbols_used_only_for_host_variant:
                continue
            if helper in entries:
                continue
            if choice in entries:
                continue
            all_items = []
            all_items += entries.get(definition, {}).items()
            all_items += entries.get(legacy_definition, {}).items()
            for filename, linenos in all_items:
                for lineno in linenos:
                    msg = '{} defined but not referenced'.format(symbol)
                    warnings.append((filename, lineno, msg))
        return warnings

    def get_warnings_for_symbols_with_legacy_note_and_no_comment_on_usage(self):
        warnings = []
        for symbol, entries in self.all_symbols.items():
            if legacy_note not in entries:
                continue
            if legacy_usage in entries:
                continue
            all_items = []
            all_items += entries.get(usage, {}).items()
            for filename, linenos in all_items:
                for lineno in linenos:
                    msg = '{} missing "# legacy"'.format(symbol)
                    warnings.append((filename, lineno, msg))
        return warnings

    def get_warnings_for_symbols_with_legacy_note_and_no_usage(self):
        warnings = []
        for symbol, entries in self.all_symbols.items():
            if legacy_note not in entries:
                continue
            if legacy_usage in entries:
                continue
            if usage in entries:
                continue
            all_items = []
            all_items += entries.get(legacy_note, {}).items()
            for filename, linenos in all_items:
                for lineno in linenos:
                    msg = '{} not referenced but has a comment stating it is'.format(symbol)
                    warnings.append((filename, lineno, msg))
        return warnings
