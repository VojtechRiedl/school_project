from datetime import datetime, date, time

from pydantic import BaseModel, Field, field_serializer, field_validator, ConfigDict

class Authorization(BaseModel):
    username: str = Field(description="Jméno uživatele", examples=["Pepa Dlouhý"])
    password: str = Field(description="Heslo uživatele", examples=["d4w8as4d5wa4d68was5d4a6dwa9sd9"])

    model_config = ConfigDict(from_attributes=True)

class AuthorizationFailed(BaseModel):
    
    username: str = Field(description="Jméno uživatele", examples=["Pepa Dlouhý"])
    error: str = Field(description="Chybová hláška", examples=["Špatné jméno nebo heslo"])
    
    model_config = ConfigDict(from_attributes=True)    

class User(BaseModel):
    id: int = Field(description="ID uživatele", examples=[1,8])
    username: str = Field(description="Jméno uživatele", examples=["Pepa Dlouhý"])
    created: datetime = Field(description="Datum vytvoření uživatele", examples=["2021-01-01 12:00:00"])
    last_login: datetime = Field(description="Datum posledního přihlášení uživatele", examples=["2021-01-01 12:00:00"])
    
    model_config = ConfigDict(from_attributes=True)
  

class UserUpdate(BaseModel):
    username: str | None = Field(description="Jméno uživatele", examples=["Pepa Dlouhý"])
    password: str | None = Field(description="Heslo uživatele", examples=["d4w8as4d5wa4d68was5d4a6dwa9sd9"])
        
    model_config = ConfigDict(from_attributes=True)
