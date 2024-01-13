import 'package:band_app/features/user/data/models/user.dart';
import 'package:band_app/features/user/domain/entities/user.dart';
import 'package:band_app/features/user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository{

  late UserEntity user;

  @override
  Future<UserModel> getUser() async{
    return Future.value(UserModel.fromEntity(user));
  }

  @override
  Future<void> saveUser(UserEntity user) async{
    this.user = user;
  }

}