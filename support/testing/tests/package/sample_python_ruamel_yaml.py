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
