import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/login/data/models/Authorization.dart';
import 'package:band_app/features/login/domain/repository/authorization_repository.dart';
import 'package:band_app/features/user/domain/entities/user.dart';

class RegisterUseCase extends UseCase<DataState<UserEntity>, AuthorizationModel>{
  final AuthorizationRepository repository;

  RegisterUseCase(this.repository);


  @override
  Future<DataState<UserEntity>> call({AuthorizationModel ? params}) {
    return repository.register(params!);
  }


}