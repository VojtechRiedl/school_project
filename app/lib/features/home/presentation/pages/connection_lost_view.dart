import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/bloc/internet/internet_cubit.dart';
import 'package:band_app/features/home/presentation/bloc/internet/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ConnectionLostView extends StatelessWidget {
  const ConnectionLostView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetCubit, InternetState>(
      builder: (BuildContext context, InternetState state) {
        return const PopScope(
          canPop: false,
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, size: 128, color: Palette.dark),
                  Text('Připojení ztraceno', style: TextStyle(fontSize: 24, color: Palette.dark)),
                  SizedBox(height: 20),
                  /*ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Palette.dark),
                    ),
                    onPressed: () {
                      context.read<InternetCubit>().checkActualConnection();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.refresh),
                          Text('Pokusit se znovu'),
                        ],
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        );
      }, listener: (BuildContext context, InternetState state) {
        if(state is InternetConnectionSuccess){
          if(GoRouter.of(context).canPop()){
            GoRouter.of(context).pop();
          }
        }
      },
    );
  }

}