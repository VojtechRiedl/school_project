import 'package:band_app/features/login/presentation/bloc/login/login_event.dart';
import 'package:band_app/features/login/presentation/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{


  LoginBloc() : super(const LoginInitial());


}