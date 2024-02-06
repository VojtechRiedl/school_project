import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  final int currentPage;

  const NavigationState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

class NavigationInitialState extends NavigationState {
  const NavigationInitialState(int currentPage) : super(currentPage);
}

class NavigationChangedState extends NavigationState {
  const NavigationChangedState(int currentPage) : super(currentPage);
}