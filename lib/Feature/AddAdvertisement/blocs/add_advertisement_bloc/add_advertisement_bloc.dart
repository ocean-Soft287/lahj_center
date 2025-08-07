import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import '../../data/repo/repo.dart';
import 'add_advertisement_event.dart';

class AddAdvertisementBloc extends Bloc<AddAdvertisementEvent, BaseState<String>> {
  final Addadvertisminterepo _addadvertisminterepo;
  
  AddAdvertisementBloc(this._addadvertisminterepo) : super(BaseState()) {
    on<SubmitAdvertisement>(_onSubmitAdvertisement);
  }

  FutureOr<void> _onSubmitAdvertisement(
    SubmitAdvertisement event, 
    Emitter<BaseState<String>> emit
  ) async {
    emit(state.copyWith(status: Status.loading));
    
    final result = await _addadvertisminterepo.addAdvertisminte(
      name: event.name,
      phone: event.phone,
      groupId: event.groupId,
      serviceId: event.serviceId,
      price: event.price,
      isCloseReplies: event.isCloseReplies,
      currencyId: event.currencyId,
      governorateId: event.governorateId,
      area: event.area,
      description: event.description,
      images: event.images,
    );

    result.fold(
      (left) => emit(state.copyWith(
        status: Status.failure, 
        errorMessage: left.message,
      )), 
      (right) => emit(state.copyWith(
        status: Status.success, 
        data: right,
      )),
    );
  }
}
