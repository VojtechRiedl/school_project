import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/song/data/models/song.dart';
import 'package:band_app/features/song/data/models/song_create.dart';
import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:band_app/features/song/domain/repository/song_repository.dart';

class CreateSongUseCase extends UseCase<DataState<SongModel>, SongCreateModel>{
  final SongRepository _songRepository;

  CreateSongUseCase(this._songRepository);

  @override
  Future<DataState<SongModel>> call({SongCreateModel ? params}) {
    return _songRepository.createSong(params!) as Future<DataState<SongModel>>;
  }

}