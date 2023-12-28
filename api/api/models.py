from sqlalchemy import Column,Text, TIMESTAMP,DateTime,Date, Float, ForeignKey, Integer, String, Boolean
from sqlalchemy.orm import relationship

from .database import Base

class Users(Base):
    __tablename__ = "users"

    user_id = Column(Integer, primary_key=True, index=True)
    username = Column(String)
    password = Column(String)
    created = Column(DateTime)
    last_login = Column(DateTime)
    image_path = Column(String, default="default.png")
    active = Column(Boolean, default=True)

    ideas = relationship("Ideas", back_populates="users")

class Ideas(Base):
    __tablename__ = "ideas"

    idea_id = Column(Integer, primary_key=True, index=True,autoincrement=True)
    name = Column(String)
    active = Column(Boolean, default=True)
    description = Column(Text)
    created = Column(Date)
    user_id = Column(Integer, ForeignKey("users.id"))

