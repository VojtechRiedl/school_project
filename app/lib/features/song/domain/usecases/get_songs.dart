import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/song/data/models/song.dart';
import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:band_app/features/song/domain/repository/song_repository.dart';

class GetSongsUseCase extends UseCase<DataState<List<SongModel>>, void>{
  final SongRepository _songRepository;

  GetSongsUseCase(this._songRepository);


  @override
  Future<DataState<List<SongModel>>> call({void params}) {
    return _songRepository.getSongs() as Future<DataState<List<SongModel>>>;
  }

}