import 'package:band_app/core/constants/environment.dart';
import 'package:band_app/features/login/data/data_sources/remote/authorization_api_service.dart';
import 'package:band_app/features/login/data/repository/authorization_repository_impl.dart';
import 'package:band_app/features/login/domain/repository/authorization_repository.dart';
import 'package:band_app/features/login/domain/usecases/login.dart';
import 'package:band_app/features/login/domain/usecases/register.dart';
import 'package:band_app/features/login/presentation/bloc/login/login_bloc.dart';
import 'package:band_app/features/login/presentation/bloc/register/register_bloc.dart';
import 'package:band_app/features/song/data/data_sources/remote/song_api_service.dart';
import 'package:band_app/features/song/data/repository/song_repository_impl.dart';
import 'package:band_app/features/song/domain/repository/song_repository.dart';
import 'package:band_app/features/song/domain/usecases/create_song.dart';
import 'package:band_app/features/song/domain/usecases/delete_song.dart';
import 'package:band_app/features/song/domain/usecases/get_song.dart';
import 'package:band_app/features/song/domain/usecases/get_songs.dart';
import 'package:band_app/features/song/domain/usecases/upload_sound.dart';
import 'package:band_app/features/song/domain/usecases/upload_video.dart';
import 'package:band_app/features/song/presentation/bloc/song/song_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/song_create/song_create_bloc.dart';
import 'package:band_app/features/user/data/repository/user_repository_impl.dart';
import 'package:band_app/features/user/domain/repository/user_repository.dart';
import 'package:band_app/features/user/domain/usecases/get_user.dart';
import 'package:band_app/features/user/domain/usecases/save_user.dart';
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

  sl.registerSingleton<SongApiService>(
    SongApiService(
      sl(),
      baseUrl: Environment.apiUrl,
    ),
  );

  sl.registerSingleton<AuthorizationRepository>(
    AuthorizationRepositoryImpl(
      apiService: sl(),
    ),
  );

  sl.registerSingleton<SongRepository>(
    SongRepositoryImpl(
      sl(),
    ),
  );

  sl.registerSingleton<UserRepository>(
    UserRepositoryImpl(),
  );


  //UseCases

  sl.registerSingleton<RegisterUseCase>(
    RegisterUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<LoginUseCase>(
    LoginUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<SaveUserUseCase>(
    SaveUserUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<GetUserUseCase>(
    GetUserUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<GetSongsUseCase>(
    GetSongsUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<CreateSongUseCase>(
    CreateSongUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<UploadVideoUseCase>(
    UploadVideoUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<UploadSoundUseCase>(
    UploadSoundUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<GetSongUseCase>(
    GetSongUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<DeleteSongUseCase>(
    DeleteSongUseCase(
      sl(),
    ),
  );

  //Blocs
  sl.registerFactory<RegisterBloc>(
    () => RegisterBloc(
        sl(), sl()
    ),
  );

  sl.registerFactory<LoginBloc>(
    () => LoginBloc(
      sl(), sl()
    ),
  );

  sl.registerFactory<SongsBloc>(
    () => SongsBloc(
      sl()
    ),
  );

  sl.registerFactory<SongCreateBloc>(
    () => SongCreateBloc(
      sl(), sl(), sl(), sl()
    )
  );

  sl.registerFactory<SongBloc>(
    () => SongBloc(
        sl(),sl()
    )
  );
}