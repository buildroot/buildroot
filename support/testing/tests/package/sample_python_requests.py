import requests

r = requests.get("http://localhost")
assert r.status_code == 200
