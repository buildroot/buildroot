import checksymbolslib.db as m


def test_empty_db():
    db = m.DB()
    assert str(db) == '{}'


def test_one_definition():
    db = m.DB()
    db.add_symbol_definition('BR2_foo', 'foo/Config.in', 7)
    assert str(db) == str({
        'BR2_foo': {'definition': {'foo/Config.in': [7]}},
        })


def test_three_definitions():
    db = m.DB()
    db.add_symbol_definition('BR2_foo', 'foo/Config.in', 7)
    db.add_symbol_definition('BR2_foo', 'foo/Config.in', 9)
    db.add_symbol_definition('BR2_bar', 'bar/Config.in', 5)
    assert str(db) == str({
        'BR2_foo': {'definition': {'foo/Config.in': [7, 9]}},
        'BR2_bar': {'definition': {'bar/Config.in': [5]}},
        })


def test_definition_and_usage():
    db = m.DB()
    db.add_symbol_definition('BR2_foo', 'foo/Config.in', 7)
    db.add_symbol_usage('BR2_foo', 'foo/Config.in', 9)
    assert str(db) == str({
        'BR2_foo': {'definition': {'foo/Config.in': [7]}, 'normal usage': {'foo/Config.in': [9]}},
        })


def test_all_entry_types():
    db = m.DB()
    db.add_symbol_choice('BR2_foo', 'foo/Config.in', 7)
    db.add_symbol_definition('BR2_foo', 'foo/Config.in', 7)
    db.add_symbol_definition('BR2_bar', 'bar/Config.in', 700)
    db.add_symbol_helper('BR2_bar', 'bar/Config.in', 700)
    db.add_symbol_legacy_definition('BR2_baz', 'Config.in.legacy', 7000)
    db.add_symbol_legacy_note('BR2_baz', 'Config.in.legacy', 7001)
    db.add_symbol_legacy_usage('BR2_bar', 'Config.in.legacy', 7001)
    db.add_symbol_select('BR2_bar', 'Config.in.legacy', 7001)
    db.add_symbol_usage('BR2_foo', 'foo/Config.in', 9)
    db.add_symbol_usage_in_legacy('BR2_bar', 'Config.in.legacy', 9)
    db.add_symbol_virtual('BR2_foo', 'foo/Config.in', 7)
    assert str(db) == str({
        'BR2_foo': {
            'part of a choice': {'foo/Config.in': [7]},
            'definition': {'foo/Config.in': [7]},
            'normal usage': {'foo/Config.in': [9]},
            'virtual': {'foo/Config.in': [7]}},
        'BR2_bar': {
            'definition': {'bar/Config.in': [700]},
            'possible config helper': {'bar/Config.in': [700]},
            'legacy usage': {'Config.in.legacy': [7001]},
            'selected': {'Config.in.legacy': [7001]},
            'usage inside legacy': {'Config.in.legacy': [9]}},
        'BR2_baz': {
            'legacy definition': {'Config.in.legacy': [7000]},
            'legacy note': {'Config.in.legacy': [7001]}},
        })


def test_get_symbols_with_pattern():
    db = m.DB()
    db.add_symbol_definition('BR2_foo', 'foo/Config.in', 7)
    db.add_symbol_usage('BR2_foo', 'foo/Config.in', 9)
    db.add_symbol_definition('BR2_bar', 'bar/Config.in', 5)
    assert str(db) == str({
        'BR2_foo': {'definition': {'foo/Config.in': [7]}, 'normal usage': {'foo/Config.in': [9]}},
        'BR2_bar': {'definition': {'bar/Config.in': [5]}},
        })
    symbols = db.get_symbols_with_pattern('foo')
    assert str(symbols) == str({
        'BR2_foo': {'definition': {'foo/Config.in': [7]}, 'normal usage': {'foo/Config.in': [9]}},
        })
    symbols = db.get_symbols_with_pattern('FOO')
    assert str(symbols) == str({
        })
    symbols = db.get_symbols_with_pattern('foo|FOO')
    assert str(symbols) == str({
        'BR2_foo': {'definition': {'foo/Config.in': [7]}, 'normal usage': {'foo/Config.in': [9]}},
        })
    symbols = db.get_symbols_with_pattern('^foo')
    assert str(symbols) == str({
        })
    symbols = db.get_symbols_with_pattern('foo|bar')
    assert str(symbols) == str({
        'BR2_foo': {'definition': {'foo/Config.in': [7]}, 'normal usage': {'foo/Config.in': [9]}},
        'BR2_bar': {'definition': {'bar/Config.in': [5]}},
        })


def test_get_warnings_for_choices_selected():
    db = m.DB()
    db.add_symbol_choice('BR2_foo', 'foo/Config.in', 1)
    db.add_symbol_choice('BR2_bar', 'bar/Config.in', 1)
    db.add_symbol_select('BR2_foo', 'bar/Config.in', 2)
    assert str(db) == str({
        'BR2_foo': {'part of a choice': {'foo/Config.in': [1]}, 'selected': {'bar/Config.in': [2]}},
        'BR2_bar': {'part of a choice': {'bar/Config.in': [1]}},
        })
    warnings = db.get_warnings_for_choices_selected()
    assert warnings == [
        ('bar/Config.in', 2, 'BR2_foo is part of a "choice" and should not be "select"ed'),
        ]


def test_get_warnings_for_legacy_symbols_being_used():
    db = m.DB()
    db.add_symbol_legacy_definition('BR2_foo', 'Config.in.legacy', 1)
    db.add_symbol_usage('BR2_foo', 'bar/Config.in', 2)
    db.add_symbol_legacy_definition('BR2_bar', 'Config.in.legacy', 10)
    db.add_symbol_usage_in_legacy('BR2_bar', 'Config.in.legacy', 11)
    assert str(db) == str({
        'BR2_foo': {'legacy definition': {'Config.in.legacy': [1]}, 'normal usage': {'bar/Config.in': [2]}},
        'BR2_bar': {'legacy definition': {'Config.in.legacy': [10]}, 'usage inside legacy': {'Config.in.legacy': [11]}},
        })
    warnings = db.get_warnings_for_legacy_symbols_being_used()
    assert warnings == [
        ('bar/Config.in', 2, 'BR2_foo is a legacy symbol and should not be referenced'),
        ]


def test_get_warnings_for_legacy_symbols_being_defined():
    db = m.DB()
    db.add_symbol_legacy_definition('BR2_foo', 'Config.in.legacy', 1)
    db.add_symbol_legacy_definition('BR2_bar', 'Config.in.legacy', 10)
    db.add_symbol_definition('BR2_foo', 'foo/Config.in', 7)
    db.add_symbol_definition('BR2_foo', 'foo/Config.in', 8)
    assert str(db) == str({
        'BR2_foo': {'legacy definition': {'Config.in.legacy': [1]}, 'definition': {'foo/Config.in': [7, 8]}},
        'BR2_bar': {'legacy definition': {'Config.in.legacy': [10]}},
        })
    warnings = db.get_warnings_for_legacy_symbols_being_defined()
    assert warnings == [
        ('foo/Config.in', 7, 'BR2_foo is a legacy symbol and should not be redefined'),
        ('foo/Config.in', 8, 'BR2_foo is a legacy symbol and should not be redefined'),
        ]


def test_get_warnings_for_symbols_without_definition():
    db = m.DB()
    db.add_symbol_definition('BR2_foo', 'foo/Config.in', 7)
    db.add_symbol_legacy_definition('BR2_bar', 'Config.in.legacy', 10)
    db.add_symbol_virtual('BR2_baz', 'baz/Config.in', 7)
    db.add_symbol_usage('BR2_foo', 'file', 1)
    db.add_symbol_usage('BR2_bar', 'file', 1)
    db.add_symbol_usage('BR2_baz', 'file', 1)
    db.add_symbol_usage('BR2_undef1', 'file', 1)
    db.add_symbol_legacy_usage('BR2_undef2', 'file', 2)
    db.add_symbol_usage_in_legacy('BR2_undef3', 'file', 3)
    db.add_symbol_usage('BR2_undef3', 'another', 1)
    db.add_symbol_legacy_usage('BR2_undef3', 'another', 2)
    db.add_symbol_usage('BR2_PACKAGE_HOST_undef', 'file', 1)
    db.add_symbol_usage('BR2_PACKAGE_HAS_HOST_undef', 'file', 1)
    db.add_symbol_usage('BR2_TARGET_ROOTFS_undef_XZ', 'file', 1)
    db.add_symbol_usage('BR2_GRAPH_ALT', 'file', 1)
    db.add_symbol_usage('BR2_EXTERNAL', 'file', 1)
    db.add_symbol_usage('BR2_TARGET_BAREBOX_AUX_BAREBOXENV', 'file', 1)
    db.add_symbol_usage('BR2_PACKAGE_HAS_TOOLCHAIN_BUILDROOT', 'file', 1)
    assert str(db) == str({
        'BR2_foo': {'definition': {'foo/Config.in': [7]}, 'normal usage': {'file': [1]}},
        'BR2_bar': {'legacy definition': {'Config.in.legacy': [10]}, 'normal usage': {'file': [1]}},
        'BR2_baz': {'virtual': {'baz/Config.in': [7]}, 'normal usage': {'file': [1]}},
        'BR2_undef1': {'normal usage': {'file': [1]}},
        'BR2_undef2': {'legacy usage': {'file': [2]}},
        'BR2_undef3': {'usage inside legacy': {'file': [3]}, 'normal usage': {'another': [1]}, 'legacy usage': {'another': [2]}},
        'BR2_PACKAGE_HOST_undef': {'normal usage': {'file': [1]}},
        'BR2_PACKAGE_HAS_HOST_undef': {'normal usage': {'file': [1]}},
        'BR2_TARGET_ROOTFS_undef_XZ': {'normal usage': {'file': [1]}},
        'BR2_GRAPH_ALT': {'normal usage': {'file': [1]}},
        'BR2_EXTERNAL': {'normal usage': {'file': [1]}},
        'BR2_TARGET_BAREBOX_AUX_BAREBOXENV': {'normal usage': {'file': [1]}},
        'BR2_PACKAGE_HAS_TOOLCHAIN_BUILDROOT': {'normal usage': {'file': [1]}},
        })
    warnings = db.get_warnings_for_symbols_without_definition()
    assert warnings == [
        ('file', 1, 'BR2_undef1 referenced but not defined'),
        ('file', 2, 'BR2_undef2 referenced but not defined'),
        ('another', 1, 'BR2_undef3 referenced but not defined'),
        ('another', 2, 'BR2_undef3 referenced but not defined'),
        ('file', 3, 'BR2_undef3 referenced but not defined'),
        ]


def test_get_warnings_for_symbols_without_usage():
    db = m.DB()
    db.add_symbol_definition('BR2_a', 'a/Config.in', 1)
    db.add_symbol_definition('BR2_a', 'a/Config.in', 2)
    db.add_symbol_usage('BR2_a', 'file', 1)
    db.add_symbol_usage('BR2_a', 'file', 2)
    db.add_symbol_definition('BR2_b', 'b/Config.in', 2)
    db.add_symbol_usage_in_legacy('BR2_b', 'file', 1)
    db.add_symbol_definition('BR2_c', 'c/Config.in', 2)
    db.add_symbol_legacy_usage('BR2_c', 'file', 1)
    db.add_symbol_definition('BR2_USE_CCACHE', 'file', 1)
    db.add_symbol_definition('BR2_PACKAGE_SKELETON', 'file', 1)
    db.add_symbol_definition('BR2_d', 'd/Config.in', 2)
    db.add_symbol_helper('BR2_d', 'd/Config.in', 2)
    db.add_symbol_definition('BR2_e', 'e/Config.in', 2)
    db.add_symbol_choice('BR2_e', 'e/Config.in', 2)
    db.add_symbol_definition('BR2_f', 'f/Config.in', 2)
    db.add_symbol_definition('BR2_g', 'g/Config.in', 2)
    db.add_symbol_definition('BR2_g', 'g/Config.in', 3)
    db.add_symbol_legacy_definition('BR2_h', 'Config.in.legacy', 1)
    db.add_symbol_usage('BR2_h', 'file', 2)
    db.add_symbol_usage('BR2_h', 'file', 3)
    db.add_symbol_legacy_definition('BR2_i', 'Config.in.legacy', 2)
    db.add_symbol_usage_in_legacy('BR2_i', 'file', 2)
    db.add_symbol_legacy_definition('BR2_j', 'Config.in.legacy', 2)
    db.add_symbol_legacy_usage('BR2_j', 'file', 2)
    db.add_symbol_legacy_definition('BR2_k', 'Config.in.legacy', 2)
    db.add_symbol_usage('BR2_k', 'file', 5)
    db.add_symbol_usage_in_legacy('BR2_k', 'file', 6)
    db.add_symbol_legacy_usage('BR2_k', 'file', 7)
    db.add_symbol_legacy_definition('BR2_l', 'Config.in.legacy', 2)
    assert str(db) == str({
        'BR2_a': {'definition': {'a/Config.in': [1, 2]}, 'normal usage': {'file': [1, 2]}},
        'BR2_b': {'definition': {'b/Config.in': [2]}, 'usage inside legacy': {'file': [1]}},
        'BR2_c': {'definition': {'c/Config.in': [2]}, 'legacy usage': {'file': [1]}},
        'BR2_USE_CCACHE': {'definition': {'file': [1]}},
        'BR2_PACKAGE_SKELETON': {'definition': {'file': [1]}},
        'BR2_d': {'definition': {'d/Config.in': [2]}, 'possible config helper': {'d/Config.in': [2]}},
        'BR2_e': {'definition': {'e/Config.in': [2]}, 'part of a choice': {'e/Config.in': [2]}},
        'BR2_f': {'definition': {'f/Config.in': [2]}},
        'BR2_g': {'definition': {'g/Config.in': [2, 3]}},
        'BR2_h': {'legacy definition': {'Config.in.legacy': [1]}, 'normal usage': {'file': [2, 3]}},
        'BR2_i': {'legacy definition': {'Config.in.legacy': [2]}, 'usage inside legacy': {'file': [2]}},
        'BR2_j': {'legacy definition': {'Config.in.legacy': [2]}, 'legacy usage': {'file': [2]}},
        'BR2_k': {
            'legacy definition': {'Config.in.legacy': [2]},
            'normal usage': {'file': [5]},
            'usage inside legacy': {'file': [6]},
            'legacy usage': {'file': [7]}},
        'BR2_l': {'legacy definition': {'Config.in.legacy': [2]}},
        })
    warnings = db.get_warnings_for_symbols_without_usage()
    assert warnings == [
        ('f/Config.in', 2, 'BR2_f defined but not referenced'),
        ('g/Config.in', 2, 'BR2_g defined but not referenced'),
        ('g/Config.in', 3, 'BR2_g defined but not referenced'),
        ('Config.in.legacy', 2, 'BR2_l defined but not referenced'),
        ]


def test_get_warnings_for_symbols_with_legacy_note_and_no_comment_on_usage():
    db = m.DB()
    db.add_symbol_legacy_note('BR2_foo', 'Config.in.legacy', 1)
    db.add_symbol_legacy_usage('BR2_foo', 'package/bar/Config.in', 2)
    db.add_symbol_legacy_note('BR2_baz', 'Config.in.legacy', 7001)
    db.add_symbol_usage('BR2_baz', 'package/foo/Config.in', 1)
    assert str(db) == str({
        'BR2_foo': {'legacy note': {'Config.in.legacy': [1]}, 'legacy usage': {'package/bar/Config.in': [2]}},
        'BR2_baz': {'legacy note': {'Config.in.legacy': [7001]}, 'normal usage': {'package/foo/Config.in': [1]}},
        })
    warnings = db.get_warnings_for_symbols_with_legacy_note_and_no_comment_on_usage()
    assert warnings == [
        ('package/foo/Config.in', 1, 'BR2_baz missing "# legacy"'),
        ]


def test_get_warnings_for_symbols_with_legacy_note_and_no_usage():
    db = m.DB()
    db.add_symbol_legacy_note('BR2_foo', 'Config.in.legacy', 1)
    db.add_symbol_legacy_usage('BR2_foo', 'package/bar/Config.in', 2)
    db.add_symbol_legacy_note('BR2_bar', 'Config.in.legacy', 1)
    db.add_symbol_usage_in_legacy('BR2_bar', 'Config.in.legacy', 7001)
    db.add_symbol_legacy_note('BR2_baz', 'Config.in.legacy', 7001)
    db.add_symbol_legacy_note('BR2_no_comment', 'Config.in.legacy', 1)
    db.add_symbol_usage('BR2_no_comment', 'package/bar/Config.in', 2)
    assert str(db) == str({
        'BR2_foo': {'legacy note': {'Config.in.legacy': [1]}, 'legacy usage': {'package/bar/Config.in': [2]}},
        'BR2_bar': {'legacy note': {'Config.in.legacy': [1]}, 'usage inside legacy': {'Config.in.legacy': [7001]}},
        'BR2_baz': {'legacy note': {'Config.in.legacy': [7001]}},
        'BR2_no_comment': {'legacy note': {'Config.in.legacy': [1]}, 'normal usage': {'package/bar/Config.in': [2]}},
        })
    warnings = db.get_warnings_for_symbols_with_legacy_note_and_no_usage()
    assert warnings == [
        ('Config.in.legacy', 1, 'BR2_bar not referenced but has a comment stating it is'),
        ('Config.in.legacy', 7001, 'BR2_baz not referenced but has a comment stating it is'),
        ]
