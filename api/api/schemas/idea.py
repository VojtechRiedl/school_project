from datetime import datetime, date, time

from pydantic import BaseModel, Field, field_serializer, field_validator, ConfigDict

from .schemas import UserInfo

class Idea(BaseModel):
    idea_id: int = Field(description="ID nápadu", examples=[1,8])
    name: str = Field(description="Název nápadu", examples=["Nápad 1"])
    active: bool = Field(description="Aktivní nápad", examples=[True])
    description: str | None = Field(description="Popis nápadu", examples=["Popis nápadu 1"])
    created: date = Field(description="Datum vytvoření nápadu", examples=["2021-01-01"])
    userInfo: UserInfo = Field(description="Tvůrce nápadu", examples=[
        UserInfo(
            username="Pepa Dlouhý",
            created="2021-01-01 12:00:00",
            last_login="2021-01-01 12:00:00",
            image_path="/static/images/default.png",
        ).model_dump()
    ],)
    accepted: int = Field(description="Počet pro", examples=[1])
    declined: int = Field(description="Počet proti", examples=[1])
    
    model_config = ConfigDict(from_attributes=True)

class IdeaCreate(BaseModel):
    name: str = Field(description="Název nápadu", examples=["Nápad 1"])
    active: bool = Field(description="Aktivní nápad", examples=[True])
    description: str | None = Field(description="Popis nápadu", examples=["Popis nápadu 1"])
    created: date = Field(description="Datum vytvoření nápadu", examples=["2021-01-01"])
    user_id: int = Field(description="ID uživatele", examples=[1,8])
    
    model_config = ConfigDict(from_attributes=True)

class IdeaUpdate(BaseModel):
    name: str = Field(description="Název nápadu", examples=["Nápad 1"])
    active: bool = Field(description="Aktivní nápad", examples=[True])
    description: str | None = Field(description="Popis nápadu", examples=["Popis nápadu 1"])
    
    model_config = ConfigDict(from_attributes=True)
    
class IdeaSuccessResponse(BaseModel):
    idea_id: int = Field(description="ID nápadu", examples=[1,8])
    message: str = Field(description="Zpráva", examples=["Nápad byl úspěšně aktualizován"])
    rows_affacted: int = Field(description="Počet ovlivněných řádků", examples=[1])
    
    model_config = ConfigDict(from_attributes=True)