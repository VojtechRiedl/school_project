import 'package:band_app/features/home/presentation/pages/home_view.dart';
import 'package:band_app/features/home/presentation/pages/main_view.dart';
import 'package:band_app/features/ideas/presentation/pages/ideas_view.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_bloc.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_state.dart';
import 'package:band_app/features/login/presentation/bloc/login/login_bloc.dart';
import 'package:band_app/features/login/presentation/bloc/login/login_state.dart';
import 'package:band_app/features/login/presentation/bloc/register/register_bloc.dart';
import 'package:band_app/features/login/presentation/bloc/register/register_state.dart';
import 'package:band_app/features/login/presentation/pages/login_view.dart';
import 'package:band_app/features/login/presentation/pages/register_view.dart';
import 'package:band_app/features/plans/presentation/pages/plans_view.dart';
import 'package:band_app/features/song/presentation/pages/create_song_view.dart';
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
          return context.read<AuthorizationBloc>().state is LogoutState ? "/login" : null;
          return "/login";
          //return context.read<LoginBloc>().state is LoginSuccess || context.read<RegisterBloc>().state is RegisterSuccess ? null : '/login';
        //return context.read<LoginBloc>().state is LoginSuccess || context.read<RegisterBloc>().state is RegisterSuccess ? "/login" : null; //TODO vratit zpět
      },
    ),

    GoRoute(
        name: 'songs',
        path: '/songs',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const SongsView(),
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
        routes: [
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
                child: SongView(id: int.parse(state.pathParameters['id']!)),
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
        ]),
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
  ],
);
