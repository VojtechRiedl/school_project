import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/user/domain/entities/user.dart';
import 'package:band_app/features/user/domain/repository/user_repository.dart';

class SaveUserUseCase extends UseCase<void, UserEntity> {
  final UserRepository repository;

  SaveUserUseCase(this.repository);

  @override
  Future<void> call({UserEntity ? params}) {
    return repository.saveUser(params!);
  }


}