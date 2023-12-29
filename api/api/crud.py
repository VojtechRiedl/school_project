from sqlalchemy.orm import Session
from sqlalchemy import func
from sqlalchemy.sql import text
from . import models
from .database import engine
from .models import Ideas
from .schemas.idea import IdeaCreate, Idea, IdeaUpdate, IdeaSuccessResponse


def get_ideas(db: Session): 
    ideas = db.query(models.Ideas).all()    
    if ideas:
        response_ideas = []
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
    return None

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