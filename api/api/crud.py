from sqlalchemy.orm import Session
from sqlalchemy import func
from sqlalchemy.sql import text
from . import models
from .database import engine
from .models import Ideas
from .schemas.ideas import IdeaCreate, Idea, IdeaUpdate, IdeaSuccessResponse
from .schemas.plans import Plan, PlanCreate, PlanUpdate, PlanSuccessResponse


def get_ideas(db: Session): 
    ideas = db.query(models.Ideas).all()   
    response_ideas = [] 
    if ideas:
        for idea in ideas:
            accepted = db.query(models.Votes).filter(models.Votes.idea_id == idea.idea_id, models.Votes.accepted == True).count()
            declined = db.query(models.Votes).filter(models.Votes.idea_id == idea.idea_id, models.Votes.accepted == False).count()
        response_ideas.append(Idea(
            idea_id=idea.idea_id,
            name=idea.name,
            active=idea.active,
            description=idea.description,
            created=idea.created,
            userInfo=idea.users,
            accepted=accepted,
            declined=declined
        ))
        return response_ideas
    return response_ideas

def get_idea(db: Session, idea_id: int):
    idea = db.query(models.Ideas).filter(models.Ideas.idea_id == idea_id).first()
    if idea:
        accepted = db.query(models.Votes).filter(models.Votes.idea_id == idea.idea_id, models.Votes.accepted == True).count()
        declined = db.query(models.Votes).filter(models.Votes.idea_id == idea.idea_id, models.Votes.accepted == False).count()
        return Idea(
            idea_id=idea.idea_id,
            name=idea.name,
            active=idea.active,
            description=idea.description,
            created=idea.created,
            userInfo=idea.users,
            accepted=accepted,
            declined=declined
        )
    return None  
  
def create_idea(db: Session, idea_create: IdeaCreate):
    db_idea = models.Ideas(
        name=idea_create.name,
        active=idea_create.active,
        description=idea_create.description,
        created=idea_create.created,
        user_id=idea_create.user_id
    )
    db.add(db_idea)
    db.commit()
    db.refresh(db_idea)
    return idea_create

def update_idea(db: Session, idea_id: int, idea: IdeaUpdate):
    print(idea.model_dump())
    updated_idea = db.query(models.Ideas).filter(models.Ideas.idea_id == idea_id).update({models.Ideas.name: idea.name, models.Ideas.active: idea.active, models.Ideas.description: idea.description})
    db.commit()
    return IdeaSuccessResponse(
        idea_id=idea_id,
        rows_affacted=updated_idea,
        message="Nápad byl úspěšně aktualizován",
    ) 

def delete_idea(db: Session, idea_id: int):
    deleted_idea = db.query(models.Ideas).filter(models.Ideas.idea_id == idea_id).delete()
    db.commit()
    return IdeaSuccessResponse(
        idea_id=idea_id,
        rows_affacted=deleted_idea,
        message="Nápad byl úspěšně smazán",
    )
    

def get_plans(db: Session):
    plans = db.query(models.Plans).all()
    response_plans = []
    if plans:
        for plan in plans:
            response_plans.append(Plan(
                plan_id=plan.plan_id,
                name=plan.name,
                date=plan.date,
                description=plan.description,
                userInfo=plan.users
            ))
        return response_plans
    return response_plans

def get_plan(db: Session, plan_id: int):
    plan = db.query(models.Plans).filter(models.Plans.plan_id == plan_id).first()
    if plan:
        return Plan(
            plan_id=plan.plan_id,
            name=plan.name,
            date=plan.date,
            description=plan.description,
            userInfo=plan.users
        )
    return None 

def create_plan(db: Session, idea_create: PlanCreate):
    db_plan = models.Plans(
        name=idea_create.name,
        date=idea_create.plan_date,
        description=idea_create.description,
        user_id=idea_create.user_id
    )
    db.add(db_plan)
    db.commit()
    db.refresh(db_plan)
    return idea_create

def update_plan(db: Session, plan_id: int, plan: PlanUpdate):
    updated_plan = db.query(models.Plans).filter(models.Plans.plan_id == plan_id).update({models.Plans.name: plan.name, models.Plans.date: plan.plan_date, models.Plans.description: plan.description})
    db.commit()
    return PlanSuccessResponse(
        plan_id=plan_id,
        rows_affacted=updated_plan,
        message="Nápad byl úspěšně aktualizován",
    ) 

def delete_plan(db: Session, plan_id: int):
    deleted_idea = db.query(models.Plans).filter(models.Plans.plan_id == plan_id).delete()
    db.commit()
    return PlanSuccessResponse(
        plan_id=plan_id,
        rows_affacted=deleted_idea,
        message="Nápad byl úspěšně smazán",
    )