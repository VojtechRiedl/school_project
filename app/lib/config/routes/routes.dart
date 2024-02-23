import 'package:band_app/features/home/presentation/pages/connection_lost_view.dart';
import 'package:band_app/features/home/presentation/pages/home_view.dart';
import 'package:band_app/features/home/presentation/pages/main_view.dart';
import 'package:band_app/features/ideas/presentation/pages/ideas_view.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_bloc.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_state.dart';
import 'package:band_app/features/login/presentation/pages/login_view.dart';
import 'package:band_app/features/login/presentation/pages/register_view.dart';
import 'package:band_app/features/plans/presentation/pages/plans_view.dart';
import 'package:band_app/features/song/presentation/pages/create_song_view.dart';
import 'package:band_app/features/song/presentation/pages/song_test.dart';
import 'package:band_app/features/song/presentation/pages/song_view.dart';
import 'package:band_app/features/song/presentation/pages/songs_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
        name: 'home',
        path: '/',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const MainView(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
            },
          );
        },
      redirect: (context, state) {
          return context.read<AuthorizationBloc>().state is AuthorizationLogoutSuccess ? null : "/login";// : null;
          return "/login";
          //return context.read<LoginBloc>().state is LoginSuccess || context.read<RegisterBloc>().state is RegisterSuccess ? null : '/login';
        //return context.read<LoginBloc>().state is LoginSuccess || context.read<RegisterBloc>().state is RegisterSuccess ? "/login" : null; //TODO vratit zpět
      },
      routes:[
        GoRoute(
          name: 'create-song',
          path: 'create',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: const CreateSongView(),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity:
                  CurveTween(curve: Curves.easeInOut).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          name: 'song',
          path: 'song/:id',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: SongTest(id: int.parse(state.pathParameters['id']!)), //TODO switch to main view
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity:
                  CurveTween(curve: Curves.easeInOut).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
      ]
    ),
    GoRoute(
      name: 'plans',
      path: '/plans',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: const PlansView(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
        name: 'ideas',
        path: '/ideas',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const IdeasView(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
            },
          );
        }),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      name: 'connection-lost',
      path: '/connection-lost',
      builder: (context, state) => const ConnectionLostView(),
    ),
  ],
);
