from datetime import datetime, date, time

from pydantic import BaseModel, Field, field_serializer, field_validator


class User(BaseModel):
    id: int
    username: str
    password: str
    created: datetime
    last_login: datetime
    image_path: str
    white_mode: bool

class Idea(BaseModel):
    id: int 
    name: str
    active: bool
    description: str
    created: date
    user: User
    accepted: int
    declined: int
    
class Song(BaseModel):
    id: int
    name: str
    time: time
    song_path: str
    video_path: str
    yt_link: str
    description: str
    User: User

class Plan(BaseModel):
    id: int
    name: str
    date: date
    description: str
    user: User

class IdeasVote(BaseModel):
    User: User
    Idea: Idea
    confirmed: bool
