from fastapi import APIRouter, Depends, HTTPException, Path, File, UploadFile, Form
from sqlalchemy.orm import Session
from pydantic import Json

from ..database import get_db
from ..schemas.songs import Song, SongCreate, SongSuccessResponse, SongUpdate
from fastapi.responses import StreamingResponse,FileResponse



from .. import crud

router = APIRouter(prefix="/songs", tags=["Songs"])

@router.get("/", response_model=list[Song], summary="Get all songs")
def read_songs(db: Session = Depends(get_db)):
    return crud.get_songs(db)

@router.get("/{id}", response_model=Song, summary="Get an song by id")
def read_song(id: int = Path(..., title="ID songu"), db: Session = Depends(get_db)):
    song = crud.get_song(db, id)
    if song is None:
        raise HTTPException(status_code=404, detail="Song not found")
    
    return song

@router.get("/video/{id}", summary="Get an video by song_id")
def get_video(id: int = Path(..., title="video"),db: Session = Depends(get_db)):
    response = crud.get_video(db, id)
    
    if response is None:
        raise HTTPException(status_code=404, detail="Song not found")
    
    return StreamingResponse(response, media_type="video/mp4")
    

@router.get("/sound/{id}", summary="Get an sound by song_id")
def get_sound(id: int = Path(..., title="Sound"), db: Session = Depends(get_db)):
    response = crud.get_sound(db, id)
    
    if response is None:
        raise HTTPException(status_code=404, detail="Song not found")
            
    return StreamingResponse(response, media_type="audio/mpeg")

@router.post("/create", response_model=Song, summary="Create an song")
def create_song(song: SongCreate, db: Session = Depends(get_db)):    
    if song is None:
        raise HTTPException(status_code=404, detail="Song not found")
    
    return crud.create_song(db, song)

@router.post("/video/upload/{id}", response_model=SongSuccessResponse, summary="Upload an video by id")
def upload_video(video_file: UploadFile, id: int = Path(..., title="ID songu"), db: Session = Depends(get_db)):
    response = crud.upload_video(db, id, video_file)
    
    if response is None:
        raise HTTPException(status_code=404, detail="Song not found")
    
    return response
    

@router.post("/sound/upload/{id}", response_model=SongSuccessResponse, summary="Upload an sound by id")
def upload_song(sound_file: UploadFile, id: int = Path(..., title="ID songu"), db: Session = Depends(get_db)):
    response = crud.upload_sound(db, id, sound_file)
    
    if response is None:
        raise HTTPException(status_code=404, detail="Song not found")
    
    return response

@router.patch("/update/{id}", response_model=Song, summary="Update an song by id")
def update_song(song: SongUpdate, id: int = Path(..., title="ID songu"), db: Session = Depends(get_db)):
    response = crud.update_song(db, id, song)
    
    if response is None:
        raise HTTPException(status_code=404, detail="Song not found")
    
    return response

@router.delete("/delete/{id}", response_model=Song, summary="Delete an song by id")
def delete_song(id: int = Path(..., title="ID songu"), db: Session = Depends(get_db)):
    response = crud.delete_song(db, id)
    
    if response is None:
        raise HTTPException(status_code=404, detail="Song not found")
    
    return response