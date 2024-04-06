import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_app_bar.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_bloc.dart';
import 'package:band_app/features/login/presentation/widgets/input.dart';
import 'package:band_app/features/user/presentation/bloc/users_bloc.dart';
import 'package:band_app/features/user/presentation/bloc/users_event.dart';
import 'package:band_app/features/user/presentation/bloc/users_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class UserView extends StatefulWidget{
  final int id;


  const UserView({Key? key, required this.id}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;


  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    context.read<UsersBloc>().add(UserLoaded(widget.id));
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        title: Text('Profil'),
      ),
      body:_buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    return BlocConsumer<UsersBloc, UsersState>(
      builder: (BuildContext context, UsersState state) {
        if(state is UserLoadInProgress || state is UsersLoadInProgress || state is UsersLoadSuccess){
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onSurface),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(state.user!.username, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                  Divider(color: Theme.of(context).colorScheme.onSurface, thickness: 2, height: 40),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Uživatelem od", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(DateFormat("yyyy-MM-dd").format(state.user!.createdAt),style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Naposledy aktivní", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(DateFormat("yyyy-MM-dd").format(state.user!.lastLogin),style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Přidáno písniček", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("15",style: TextStyle(fontSize: 16)),
                    ],
                  ),

                ],
              ),
              state.user!.id == context.read<AuthorizationBloc>().state.user!.id ? ElevatedButton(
                onPressed: (){
                  showModalBottomSheet(
                    elevation: 1,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                    ),
                      context: context,
                      builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Upravit profil", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 20),
                              Input(label: "Jméno", isObscured: false, controller: _usernameController),
                              const SizedBox(height: 20),
                              Input(label: "Heslo", isObscured: false, controller: _passwordController),
                              const SizedBox(height: 20),
                              TextButton(
                                  onPressed: () {
                                    context.read<UsersBloc>().add(UserUpdated(state.user!.id, _usernameController.text, _passwordController.text));
                                    //Navigator.pop(context);
                                  },
                                  child: Text("Uložit", style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface,fontWeight : FontWeight.bold))
                              )
                            ],
                          ),
                        );
                      },
                  );
                },
                child: const Icon(Icons.edit,  size: 32,),
              ) : const SizedBox(),
            ],
          ),
        );
      }, listener: (BuildContext context, UsersState state) {
        if(state is UserUpdateSuccess){
          context.pop(context);
          _usernameController.clear();
          _passwordController.clear();
        }
      },
    );
  }
}