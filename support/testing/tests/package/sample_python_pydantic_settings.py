from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    api_key: str


assert Settings().api_key == "ABCD1234"
