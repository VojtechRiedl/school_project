from sqlalchemy import Column,Text, TIMESTAMP,DateTime,Date, Float, ForeignKey, Integer, String, Boolean
from sqlalchemy.orm import relationship

from .database import Base

class Users(Base):
    __tablename__ = "users"

    user_id = Column(Integer, primary_key=True, index=True)
    username = Column(String, nullable=False)
    password = Column(String, nullable=False)
    created = Column(DateTime, default=TIMESTAMP, nullable=False)
    last_login = Column(DateTime, default=TIMESTAMP, nullable=False)
    image_path = Column(String, default="default.png", nullable=False)
    white_mode = Column(Boolean, default=True, nullable=False)

    ideas = relationship("Ideas", back_populates="users")
    votes = relationship("Votes", back_populates="users")
    plans = relationship("Plans", back_populates="users")

class Votes(Base):
    __tablename__ = "votes"
    
    vote_id = Column(Integer, primary_key=True, index=True,autoincrement=True)
    idea_id = Column(Integer, ForeignKey("ideas.idea_id"), nullable=False)
    user_id = Column(Integer, ForeignKey("users.user_id"), nullable=False)
    accepted = Column(Boolean, nullable=False)
    
    ideas = relationship("Ideas", back_populates="votes")
    users = relationship("Users", back_populates="votes")

class Ideas(Base):
    __tablename__ = "ideas"

    idea_id = Column(Integer, primary_key=True, index=True,autoincrement=True)
    name = Column(String, nullable=False)
    active = Column(Boolean, default=True, nullable=False)
    description = Column(Text, nullable=True)
    created = Column(Date, nullable=False)
    user_id = Column(Integer, ForeignKey("users.user_id"), nullable=False)

    users = relationship("Users", back_populates="ideas")
    votes = relationship("Votes", back_populates="ideas")
    
    def __init__(self, name, active, description, created, user_id):
        self.name = name
        self.active = active
        self.description = description
        self.created = created
        self.user_id = user_id

class Plans(Base):
    __tablename__ = "plans"
    
    plan_id = Column(Integer, primary_key=True, index=True,autoincrement=True)
    name = Column(String, nullable=False)
    date = Column(DateTime, nullable=False)
    description = Column(Text, nullable=True)

    user_id = Column(Integer, ForeignKey("users.user_id"), nullable=False)
    
    users = relationship("Users", back_populates="plans")
    
    def __init__(self, name, date, description, user_id):
        self.name = name
        self.date = date
        self.description = description
        self.user_id = user_id
    