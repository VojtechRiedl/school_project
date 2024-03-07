import 'package:audioplayers/audioplayers.dart';
import 'package:band_app/core/constants/environment.dart';
import 'package:band_app/features/home/presentation/bloc/internet/internet_cubit.dart';
import 'package:band_app/features/home/presentation/bloc/navigation/navigation_cubit.dart';
import 'package:band_app/features/ideas/data/data_sources/remote/idea_api_service.dart';
import 'package:band_app/features/ideas/data/repository/idea_repository_impl.dart';
import 'package:band_app/features/ideas/domain/repository/idea_repository.dart';
import 'package:band_app/features/ideas/domain/usecases/create_idea.dart';
import 'package:band_app/features/ideas/domain/usecases/create_vote.dart';
import 'package:band_app/features/ideas/domain/usecases/delete_idea.dart';
import 'package:band_app/features/ideas/domain/usecases/get_ideas.dart';
import 'package:band_app/features/ideas/presentation/bloc/idea_validation/idea_validation_cubit.dart';
import 'package:band_app/features/ideas/presentation/bloc/ideas/ideas_bloc.dart';
import 'package:band_app/features/login/data/data_sources/remote/authorization_api_service.dart';
import 'package:band_app/features/login/data/repository/authorization_repository_impl.dart';
import 'package:band_app/features/login/domain/repository/authorization_repository.dart';
import 'package:band_app/features/login/domain/usecases/login.dart';
import 'package:band_app/features/login/domain/usecases/register.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_bloc.dart';
import 'package:band_app/features/song/data/data_sources/remote/song_api_service.dart';
import 'package:band_app/features/song/data/repository/song_repository_impl.dart';
import 'package:band_app/features/song/domain/repository/song_repository.dart';
import 'package:band_app/features/song/domain/usecases/create_song.dart';
import 'package:band_app/features/song/domain/usecases/delete_song.dart';
import 'package:band_app/features/song/domain/usecases/get_song.dart';
import 'package:band_app/features/song/domain/usecases/get_songs.dart';
import 'package:band_app/features/song/domain/usecases/update_song.dart';
import 'package:band_app/features/song/domain/usecases/upload_sound.dart';
import 'package:band_app/features/song/domain/usecases/upload_video.dart';
import 'package:band_app/features/song/presentation/bloc/music/music_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/song/song_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/song_update/song_update_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/song_create/song_create_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/video/video_cubit.dart';
import 'package:band_app/features/user/data/data_sources/remote/user_api_service.dart';
import 'package:band_app/features/user/data/repository/user_repository_impl.dart';
import 'package:band_app/features/user/domain/repository/user_repository.dart';
import 'package:band_app/features/user/domain/usecases/get_user.dart';
import 'package:band_app/features/user/domain/usecases/get_users.dart';
import 'package:band_app/features/user/domain/usecases/update_user.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async{

  await dotenv.load(
    fileName: ".env",
  );

  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<Connectivity>(Connectivity());

  sl.registerFactory<AudioPlayer>(
    () => AudioPlayer(),
  );

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

  sl.registerSingleton<IdeaApiService>(
    IdeaApiService(
      sl(),
      baseUrl: Environment.apiUrl,
    ),
  );

  sl.registerSingleton<UserApiService>(
    UserApiService(
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
    UserRepositoryImpl(
      sl(),
    )
  );

  sl.registerSingleton<IdeaRepository>(
    IdeaRepositoryImpl(
      sl(),
    ),
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

  sl.registerSingleton<GetUsersUseCase>(
    GetUsersUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<GetUserUseCase>(
    GetUserUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<UpdateUserUseCase>(
    UpdateUserUseCase(
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

  sl.registerSingleton<UpdateSongUseCase>(
    UpdateSongUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<GetIdeasUseCase>(
    GetIdeasUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<CreateVoteUseCase>(
    CreateVoteUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<CreateIdeaUseCase>(
    CreateIdeaUseCase(
      sl(),
    ),
  );

  sl.registerSingleton<DeleteIdeaUseCase>(
    DeleteIdeaUseCase(
      sl(),
    ),
  );

  //Blocs

  sl.registerFactory<NavigationCubit>(
    () => NavigationCubit(),
  );

  sl.registerFactory<InternetCubit>(
    () => InternetCubit(
      sl(),
    ),
  );

  sl.registerFactory<AuthorizationBloc>(
    () => AuthorizationBloc(
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
      sl(), sl(), sl()
    )
  );

  sl.registerFactory<SongBloc>(
    () => SongBloc(
        sl(),sl()
    )
  );

  sl.registerFactory<MusicBloc>(
    () => MusicBloc(
      sl()
    ),
  );

  sl.registerFactory<VideoCubit>(
    () => VideoCubit(),
  );

  sl.registerFactory<SongUpdateBloc>(
    () => SongUpdateBloc(
      sl(), sl(), sl(), sl()
    ),
  );

  sl.registerFactory<IdeasBloc>(
    () => IdeasBloc(
      sl(), sl(),sl(),sl()
    ),
  );

  sl.registerFactory<IdeaValidationCubit>(
    () => IdeaValidationCubit(),
  );
}