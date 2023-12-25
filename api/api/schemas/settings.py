from pydantic_settings import BaseSettings

class AppSettings(BaseSettings):
    secret_key: str
    root_path: str
    
    class Config:
        env_prefix = 'APP_'
        env_file = ".env"
        env_file_encoding = "utf-8"
        case_sensitive = False

class PostgresqlSettings(BaseSettings):
    host: str
    port: int
    username: str
    password: str
    database: str
    
    class Config:
        env_prefix = 'POSTGRESQL_'
        env_file = ".env"
        env_file_encoding = "utf-8"
        case_sensitive = False