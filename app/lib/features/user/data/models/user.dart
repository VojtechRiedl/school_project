import 'package:band_app/features/user/domain/entities/user.dart';
import 'package:intl/intl.dart';

class UserModel extends UserEntity{

    const UserModel({
      required int id,
      required String username,
      required DateTime createdAt,
      required DateTime lastLogin,
      required bool whiteMode,
    }) : super (
      id: id,
      username: username,
      createdAt: createdAt,
      lastLogin: lastLogin,
      whiteMode: whiteMode,
    );

    factory UserModel.fromJson(Map<String,dynamic> map){
      return UserModel(
        id: map['id'],
        username: map['username'],
        createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss").parse(map['created']),
        lastLogin: DateFormat("yyyy-MM-ddTHH:mm:ss").parse(map['last_login']),
        whiteMode: map['white_mode'],
      );
    }

    factory UserModel.fromEntity(UserEntity entity){
      return UserModel(
        id: entity.id,
        username: entity.username,
        createdAt: entity.createdAt,
        lastLogin: entity.lastLogin,
        whiteMode: entity.whiteMode,
      );
    }
}