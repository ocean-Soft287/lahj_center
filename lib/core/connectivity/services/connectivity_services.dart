import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/connectivity_cubit.dart';
import '../cubit/connectivity_state.dart';

class ConnectivityService {
  static bool isOnline(BuildContext context) {
    final state = context.read<ConnectivityCubit>().state;
    return state is ConnectivityOnline;
  }

  static bool isOffline(BuildContext context) {
    final state = context.read<ConnectivityCubit>().state;
    return state is ConnectivityOffline;
  }

  static void showConnectivitySnackBar(BuildContext context, ConnectivityState state) {
    final messenger = ScaffoldMessenger.of(context);
    
    if (state is ConnectivityOnline) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('تم استعادة الاتصال بالإنترنت'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } else if (state is ConnectivityOffline) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('تم فقدان الاتصال بالإنترنت'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}