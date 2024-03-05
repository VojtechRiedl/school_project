import 'package:equatable/equatable.dart';

abstract class IdeasEvent extends Equatable {
  const IdeasEvent();

  @override
  List<Object> get props => [];
}

class IdeasLoaded extends IdeasEvent {

  const IdeasLoaded();

  @override
  List<Object> get props => [];

}