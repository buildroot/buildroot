def assert_calls(method, expected_calls):
    method.assert_has_calls(expected_calls, any_order=True)
    assert method.call_count == len(expected_calls)


def assert_db_calls(db, expected_calls):
    assert_calls(db.add_symbol_legacy_definition, expected_calls.get('add_symbol_legacy_definition', []))
    assert_calls(db.add_symbol_definition, expected_calls.get('add_symbol_definition', []))
    assert_calls(db.add_symbol_usage_in_legacy, expected_calls.get('add_symbol_usage_in_legacy', []))
    assert_calls(db.add_symbol_usage, expected_calls.get('add_symbol_usage', []))
    assert_calls(db.add_symbol_legacy_usage, expected_calls.get('add_symbol_legacy_usage', []))
    assert_calls(db.add_symbol_select, expected_calls.get('add_symbol_select', []))
    assert_calls(db.add_symbol_helper, expected_calls.get('add_symbol_helper', []))
    assert_calls(db.add_symbol_legacy_note, expected_calls.get('add_symbol_legacy_note', []))
    assert_calls(db.add_symbol_virtual, expected_calls.get('add_symbol_virtual', []))
