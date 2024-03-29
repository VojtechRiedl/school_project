import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:band_app/features/user/domain/repository/user_repository.dart';

class GetUserUseCase extends UseCase<DataState<UserModel>, int>{
  final UserRepository _userRepository;

  GetUserUseCase(this._userRepository);


  @override
  Future<DataState<UserModel>> call({int ? params}) {
    return _userRepository.getUser(params!) as Future<DataState<UserModel>>;
  }



}