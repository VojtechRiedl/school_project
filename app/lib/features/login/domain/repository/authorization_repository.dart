import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/login/data/models/Authorization.dart';
import 'package:band_app/features/user/domain/entities/user.dart';

abstract class AuthorizationRepository {

  Future<DataState<UserEntity>> login(AuthorizationModel authorization);

  Future<DataState<UserEntity>> register(AuthorizationModel authorization);
}
