
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/core/connectivity/cubit/connectivity_cubit.dart';
import 'package:lahijcenter/core/connectivity/screens/offline_screen.dart';


class ConnectivityWrapper extends StatelessWidget {
  final Widget child;

  const ConnectivityWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    print("ConnectivityWrapper build");
    return BlocBuilder<ConnectivityCubit, bool>(
      builder: (context, isOnline) {
        return Stack(
          children: [
            child,
            if (!isOnline)
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.black54,
                  child: Center(
                    child: OfflineScreen(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}