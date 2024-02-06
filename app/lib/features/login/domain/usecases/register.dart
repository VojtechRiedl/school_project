import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/login/data/models/Authorization.dart';
import 'package:band_app/features/login/domain/repository/authorization_repository.dart';
import 'package:band_app/features/user/data/models/user.dart';

class RegisterUseCase extends UseCase<DataState<UserModel>, AuthorizationModel>{
  final AuthorizationRepository repository;

  RegisterUseCase(this.repository);


  @override
  Future<DataState<UserModel>> call({AuthorizationModel ? params}) {
    return repository.register(params!) as Future<DataState<UserModel>>;
  }


}