from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware

from .schemas.settings import AppSettings
from .routers import ideas, plans, songs, authorization
from .database import engine
from . import models

app_settings = AppSettings()

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
app.include_router(ideas.router)
app.include_router(plans.router)
app.include_router(songs.router)