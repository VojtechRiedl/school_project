from fastapi import APIRouter, Depends, HTTPException, Path
from sqlalchemy.orm import Session

from ..database import get_db
from ..schemas.songs import Song, SongCreate, SongSuccessResponse, SongUpdate

from .. import crud

router = APIRouter(prefix="/songs", tags=["Songs"])

@router.get("/", response_model=list[Song], summary="Get all songs")
def read_songs(db: Session = Depends(get_db)):
    return crud.get_songs(db)

@router.get("/{id}", response_model=Song, summary="Get an song by id")
def read_song(id: int = Path(..., title="ID songu"), db: Session = Depends(get_db)):
    song = crud.get_song(db, id)
    if Song is None:
        raise HTTPException(status_code=404, detail="Song not found")
    
    return song

@router.post("/create", response_model=SongCreate, summary="Create an song")
def create_song(song: SongCreate, db: Session = Depends(get_db)):
    if song is None:
        raise HTTPException(status_code=404, detail="Plan not found")
    
    return crud.create_plan(db, song)


@router.patch("/update/{id}", response_model=SongSuccessResponse, summary="Update an song by id")
def update_song(song: SongUpdate, id: int = Path(..., title="ID songu"), db: Session = Depends(get_db)):
    response = crud.update_song(db, id, song)
    
    if response.rows_affacted == 0:
        raise HTTPException(status_code=404, detail="Song not found")
    
    return response

@router.delete("/delete/{id}", response_model=SongSuccessResponse, summary="Delete an song by id")
def delete_song(id: int = Path(..., title="ID songu"), db: Session = Depends(get_db)):
    response = crud.delete_song(db, id)
    
    if response.rows_affacted == 0:
        raise HTTPException(status_code=404, detail="Song not found")
    
    return response