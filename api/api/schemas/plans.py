from datetime import datetime, date, time

from pydantic import BaseModel, Field, ConfigDict

from .users import UserInfo



class Plan(BaseModel):
    id: int = Field(description="ID plánu", examples=[1,8])
    name: str = Field(description="Název plánu", examples=["Plán 1"])
    plan_date: datetime = Field(description="Datum plánu", examples=["2021-01-01 12:00:00"])
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

class PlanCreate(BaseModel):
    name: str = Field(description="Název plánu", examples=["Plán 1"])
    plan_date: datetime = Field(description="Datum plánu", examples=["2021-01-01 12:00:00"])
    description: str | None = Field(description="Popis plánu", examples=["Popis plánu 1"])
    user_id: int = Field(description="ID uživatele", examples=[1,8])
    
    model_config = ConfigDict(from_attributes=True)
    
class PlanUpdate(BaseModel):
    name: str = Field(description="Název plánu", examples=["Plán 1"])
    plan_date: datetime = Field(description="Datum plánu", examples=["2021-01-01T12:00:00"])
    description: str | None = Field(description="Popis plánu", examples=["Popis plánu 1"])
    
class PlanSuccessResponse(BaseModel):
    plan_id: int = Field(description="ID plánu", examples=[1,8])
    message: str = Field(description="Zpráva", examples=["Nápad byl úspěšně aktualizován"])
    rows_affacted: int = Field(description="Počet ovlivněných řádků", examples=[1])
    
    model_config = ConfigDict(from_attributes=True)
    