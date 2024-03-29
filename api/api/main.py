import uvicorn
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from .schemas.settings import AppSettings
from .routers import ideas, plans, songs, authorization, users
from .database import engine
from . import models


if __name__ == '__main__':
    uvicorn.run("api.main:app",
                host="0.0.0.0",
                port=8000,
                reload=True,
                )
#ssl_keyfile="C:/Users/vojta/Desktop/band_project/api/ssl103+3-key.pem", 
#ssl_certfile="C:/Users/vojta/Desktop/band_project/api/ssl103+3.pem"
app_settings = AppSettings()

#models.Base.metadata.drop_all(bind=engine)
models.Base.metadata.create_all(bind=engine)

app = FastAPI(
    debug=True,
    title="Band API",
    root_path=app_settings.root_path,
    redoc_url=None,
    docs_url="/docs",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["GET", "POST", "PATCH", "DELETE"],
    allow_headers=["*"],
)


app.include_router(authorization.router)
app.include_router(users.router)
app.include_router(ideas.router)
app.include_router(plans.router)
app.include_router(songs.router)