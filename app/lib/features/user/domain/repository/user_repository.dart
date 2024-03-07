import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:band_app/features/user/data/models/user_update.dart';
import 'package:band_app/features/user/domain/entities/user.dart';

abstract class UserRepository{

  Future<DataState<List<UserEntity>>> getUsers();

  Future<DataState<UserEntity>> getUser(int id);

  Future<DataState<UserEntity>> updateUser(int id, UserUpdateModel userUpdate);



}