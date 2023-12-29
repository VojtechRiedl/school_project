from fastapi import APIRouter, Depends, HTTPException, Path
from sqlalchemy.orm import Session

from ..database import get_db
from ..schemas.schemas import Plan

router = APIRouter(prefix="/plans", tags=["Plans"])

@router.get("/", response_model=list[Plan], summary="Get all plans")
def read_plans(db: Session = Depends(get_db)):
    return None

@router.get("/{id}", response_model=Plan, summary="Get an plan by id")
def read_plan(id: int = Path(..., title="ID plánu"), db: Session = Depends(get_db)):
    return None

@router.post("/create", response_model=Plan, summary="Create an plan")
def create_plan(idea: Plan, db: Session = Depends(get_db)):
    return None


@router.patch("/update/{id}", response_model=Plan, summary="Update an plan by id")
def update_plan(id: int = Path(..., title="ID plánu"), db: Session = Depends(get_db)):
    return None

@router.delete("/delete/{id}", response_model=Plan, summary="Delete an plan by id")
def delete_plan(id: int = Path(..., title="ID plánu"), db: Session = Depends(get_db)):
    return None