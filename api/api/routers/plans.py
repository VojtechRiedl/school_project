from fastapi import APIRouter, Depends, HTTPException, Path
from sqlalchemy.orm import Session

from ..database import get_db
from ..schemas.plans import Plan, PlanCreate, PlanSuccessResponse, PlanUpdate
from .. import crud

router = APIRouter(prefix="/plans", tags=["Plans"])

@router.get("/", response_model=list[Plan], summary="Get all plans")
def read_plans(db: Session = Depends(get_db)):
    return crud.get_plans(db)

@router.get("/{id}", response_model=Plan, summary="Get an plan by id")
def read_plan(id: int = Path(..., title="ID plánu"), db: Session = Depends(get_db)):
    plan = crud.get_plan(db, id)
    
    
    if plan is None:
        raise HTTPException(status_code=404, detail="Plan not found")
    return plan


@router.post("/create", response_model=Plan, summary="Create an plan")
def create_plan(plan_create: PlanCreate, db: Session = Depends(get_db)):
    if plan_create is None:
        raise HTTPException(status_code=400, detail="Bad request")
        
    return crud.create_plan(db, plan_create)


@router.patch("/update/{id}", response_model=Plan, summary="Update an plan by id")
def update_plan(plan: PlanUpdate, id: int = Path(..., title="ID plánu"), db: Session = Depends(get_db)):
    if plan is None:
        raise HTTPException(status_code=400, detail="Bad request")
    
    plan = crud.update_plan(db, id, plan)
    
    if plan is None:
        raise HTTPException(status_code=404, detail="Idea not found")
    
    return plan

@router.delete("/delete/{id}", response_model=Plan, summary="Delete an plan by id")
def delete_plan(id: int = Path(..., title="ID plánu"), db: Session = Depends(get_db)):
    plan = crud.delete_plan(db, id)
    
    if plan is None:
        raise HTTPException(status_code=404, detail="Plan not found")
    
    return plan