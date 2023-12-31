from datetime import datetime, date, time

from pydantic import BaseModel, Field, field_serializer, field_validator, ConfigDict

from .users import UserInfo

class Song(BaseModel):
    id: int = Field(description="ID songu", examples=[1,8]) 
    name: str = Field(description="Název songu", examples=["Song 1"])
    duration: time = Field(description="Délka songu", examples=["00:01:05"])
    song_path: str | None = Field(description="Cesta k songu", examples=["/static/songs/song1.mp3"])
    video_path: str | None = Field(description="Cesta k videu", examples=["/static/videos/video1.mp4"])
    yt_link: str | None = Field(description="Link na youtube", examples=["https://www.youtube.com/watch?v=dQw4w9WgXcQ"])
    description: str | None = Field(description="Popis songu", examples=["Popis songu 1"])
    userInfo: UserInfo = Field(description="Tvůrce songu", examples=[
        UserInfo(
            username="Pepa Dlouhý",
            created="2021-01-01 12:00:00",
            last_login="2021-01-01 12:00:00",
            image_path="/static/images/default.png",
        ).model_dump()
    ],)

    model_config = ConfigDict(from_attributes=True)
    
class SongCreate(BaseModel):
    name: str = Field(description="Název songu", examples=["Song 1"])
    duration: time = Field(description="Délka songu", examples=["00:01:05"])
    song_path: str | None = Field(description="Cesta k songu", examples=["/static/songs/song1.mp3"])
    video_path: str | None = Field(description="Cesta k videu", examples=["/static/videos/video1.mp4"])
    yt_link: str | None = Field(description="Link na youtube", examples=["https://www.youtube.com/watch?v=dQw4w9WgXcQ"])
    description: str | None = Field(description="Popis songu", examples=["Popis songu 1"])
    user_id: int = Field(description="ID uživatele", examples=[1,8])
    
    model_config = ConfigDict(from_attributes=True)
    
class SongUpdate(BaseModel):
    
    name: str = Field(description="Název songu", examples=["Song 1"])
    duration: time = Field(description="Délka songu", examples=["00:01:05"])
    song_path: str | None = Field(description="Cesta k songu", examples=["/static/songs/song1.mp3"])
    video_path: str | None = Field(description="Cesta k videu", examples=["/static/videos/video1.mp4"])
    yt_link: str | None = Field(description="Link na youtube", examples=["https://www.youtube.com/watch?v=dQw4w9WgXcQ"])
    description: str | None = Field(description="Popis songu", examples=["Popis songu 1"])
    
    model_config = ConfigDict(from_attributes=True)

class SongSuccessResponse(BaseModel):
    
    song_id: int = Field(description="ID songu", examples=[1,8])
    message: str = Field(description="Zpráva", examples=["Nápad byl úspěšně aktualizován"])
    rows_affacted: int = Field(description="Počet ovlivněných řádků", examples=[1])
    
    model_config = ConfigDict(from_attributes=True)