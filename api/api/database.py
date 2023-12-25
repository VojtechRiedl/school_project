from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from .schemas.settings import PostgresqlSettings

postgresql_settings = PostgresqlSettings()

DATABASE_URL = URL.create(
    drivername="postgresql",
    username=postgresql_settings.username,
    password=postgresql_settings.password,
    host=postgresql_settings.host,
    port=postgresql_settings.port,
    database=postgresql_settings.database,
)

engine = create_engine(DATABASE_URL)

session = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

def get_db():
    db = session()
    try:
        yield db
    finally:
        db.close()