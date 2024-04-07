import 'package:band_app/features/plans/presentation/bloc/validation/validation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValidationCubit extends Cubit<ValidationState>{

  ValidationCubit() : super(ValidationInitial());

  void createValidate(String title, String description, DateTime deadline){
    if(title.isEmpty || deadline.isBefore(DateTime.now().copyWith(minute: 0, hour: 0, second: 0, microsecond: 0, millisecond: 0))){
      emit(const ValidationFailure("Některé pole nebylo vyplněno správně!"));
    } else {
      emit(ValidationSuccess(title, description, deadline));
    }
  }

  void updateValidate(String title, String description, DateTime deadline){
    if(title.isEmpty || deadline.isBefore(DateTime.now().copyWith(minute: 0, hour: 0, second: 0, microsecond: 0, millisecond: 0))){
      emit(const ValidationFailure("Některé pole nebylo vyplněno správně!"));
    } else {
      emit(ValidationSuccess(title, description, deadline));
    }
  }


}

