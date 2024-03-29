import 'package:band_app/config/routes/routes.dart';
import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/bloc/internet/internet_cubit.dart';
import 'package:band_app/features/home/presentation/bloc/internet/internet_state.dart';
import 'package:band_app/features/home/presentation/bloc/navigation/navigation_cubit.dart';
import 'package:band_app/features/ideas/presentation/bloc/ideas/ideas_bloc.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_bloc.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_state.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_bloc.dart';
import 'package:band_app/features/user/presentation/bloc/users_bloc.dart';
import 'package:band_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthorizationBloc>(
          create: (_) => sl<AuthorizationBloc>(),
        ),
        BlocProvider<SongsBloc>(
          create: (_) => sl<SongsBloc>(),
        ),
        BlocProvider<IdeasBloc>(
          create: (_) => sl<IdeasBloc>(),
        ),
        BlocProvider<UsersBloc>(
          create: (_) => sl<UsersBloc>(),
        ),
        BlocProvider<NavigationCubit>(
          create: (_) => sl<NavigationCubit>(),
        ),
        BlocProvider<InternetCubit>(
          create: (_) => sl<InternetCubit>(),
        ),
      ],

      child: MultiBlocListener(
        listeners: [
          BlocListener<InternetCubit, InternetState>(
            listener: (context, state) {

            },
          ),

        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Art Of The Crooked',
          routeInformationProvider: router.routeInformationProvider,
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          theme: ThemeData(
            useMaterial3: false,
            /*textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).textTheme,
            ),*/
            textTheme: const TextTheme(
                headlineLarge: TextStyle(
                  color: Palette.dark,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                labelMedium: TextStyle(
                  color: Palette.secondDark,
                  fontSize: 16,
                ),
                bodySmall:TextStyle(
                  color: Palette.dark,
                  fontSize: 12,
                ),
                titleMedium: TextStyle(
                  color: Palette.dark,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
            ),
            colorScheme: const ColorScheme(
              background: Palette.white,
              brightness: Brightness.light,
              primary: Palette.light,
              onPrimary: Palette.light,
              secondary: Palette.secondLight,
              onSecondary: Palette.secondLight,
              error: Palette.error,
              onError: Palette.error,
              onBackground: Palette.white,
              surface: Palette.yellow,
              onSurface: Palette.dark,
              outline: Palette.secondDark,
            ),

            appBarTheme: const AppBarTheme(
              elevation: 5,
              backgroundColor: Palette.dark,
              foregroundColor: Palette.light,
              titleTextStyle: TextStyle(color: Palette.light, fontSize: 20, fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: Palette.light),
              actionsIconTheme: IconThemeData(color: Palette.light),
            ),

            bottomAppBarTheme: const BottomAppBarTheme(
              elevation: 5,
            ),


            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Palette.dark),
                foregroundColor: MaterialStateProperty.all<Color>(Palette.yellow),
                textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 16)),
                shape: MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width - 40, 60)),
              ),
            ),

            cardTheme: CardTheme(
              margin: const EdgeInsets.all(0),
              color: Palette.secondLight,
              clipBehavior: Clip.antiAlias,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),

            snackBarTheme: const SnackBarThemeData(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Palette.dark,
              contentTextStyle: TextStyle(color: Palette.light),
            ),

            sliderTheme: const SliderThemeData(
              trackHeight: 10,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
              thumbColor: Palette.dark,
              activeTrackColor: Palette.activeTrackColor,
              inactiveTrackColor: Palette.inactiveTrackColor,
              allowedInteraction: SliderInteraction.tapAndSlide
            )

          ),
          darkTheme: ThemeData(
            useMaterial3: false,
            /*textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).textTheme,
            ),*/

            textTheme: const TextTheme(
              headlineLarge: TextStyle(
                color: Palette.light,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              labelMedium: TextStyle(
                color: Palette.secondLight,
                fontSize: 16,
              ),
              bodySmall:TextStyle(
                color: Palette.light,
                fontSize: 12,
              ),
              titleMedium: TextStyle(
                color: Palette.light,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              titleLarge: TextStyle(
                color: Palette.light,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),

            ),

            colorScheme: const ColorScheme(
                background: Palette.dark,
                brightness: Brightness.dark,
                primary: Palette.dark,
                onPrimary: Palette.dark,
                secondary: Palette.secondDark,
                onSecondary: Palette.secondDark,
                error: Palette.error,
                onError: Palette.error,
                onBackground: Palette.dark,
                surface: Palette.yellow,
                onSurface: Palette.light,
                outline: Palette.secondLight,
            ),

            splashColor: Palette.secondDark,

            appBarTheme: const AppBarTheme(
              elevation: 5,
              backgroundColor: Palette.dark,
              foregroundColor: Palette.light,
              titleTextStyle: TextStyle(color: Palette.light, fontSize: 20, fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: Palette.light),
              actionsIconTheme: IconThemeData(color: Palette.light),
            ),

            bottomAppBarTheme: const BottomAppBarTheme(
              color: Palette.dark,
              elevation: 5,

            ),

            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Palette.yellow),
                foregroundColor: MaterialStateProperty.all<Color>(Palette.dark),
                textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 16)),
                shape: MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width - 40, 60)),
              ),
            ),

            cardTheme: CardTheme(
              margin: const EdgeInsets.all(0),
              color: Palette.secondDark,
              clipBehavior: Clip.antiAlias,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),

            snackBarTheme: const SnackBarThemeData(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Palette.light,
              contentTextStyle: TextStyle(color: Palette.dark),
            ),

              sliderTheme: const SliderThemeData(
                  trackHeight: 10,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
                  thumbColor: Palette.dark,
                  activeTrackColor: Palette.activeTrackColor,
                  inactiveTrackColor: Palette.inactiveTrackColor,
                  allowedInteraction: SliderInteraction.tapAndSlide
              )
          ),
          themeMode: ThemeMode.system,
        ),
      ),
    );
  }
}
