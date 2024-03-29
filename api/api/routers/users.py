from fastapi import APIRouter, Depends, HTTPException, Path
from sqlalchemy.orm import Session

from ..database import get_db
from ..schemas.users import User, UserUpdate

from .. import crud

router = APIRouter(prefix="/users", tags=["Users"])

@router.get("/", response_model=list[User], summary="Get an users")
def read_users(db: Session = Depends(get_db)):
    return crud.get_users(db)

@router.get("/{user_id}", response_model=User, summary="Get an user")
def read_user(db: Session = Depends(get_db), user_id: int = Path(..., title="ID of the user")):
    
    response = crud.get_user(db, user_id)
    if response is None:
        raise HTTPException(status_code=404, detail="User not found")
    
    return response

@router.patch("/update/{user_id}", response_model=User, summary="Update an user")
def update_user(user_update: UserUpdate, db: Session = Depends(get_db), user_id: int = Path(..., title="ID of the user")):
    if user_update is None:
        raise HTTPException(status_code=400, detail="Bad request")
    
    user = crud.get_user(db, user_id)
    
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")
    
    response = crud.update_user(db, user_id, user_update)
    
    if response is None:
        raise HTTPException(status_code=404, detail="User not found")
    
    return response