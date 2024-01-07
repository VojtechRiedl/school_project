import 'package:band_app/features/login/presentation/pages/login_view.dart';
import 'package:band_app/features/login/presentation/pages/register_view.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'login',
      path: '/',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      builder: (context, state) => const RegisterView(),
    ),
    /*
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomeView(),
    )*/
  ],
);