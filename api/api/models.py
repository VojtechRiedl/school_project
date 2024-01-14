from sqlalchemy import Column,Text, TIMESTAMP,DateTime,Date, Float, ForeignKey, Integer, String, Boolean,Time
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from .database import Base

class Users(Base):
    __tablename__ = "users"

    user_id = Column(Integer, primary_key=True, index=True)
    username = Column(String, nullable=False)
    password = Column(String, nullable=False)
    created = Column(DateTime(timezone=False), default=func.now(), nullable=False)
    last_login = Column(DateTime(timezone=False), default=func.now(), nullable=False)

    ideas = relationship("Ideas", back_populates="users")
    votes = relationship("Votes", back_populates="users")
    plans = relationship("Plans", back_populates="users")
    songs = relationship("Songs", back_populates="users")


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


class FavoriteSongs(Base):
    __tablename__ = "favorite_songs"
    
    favorite_song_id = Column(Integer, primary_key=True, index=True,autoincrement=True)
    song_id = Column(Integer, ForeignKey("songs.song_id"), nullable=False)
    user_id = Column(Integer, ForeignKey("users.user_id"), nullable=False)
    
    songs = relationship("Songs", back_populates="favorite_songs")
    users = relationship("Users", back_populates="favorite_songs")

class Songs(Base):
    __tablename__ = "songs"
    
    song_id = Column(Integer, primary_key=True, index=True,autoincrement=True)
    name = Column(String, nullable=False)
    created = Column(DateTime(timezone=False), default=func.now(), nullable=False)
    song_path = Column(String, nullable=True)
    video_path = Column(String, nullable=True)
    yt_link = Column(String, nullable=True)
    text = Column(Text, nullable=True)
    user_id = Column(Integer, ForeignKey("users.user_id"), nullable=False)
    
    users = relationship("Users", back_populates="songs")
