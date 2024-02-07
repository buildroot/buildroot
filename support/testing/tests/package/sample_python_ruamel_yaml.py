from ruamel.yaml import YAML

yaml_text = """
Rootkey:
  - ListEntry
AnotherRootKey: some-string

ListRoot:
  - float-value: '1.0'
    int-value: 10234
    NestedList:
      - 1
      - 2

  - another-float: '1.1'
    another-int: 1111

OneMoreRootKey: 9.99
"""

# Tests the pure python based implementation
yaml = YAML(typ='safe', pure=True)

parsed = yaml.load(yaml_text)

assert parsed['OneMoreRootKey'] == 9.99
assert parsed['ListRoot'][1]['another-int'] == 1111

# Tests the C extension based loader
# ruamel.yaml automatically falls back to the pure python version, so we need
# to explicitly check if importing the CLoader works here.
# Import this here, so it's clearer what part of the test is failing.
from ruamel.yaml import CLoader  # noqa: E402
assert CLoader is not None
yaml = YAML(typ='safe')
parsed_from_c = yaml.load(yaml_text)

assert parsed_from_c['OneMoreRootKey'] == 9.99
assert parsed_from_c['ListRoot'][1]['another-int'] == 1111
