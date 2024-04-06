import 'package:band_app/features/home/presentation/bloc/navigation/navigation_cubit.dart';
import 'package:band_app/features/login/data/repository/authorization_repository_impl.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_bloc.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_event.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_state.dart';
import 'package:band_app/features/user/presentation/bloc/users_bloc.dart';
import 'package:band_app/features/user/presentation/bloc/users_event.dart';
import 'package:band_app/features/user/presentation/bloc/users_state.dart';
import 'package:band_app/features/user/presentation/widgets/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  @override
  void initState() {
    context.read<UsersBloc>().add(UsersLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) {
        if(state is AuthorizationLogoutSuccess){
          GoRouter.of(context).go("/");
          context.read<NavigationCubit>().changePage(2);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Card(
                  child: ListTile(
                    title: const Text('Profil', textAlign: TextAlign.center),
                    onTap: () {
                      GoRouter.of(context).pushNamed("user", pathParameters: {'id': context.read<AuthorizationBloc>().state.user!.id.toString()});
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: ListTile(
                    title: const Text('Uživatelé', textAlign: TextAlign.center),
                    onTap: () {
                      GoRouter.of(context).pushNamed("users");
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                    onPressed: (){
                      context.read<AuthorizationBloc>().add(AuthorizationLoggedOut());

                    },
                    child: const Text('Odhlásit se')
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}