

import 'package:band_app/core/constatns/environment.dart';
import 'package:band_app/features/login/data/data_sources/remote/authorization_api_service.dart';
import 'package:band_app/features/login/data/repository/authorization_repository_impl.dart';
import 'package:band_app/features/login/domain/repository/authorization_repository.dart';
import 'package:band_app/features/login/domain/usecases/register.dart';
import 'package:band_app/features/login/presentation/bloc/login/login_bloc.dart';
import 'package:band_app/features/login/presentation/bloc/register/register_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async{

  await dotenv.load(
    fileName: ".env",
  );

  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<AuthorizationApiService>(
    AuthorizationApiService(
      sl(),
      baseUrl: Environment.apiUrl,
    ),
  );

  sl.registerSingleton<AuthorizationRepository>(
    AuthorizationRepositoryImpl(
      apiService: sl(),
    ),
  );

  //UseCases

  sl.registerSingleton<RegisterUseCase>(
    RegisterUseCase(
      sl(),
    ),
  );

  //Blocs

  sl.registerFactory<RegisterBloc>(() => RegisterBloc(sl()));

  sl.registerFactory<LoginBloc>(
    () => LoginBloc(
    ),
  );

}