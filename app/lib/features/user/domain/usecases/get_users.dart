import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:band_app/features/user/domain/repository/user_repository.dart';

class GetUsersUseCase extends UseCase<DataState<List<UserModel>>, void> {
  final UserRepository _userRepository;

  GetUsersUseCase(this._userRepository);

  @override
  Future<DataState<List<UserModel>>> call({void params}) {
    return _userRepository.getUsers() as Future<DataState<List<UserModel>>>;
  }


}