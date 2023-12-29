from fastapi import APIRouter, Depends, HTTPException, Path
from sqlalchemy.orm import Session

from ..database import get_db
from ..schemas.schemas import Authorization, User

router = APIRouter(prefix="/authorization", tags=["Authorization"])


@router.post("/register", response_model=User, summary="Register an user")
def register(authorization: Authorization, db: Session = Depends(get_db)):
    return None


@router.post("/login", response_model=User, summary="Login an user")
def login(authorization: Authorization, db: Session = Depends(get_db)):
    return None
