import 'dart:async';

import 'package:band_app/features/home/presentation/bloc/internet/internet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class InternetCubit extends Cubit<InternetState> {
  final Connectivity _connectivity;

  late StreamSubscription<ConnectivityResult> _connectivityStreamSubscription;

  InternetCubit(this._connectivity) : super(const InternetConnectionInitial()){
    _connectivityStreamSubscription = _connectivity.onConnectivityChanged.listen((connectivityResult) {
      checkConnection(connectivityResult);
    });
  }

  void checkConnection(ConnectivityResult result){

    if(result == ConnectivityResult.wifi){
      emit(const InternetConnectionSuccess());
    } else if(result == ConnectivityResult.mobile){
      emit(const InternetConnectionSuccess());
    } else if(result == ConnectivityResult.none){
      emit(const InternetConnectionFailure());
    }
  }

  void checkActualConnection(){
    _connectivity.checkConnectivity().then((connectivityResult) {
      checkConnection(connectivityResult);
    });
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription.cancel();
    return super.close();
  }

}
