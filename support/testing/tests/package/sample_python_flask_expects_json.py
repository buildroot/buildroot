from flask import Flask
from flask_expects_json import expects_json
app = Flask(__name__)

schema = {
    'type': 'object',
    'properties': {
        'name': {'type': 'string'},
        'email': {'type': 'string'},
    },
    'required': ['name', 'email']
}


@app.route('/', methods=['POST'])
@expects_json(schema)
def hello_world():
    return 'Hello, World!'
