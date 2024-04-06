import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/song/data/models/song.dart';
import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:band_app/features/song/domain/repository/song_repository.dart';

class GetSongUseCase extends UseCase<DataState<SongModel>, int>{
  final SongRepository _songRepository;

  GetSongUseCase(this._songRepository);

  @override
  Future<DataState<SongModel>> call({int ? params}) {
    return _songRepository.getSong(params!) as Future<DataState<SongModel>>;
  }

}