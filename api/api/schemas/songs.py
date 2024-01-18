from datetime import time, datetime

from pydantic import BaseModel, Field, ConfigDict

class Song(BaseModel):
    song_id: int = Field(description="ID songu", examples=[1,8]) 
    name: str = Field(description="Název songu", examples=["Song 1"])
    created: datetime = Field(description="Datum vytvoření", examples=[datetime.now()])
    video: bool = Field(description="Existence videa", examples=[True])
    sound: bool = Field(description="Existence písničky", examples=[True])
    yt_link: str | None = Field(description="Link na youtube", examples=["https://www.youtube.com/watch?v=dQw4w9WgXcQ"])
    text: str | None = Field(description="Popis songu", examples=["Popis songu 1"])
    user: str = Field(description="Tvůrce songu", examples=["Pepa Dlouhý"])

    model_config = ConfigDict(from_attributes=True)
    
class SongCreate(BaseModel):
    name: str = Field(description="Název songu", examples=["Song 1"])
    yt_link: str | None = Field(description="Link na youtube", examples=["https://www.youtube.com/watch?v=dQw4w9WgXcQ"])
    text: str | None = Field(description="Popis songu", examples=["Popis songu 1"])
    user_id: int = Field(description="ID uživatele", examples=[1,8])
    
    model_config = ConfigDict(from_attributes=True)
    
class SongUpdate(BaseModel):
    
    name: str = Field(description="Název songu", examples=["Song 1"])
    yt_link: str | None = Field(description="Link na youtube", examples=["https://www.youtube.com/watch?v=dQw4w9WgXcQ"])
    text: str | None = Field(description="Popis songu", examples=["Popis songu 1"])
    
    model_config = ConfigDict(from_attributes=True)

class SongSuccessResponse(BaseModel):
    
    song_id: int = Field(description="ID songu", examples=[1,8])
    message: str = Field(description="Zpráva", examples=["Nápad byl úspěšně aktualizován"])
    rows_affacted: int = Field(description="Počet ovlivněných řádků", examples=[1])
    
    model_config = ConfigDict(from_attributes=True)
    
class FavoriteSongCreate(BaseModel):    
    song_id: int = Field(description="ID songu", examples=[1,8])
    user_id: int = Field(description="ID uživatele", examples=[1,8])

    model_config = ConfigDict(from_attributes=True)