import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_app_bar.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:band_app/features/user/presentation/bloc/users_bloc.dart';
import 'package:band_app/features/user/presentation/bloc/users_event.dart';
import 'package:band_app/features/user/presentation/bloc/users_state.dart';
import 'package:band_app/features/user/presentation/widgets/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {

  @override
  void initState() {
    context.read<UsersBloc>().add(UsersLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        title: Text('Uživatelé'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){

    return BlocConsumer<UsersBloc,UsersState>(
      builder: (BuildContext context, UsersState state) {
        if(state is UsersLoadInProgress){
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onSurface,),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return UserItem(user: state.users[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              }
          ),
        );
      },
      listener: (BuildContext context, UsersState state) {  },
    );
  }
}