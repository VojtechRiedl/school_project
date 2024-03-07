class UserUpdateModel{
  final String ? username;
  final String ? password;

  UserUpdateModel({this.username, this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}