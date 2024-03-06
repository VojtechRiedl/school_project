from datetime import date
from pydantic import BaseModel, Field, ConfigDict

from .users import User

class Vote(BaseModel):
    
    user: User = Field(
        description="Uživatel, který hlasoval",
        examples=[
            User(
                id=1,
                username="Pepa Dlouhý",
                created="2021-01-01 12:00:00",
                last_login="2021-01-01 12:00:00"
            ).model_dump()
        ]
    )
    accepted: bool = Field(description="Hlas pro/proti", examples=[True, False])
    
    model_config = ConfigDict(from_attributes=True)


class Idea(BaseModel):
    id: int = Field(description="ID nápadu", examples=[1,8])
    title: str = Field(description="Název nápadu", examples=["Nápad 1"])
    description: str | None = Field(description="Popis nápadu", examples=["Popis nápadu 1"])
    deadline: date | None = Field(description="Datum uzávěrky", examples=["2021-01-01"])
    created: date = Field(description="Datum vytvoření nápadu", examples=["2021-01-01"])
    user: User  = Field(description="Tvůrce nápadu", examples=[
        User(
            id=1,
            username="Pepa Dlouhý",
            created="2021-01-01 12:00:00",
            last_login="2021-01-01 12:00:00"
        ).model_dump()
    ])
    
    votes: list[Vote] | None = Field(
        description="Seznam hlasů",
        examples=[
            [Vote(
                user=User(
                    id=1,
                    username="Pepa Dlouhý",
                    created="2021-01-01 12:00:00",
                    last_login="2021-01-01 12:00:00"
                ),
                accepted=True
            ).model_dump()]
        ]
    )
    
    model_config = ConfigDict(from_attributes=True)

class IdeaCreate(BaseModel):
    title: str = Field(description="Název nápadu", examples=["Nápad 1"])
    description: str | None = Field(description="Popis nápadu", examples=["Popis nápadu 1"])
    deadline: date = Field(description="Datum expirace nápadu", examples=["2021-01-01"])
    user_id: int = Field(description="ID uživatele", examples=[1,8])
    
    model_config = ConfigDict(from_attributes=True)

class VoteCreate(BaseModel):    
    
    idea_id: int = Field(description="ID nápadu", examples=[1,8])
    user_id: int = Field(description="ID uživatele", examples=[1,8])
    accepted: bool = Field(description="Hlas pro/proti", examples=[True, False])
    
    model_config = ConfigDict(from_attributes=True)

class IdeaUpdate(BaseModel):
    name: str = Field(description="Název nápadu", examples=["Nápad 1"])
    active: bool = Field(description="Aktivní nápad", examples=[True])
    description: str | None = Field(description="Popis nápadu", examples=["Popis nápadu 1"])
    
    model_config = ConfigDict(from_attributes=True)
