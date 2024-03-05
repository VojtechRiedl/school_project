from pydantic_settings import BaseSettings
from pydantic import Extra

class AppSettings(BaseSettings):
    secret_key: str
    root_path: str
    
    class Config:
        extra = "allow"
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
        extra = "allow"
        env_prefix = 'POSTGRESQL_'
        env_file = ".env"
        env_file_encoding = "utf-8"
        case_sensitive = False
        