from fastapi import APIRouter, Depends, HTTPException, Path
from sqlalchemy.orm import Session

from ..database import get_db
from ..schemas.idea import IdeaCreate, Idea, IdeaUpdate, IdeaSuccessResponse
from .. import crud

router = APIRouter(prefix="/ideas", tags=["Ideas"])

@router.get("/", response_model=list[Idea], summary="Get all ideas")
def read_ideas(db: Session = Depends(get_db)):
    print(crud.get_ideas(db))
    
    return crud.get_ideas(db)

@router.get("/{id}", response_model=Idea, summary="Get an idea by id")
def read_idea(id: int = Path(..., title="ID idei"), db: Session = Depends(get_db)):
    idea = crud.get_idea(db, id)
    
    if idea is None:
        raise HTTPException(status_code=404, detail="Idea not found")

    return crud.get_idea(db, id)

@router.post("/create", response_model=IdeaCreate, summary="Create an idea")
def create_idea(idea: IdeaCreate, db: Session = Depends(get_db)):
    if idea is None:
        raise HTTPException(status_code=404, detail="Idea not found")
    
    return crud.create_idea(db, idea)

@router.patch("/update/{id}",response_model=IdeaSuccessResponse, summary="Update an idea by id")
def update_idea(idea: IdeaUpdate, id: int = Path(..., title="ID idei"), db: Session = Depends(get_db)):
    response = crud.update_idea(db, id, idea)
    
    if response.rows_affacted == 0:
        raise HTTPException(status_code=404, detail="Idea not found")
    
    return response

@router.delete("/delete/{id}",response_model=IdeaSuccessResponse ,summary="Delete an idea by id")
def delete_idea(id: int = Path(..., title="ID idei"), db: Session = Depends(get_db)):
    response = crud.delete_idea(db, id)
    
    if response.rows_affacted == 0:
        raise HTTPException(status_code=404, detail="Idea not found")
    
    return response