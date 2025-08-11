import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityCubit extends Cubit<bool> {

  final Connectivity _connectivity = Connectivity();
  final InternetConnectionChecker _connectionChecker = InternetConnectionChecker();
  late StreamSubscription _subscription;
  bool _lastResult = true;

  static final ConnectivityCubit _instance = ConnectivityCubit._internal();

  factory ConnectivityCubit() {
    return _instance;
  }

  ConnectivityCubit._internal() : super(true) {
    _init();
  }

  Future<void> _init() async {
    await _checkInternetStatus();
    _subscription = _connectivity.onConnectivityChanged.listen(
          (_) => _checkInternetStatus(),
    );
  }

  Future<void> _checkInternetStatus() async {
    final result = await _connectionChecker.hasConnection;
    if (result != _lastResult) {
      _lastResult = result;
      emit(result);
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  @override
  void onChange(Change<bool> change) {
    print("${change.nextState.toString()} Changed -----------------");
    super.onChange(change);
  }
}