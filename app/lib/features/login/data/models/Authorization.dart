import 'package:band_app/features/login/domain/entities/Authorization.dart';

class AuthorizationModel extends AuthorizationEntity {

  const AuthorizationModel({
    required String username,
    required String hashedPassword,
  }) : super (
    username: username,
    hashedPassword: hashedPassword,
  );


  Map<String, dynamic> toJson() => {
    'username': username,
    'password': hashedPassword,
  };


}
