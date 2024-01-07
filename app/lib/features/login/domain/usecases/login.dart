import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/login/data/models/Authorization.dart';
import 'package:band_app/features/login/domain/repository/authorization_repository.dart';
import 'package:band_app/features/user/domain/entities/user.dart';

class LoginUseCase extends UseCase<DataState<UserEntity>, AuthorizationModel>{
  final AuthorizationRepository repository;

  LoginUseCase(this.repository);


  @override
  Future<DataState<UserEntity>> call({AuthorizationModel ? params}) {
    return repository.login(params!);
  }

}