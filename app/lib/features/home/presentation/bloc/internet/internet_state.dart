import 'package:equatable/equatable.dart';

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetConnectionInitial extends InternetState {

  const InternetConnectionInitial();

  @override
  List<Object> get props => [];
}

class InternetConnectionSuccess extends InternetState {

  const InternetConnectionSuccess();

  @override
  List<Object> get props => [];
}

class InternetConnectionFailure extends InternetState {

  const InternetConnectionFailure();

  @override
  List<Object> get props => [];
}