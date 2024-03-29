from sqlalchemy import Column,Text, TIMESTAMP,DateTime,Date, Float, ForeignKey, Integer, String, Boolean,Time
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from .database import Base

class Users(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, nullable=False)
    password = Column(String, nullable=False)
    created = Column(DateTime(timezone=False), default=func.now(), nullable=False)
    last_login = Column(DateTime(timezone=False), default=func.now(), nullable=False)

    ideas = relationship("Ideas", back_populates="user")
    votes = relationship("Votes", back_populates="user")
    plans = relationship("Plans", back_populates="user")
    songs = relationship("Songs", back_populates="users")
    favorite_songs = relationship("FavoriteSongs", back_populates="users")


class Votes(Base):
    __tablename__ = "votes"
    
    vote_id = Column(Integer, primary_key=True, index=True,autoincrement=True)
    idea_id = Column(Integer, ForeignKey("ideas.id"), nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    accepted = Column(Boolean, nullable=False)
    
    ideas = relationship("Ideas", back_populates="votes")
    user = relationship("Users", back_populates="votes")

class Ideas(Base):
    __tablename__ = "ideas"

    id = Column(Integer, primary_key=True, index=True,autoincrement=True)
    title = Column(String, nullable=False)
    description = Column(Text, nullable=True)
    deadline = Column(Date, nullable=True)
    created = Column(Date,default=func.current_date(), nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)

    user = relationship("Users", back_populates="ideas", lazy="joined")
    votes = relationship("Votes", back_populates="ideas", uselist=True, lazy="joined")
    

class Plans(Base):
    __tablename__ = "plans"
    
    id = Column(Integer, primary_key=True, index=True,autoincrement=True)
    title = Column(String, nullable=False)
    date = Column(DateTime, nullable=False)
    description = Column(Text, nullable=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    
    user = relationship("Users", back_populates="plans",lazy="joined")
    
class Songs(Base):
    __tablename__ = "songs"
    
    song_id = Column(Integer, primary_key=True, index=True,autoincrement=True)
    name = Column(String, nullable=False)
    created = Column(DateTime(timezone=False), default=func.now(), nullable=False)
    song_path = Column(String, nullable=True)
    video_path = Column(String, nullable=True)
    yt_link = Column(String, nullable=True)
    text = Column(Text, nullable=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    
    users = relationship("Users", back_populates="songs")
    favorite_songs = relationship("FavoriteSongs", back_populates="songs")

class FavoriteSongs(Base):
    __tablename__ = "favorite_songs"
    
    favorite_song_id = Column(Integer, primary_key=True, index=True,autoincrement=True)
    song_id = Column(Integer, ForeignKey("songs.song_id"), nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    
    songs = relationship("Songs", back_populates="favorite_songs")
    users = relationship("Users", back_populates="favorite_songs")