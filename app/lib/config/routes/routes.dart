import 'package:band_app/features/home/presentation/pages/connection_lost_view.dart';
import 'package:band_app/features/home/presentation/pages/home_view.dart';
import 'package:band_app/features/home/presentation/pages/main_view.dart';
import 'package:band_app/features/ideas/presentation/pages/create_idea_view.dart';
import 'package:band_app/features/ideas/presentation/pages/ideas_view.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_bloc.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_state.dart';
import 'package:band_app/features/login/presentation/pages/login_view.dart';
import 'package:band_app/features/login/presentation/pages/register_view.dart';
import 'package:band_app/features/plans/presentation/pages/plan_create_view.dart';
import 'package:band_app/features/plans/presentation/pages/plan_update_view.dart';
import 'package:band_app/features/plans/presentation/pages/plan_view.dart';
import 'package:band_app/features/plans/presentation/pages/plans_view.dart';
import 'package:band_app/features/song/presentation/pages/create_song_view.dart';
import 'package:band_app/features/song/presentation/pages/song_view.dart';
import 'package:band_app/features/song/presentation/pages/song_view.dart';
import 'package:band_app/features/song/presentation/pages/songs_view.dart';
import 'package:band_app/features/song/presentation/pages/update_song_view.dart';
import 'package:band_app/features/user/presentation/pages/user_view.dart';
import 'package:band_app/features/user/presentation/pages/users_view.dart';
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
          return context.read<AuthorizationBloc>().state is AuthorizationLogoutSuccess ? "/login" : null;
      },
      routes:[
        GoRoute(
          name: 'create-song',
          path: 'create-song',
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
          name: 'update-song',
          path: 'update-song/:id',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: UpdateSongView(id: int.parse(state.pathParameters['id']!)),
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
        GoRoute(
          name: 'create-idea',
          path: 'create-idea',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: const CreateIdeaView(),
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
          name: "users",
          path: 'users',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: const UsersView(),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                  child: child,
                );
              },
            );
          },
          routes: [
            GoRoute(
              name: 'user',
              path: 'user/:id',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: UserView(id: int.parse(state.pathParameters['id']!)),
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
          name: 'plan',
          path: 'plan/:id',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: PlanView(id: int.parse(state.pathParameters['id']!)),
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
          name: 'plan-update',
          path: 'plan-update/:id',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: const PlanUpdateView(),
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
          name: 'plan-create',
          path: 'plan-create',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: const PlanCreateView(),
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
      name: 'connection-lost',
      path: '/connection-lost',
      builder: (context, state) => const ConnectionLostView(),
    ),
  ],
);
