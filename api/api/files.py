import shutil
from fastapi import UploadFile
from pathlib import Path



def save_sound_file(file_name: str, file: UploadFile):    
    if file is None:
        return None
    path = 'static/sounds/' + file_name + Path(file.filename).suffix
    print(file.filename)
    with open(path, 'wb') as buffer:
        shutil.copyfileobj(file.file, buffer)
    return path

def save_video_file(file_name: str, file: UploadFile):
    if file is None:
        return None
    path = 'static/videos/' + file_name + Path(file.filename).suffix
    print(file.filename)
    with open(path, 'wb') as buffer:
        shutil.copyfileobj(file.file, buffer)
    return path
    