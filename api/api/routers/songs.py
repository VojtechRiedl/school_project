from fastapi import APIRouter, Depends, HTTPException, Path
from sqlalchemy.orm import Session

from ..database import get_db
from ..schemas.schemas import Song

router = APIRouter(prefix="/songs", tags=["Songs"])

@router.get("/", response_model=list[Song], summary="Get all songs")
def read_songs(db: Session = Depends(get_db)):
    return None

@router.get("/{id}", response_model=Song, summary="Get an song by id")
def read_song(id: int = Path(..., title="ID songu"), db: Session = Depends(get_db)):
    return None

@router.post("/create", response_model=Song, summary="Create an song")
def create_song(idea: Song, db: Session = Depends(get_db)):
    return None


@router.patch("/update/{id}", response_model=Song, summary="Update an song by id")
def update_song(id: int = Path(..., title="ID songu"), db: Session = Depends(get_db)):
    return None

@router.delete("/delete/{id}", response_model=Song, summary="Delete an song by id")
def delete_song(id: int = Path(..., title="ID songu"), db: Session = Depends(get_db)):
    return None