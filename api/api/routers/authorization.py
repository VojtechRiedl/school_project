from fastapi import APIRouter, Depends, HTTPException, Path
from sqlalchemy.orm import Session

from ..database import get_db
from ..schemas.users import User, Authorization, AuthorizationFailed

from .. import crud

router = APIRouter(prefix="/authorization", tags=["Authorization"])


@router.post("/register", response_model=User, summary="Register an user")
def register(authorization: Authorization, db: Session = Depends(get_db)):
    if authorization is None:
        raise HTTPException(status_code=400, detail="Bad request")
    
    response = crud.register(db, authorization)
    if type(response) is AuthorizationFailed:
        raise HTTPException(status_code=404, detail=response.model_dump())
    
    return response


@router.post("/login", response_model=User, summary="Login an user")
def login(authorization: Authorization, db: Session = Depends(get_db)):
    if authorization is None:
        raise HTTPException(status_code=400, detail="Bad request")
    
    response = crud.login(db, authorization)
    if type(response) is AuthorizationFailed:
        raise HTTPException(status_code=404, detail=response.model_dump())
    
    return response
