import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/government_bloc/government_event.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import '../../data/model/government_model.dart';
import '../../data/repo/repo.dart';

class GovernmentBloc extends Bloc<GovernmentEvent, BaseState<Government>> {
  final Addadvertisminterepo _addadvertisminterepo;
  
  GovernmentBloc(this._addadvertisminterepo) : super(BaseState()) {
    on<GetGovernments>(_onGetGovernments);
  }

  FutureOr<void> _onGetGovernments(
    GetGovernments event, 
    Emitter<BaseState<Government>> emit
  ) async {
    emit(state.copyWith(status: Status.loading));
    final result = await _addadvertisminterepo.getGovernment();
    result.fold(
      (left) => emit(state.copyWith(
        status: Status.failure, 
        errorMessage: left.message
      )), 
      (right) => emit(state.copyWith(
        status: Status.success, 
        items: right
      ))
    );
  }
}
