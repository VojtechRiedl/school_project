import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserItem extends StatelessWidget{
  final UserModel user;
  const UserItem({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(user.username, textAlign: TextAlign.center,style: const TextStyle( fontSize: 16), ),
        onTap: () {
          GoRouter.of(context).pushNamed("user", pathParameters: {'id': user.id.toString()});
        }
      ),
    );
  }
}