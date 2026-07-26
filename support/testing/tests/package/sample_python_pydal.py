# From:
# https://github.com/web2py/pydal/tree/v20260313.1#usage-and-documentation
from pydal import DAL, Field
db = DAL('sqlite://storage.db')
db.define_table('thing', Field('name'))
db.thing.insert(name='Chair')
query = db.thing.name.startswith('C')
rows = db(query).select()
print(rows[0].name)
assert rows[0].name == "Chair"
db.commit()
