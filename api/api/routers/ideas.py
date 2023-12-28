from fastapi import APIRouter, Depends, HTTPException, Path
from sqlalchemy.orm import Session

from ..database import get_db
from ..schemas.schemas import Idea

router = APIRouter(prefix="/ideas", tags=["ideas"])

router.get("/", response_model=list[Idea], summary="Get all ideas")
