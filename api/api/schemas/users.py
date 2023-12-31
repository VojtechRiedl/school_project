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
    white_mode: bool = Field(description="Bílý mód", examples=[True])
    
    model_config = ConfigDict(from_attributes=True)
  

class UserUpdate(BaseModel):
    username: str = Field(description="Jméno uživatele", examples=["Pepa Dlouhý"])
    white_mode: bool = Field(description="Bílý mód", examples=[True])
    
    model_config = ConfigDict(from_attributes=True)

class UserSuccessResponse(BaseModel):
    
    user_id: int = Field(description="ID uživatele", examples=[1,8])
    message: str = Field(description="Zpráva", examples=["Uživatel byl úspěšně aktualizován"])
    rows_affacted: int = Field(description="Počet ovlivněných řádků", examples=[1])
    
    model_config = ConfigDict(from_attributes=True)
    
class UserInfo(BaseModel):
    username: str = Field(description="Jméno uživatele", examples=["Pepa Dlouhý"])
    created: datetime = Field(description="Datum vytvoření uživatele", examples=["2021-01-01 12:00:00"])
    last_login: datetime = Field(description="Datum posledního přihlášení uživatele", examples=["2021-01-01 12:00:00"])
    image_path: str = Field(description="Cesta k profilovému obrázku uživatele", examples=["/static/images/default.png"])

    model_config = ConfigDict(from_attributes=True)
