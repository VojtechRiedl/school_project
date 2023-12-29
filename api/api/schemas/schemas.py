from datetime import datetime, date, time

from pydantic import BaseModel, Field, field_serializer, field_validator, ConfigDict

class Authorization(BaseModel):
    username: str = Field(description="Jméno uživatele", examples=["Pepa Dlouhý"])
    password: str = Field(description="Heslo uživatele", examples=["d4w8as4d5wa4d68was5d4a6dwa9sd9"])

    model_config = ConfigDict(from_attributes=True)
    
class User(BaseModel):
    id: int = Field(description="ID uživatele", examples=[1,8])
    username: str = Field(description="Jméno uživatele", examples=["Pepa Dlouhý"])
    created: datetime = Field(description="Datum vytvoření uživatele", examples=["2021-01-01 12:00:00"])
    last_login: datetime = Field(description="Datum posledního přihlášení uživatele", examples=["2021-01-01 12:00:00"])
    image_path: str = Field(description="Cesta k profilovému obrázku uživatele", examples=["/static/images/default.png"])
    white_mode: bool = Field(description="Bílý mód", examples=[True])
    
    model_config = ConfigDict(from_attributes=True)
    
class UserInfo(BaseModel):
    username: str = Field(description="Jméno uživatele", examples=["Pepa Dlouhý"])
    created: datetime = Field(description="Datum vytvoření uživatele", examples=["2021-01-01 12:00:00"])
    last_login: datetime = Field(description="Datum posledního přihlášení uživatele", examples=["2021-01-01 12:00:00"])
    image_path: str = Field(description="Cesta k profilovému obrázku uživatele", examples=["/static/images/default.png"])

    model_config = ConfigDict(from_attributes=True)

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
    
    
class Plan(BaseModel):
    id: int = Field(description="ID plánu", examples=[1,8])
    name: str = Field(description="Název plánu", examples=["Plán 1"])
    plan_date: date = Field(description="Datum plánu", examples=["2021-01-01"])
    description: str | None = Field(description="Popis plánu", examples=["Popis plánu 1"])
    userInfo: UserInfo = Field(description="Tvůrce plánu", examples=[
        UserInfo(
            username="Pepa Dlouhý",
            created="2021-01-01 12:00:00",
            last_login="2021-01-01 12:00:00",
            image_path="/static/images/default.png"
        ).model_dump()
    ])
    
    model_config = ConfigDict(from_attributes=True)
    