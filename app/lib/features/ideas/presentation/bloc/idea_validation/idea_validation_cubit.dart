import 'package:band_app/features/ideas/presentation/bloc/idea_validation/idea_validation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdeaValidationCubit extends Cubit<IdeaValidationState>{

  IdeaValidationCubit() : super(IdeaValidationInitial());


  void validate(String title, String description, DateTime deadline){
    if(title.isEmpty || description.isEmpty || deadline.isBefore(DateTime.now())){
      emit(const IdeaValidationFailure("Některé pole nebylo vyplněno správně!"));
    } else {
      emit(IdeaValidationSuccess(title, description, deadline));
    }
  }

}