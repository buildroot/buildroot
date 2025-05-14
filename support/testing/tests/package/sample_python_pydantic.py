from datetime import datetime

from pydantic import BaseModel, PositiveInt


class User(BaseModel):
    id: int
    name: str = "John Doe"
    signup_ts: datetime | None
    tastes: dict[str, PositiveInt]


external_data = {
    "id": 123,
    "signup_ts": "2019-06-01 12:22",
    "tastes": {
        "wine": 9,
        b"cheese": 7,
        "cabbage": "1",
    },
}

user = User(**external_data)
expected_user_dump = {
    "id": 123,
    "name": "John Doe",
    "signup_ts": datetime(2019, 6, 1, 12, 22),
    "tastes": {"wine": 9, "cheese": 7, "cabbage": 1},
}

assert user.id == 123
assert user.model_dump() == expected_user_dump
