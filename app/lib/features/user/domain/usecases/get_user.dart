import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:band_app/features/user/domain/repository/user_repository.dart';

class GetUserUseCase extends UseCase<UserModel, void>{
  final UserRepository _userRepository;

  GetUserUseCase(this._userRepository);


  @override
  Future<UserModel> call({void  params}) {
    return _userRepository.getUser();
  }



}