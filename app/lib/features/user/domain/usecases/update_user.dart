import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/params.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:band_app/features/user/domain/repository/user_repository.dart';

class UpdateUserUseCase extends UseCase<DataState<UserModel>, UpdateUserParams> {
  final UserRepository _userRepository;

  UpdateUserUseCase(this._userRepository);

  @override
  Future<DataState<UserModel>> call({UpdateUserParams ? params}) {
    return _userRepository.updateUser(params!.id, params.userUpdate) as Future<DataState<UserModel>>;
  }


}