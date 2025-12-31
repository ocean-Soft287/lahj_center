import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/services_bloc/services_event.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/data/model/services.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';

import '../../data/repo/repo.dart';

class ServicesBloc extends Bloc<ServicesEvent, BaseState<Services>> {
  final Addadvertisminterepo _addadvertisminterepo;
  ServicesBloc(this._addadvertisminterepo) : super(BaseState()) {
    on<GetServices>(_onGetServices);
  }

  FutureOr<void> _onGetServices(
    GetServices event,
    Emitter<BaseState<Services>> emit,
  ) async {
    if (state.items.isNotEmpty) return;
    emit(state.copyWith(status: Status.loading));
    final result = await _addadvertisminterepo.getServices();
    result.fold(
      (left) => emit(
        state.copyWith(status: Status.failure, errorMessage: left.message),
      ),
      (right) => emit(state.copyWith(status: Status.success, items: right)),
    );
  }
}
