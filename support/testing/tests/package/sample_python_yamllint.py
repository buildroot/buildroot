# example form https://yamllint.readthedocs.io/en/stable/development.html

from yamllint import (config, linter)

data = '''---
- &anchor
  foo: bar
- *anchor
'''

yaml_config = config.YamlLintConfig("extends: default")
for p in linter.run(data, yaml_config):
    print(p.desc, p.line, p.rule)
