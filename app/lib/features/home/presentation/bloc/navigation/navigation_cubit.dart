import 'package:band_app/features/home/presentation/bloc/navigation/navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationInitialState(2));

  void changePage(int index) {
    emit(NavigationChangedState(index));
  }
}