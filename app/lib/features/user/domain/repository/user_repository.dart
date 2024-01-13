import 'package:band_app/features/user/data/models/user.dart';
import 'package:band_app/features/user/domain/entities/user.dart';

abstract class UserRepository{

  Future<UserModel> getUser();

  Future<void> saveUser(UserEntity user);

}