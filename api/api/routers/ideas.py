from fastapi import APIRouter, Depends, HTTPException, Path
from sqlalchemy.orm import Session

from ..database import get_db
from ..schemas.ideas import IdeaCreate, Idea, IdeaUpdate, VoteCreate
from .. import crud

router = APIRouter(prefix="/ideas", tags=["Ideas"])

@router.get("/", response_model=list[Idea], summary="Get all ideas")
def read_ideas(db: Session = Depends(get_db)):    
    return crud.read_ideas(db)

@router.get("/{id}", response_model=Idea, summary="Get an idea by id")
def read_idea(id: int = Path(..., title="ID idei"), db: Session = Depends(get_db)):
    idea = crud.read_idea(db, id)
    
    if idea is None:
        raise HTTPException(status_code=404, detail="Idea not found")

    return idea

@router.post("/create", response_model=Idea, summary="Create an idea")
def create_idea(idea: IdeaCreate, db: Session = Depends(get_db)):
    if idea is None:
        raise HTTPException(status_code=400, detail="Idea not found")
    
    user = crud.get_user(db, idea.user_id)
    
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")
    
    return crud.create_idea(db, idea)

@router.put("/vote", response_model=Idea, summary="Vote an idea by id")
def create_vote(vote_create: VoteCreate, db: Session = Depends(get_db)):        
    response = crud.put_vote(db, vote_create)
    
    if response is None:
        raise HTTPException(status_code=404, detail="Idea not found")
    
    return response

@router.delete("/delete/{id}",response_model=Idea ,summary="Delete an idea by id")
def delete_idea(id: int = Path(..., title="ID idei"), db: Session = Depends(get_db)):
    response = crud.delete_idea(db, id)
    
    if response is None: 
        raise HTTPException(status_code=404, detail="Idea not found")
    
    return response
