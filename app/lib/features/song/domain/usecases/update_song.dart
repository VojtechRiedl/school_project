import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/params.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/song/data/models/song.dart';
import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:band_app/features/song/domain/repository/song_repository.dart';

class UpdateSongUseCase extends UseCase<DataState<SongModel>, UpdateSongParams>{
  final SongRepository _songRepository;

  UpdateSongUseCase(this._songRepository);

  @override
  Future<DataState<SongModel>> call({UpdateSongParams ? params}) {
    return _songRepository.updateSong(params!.id, params.song) as Future<DataState<SongModel>>;
  }

}