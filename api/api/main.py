from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware


from .schemas.settings import AppSettings

app_settings = AppSettings()


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
    allow_methods=["GET", "POST"],
    allow_headers=["*"],
)

