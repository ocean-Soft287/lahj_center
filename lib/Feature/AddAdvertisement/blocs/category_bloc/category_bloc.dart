import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/category_bloc/category_event.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import '../../data/model/group.dart';
import '../../data/repo/repo.dart';

class CategoryBloc extends Bloc<CategoryEvent, BaseState<Group>> {
  final Addadvertisminterepo _addadvertisminterepo;

  CategoryBloc(this._addadvertisminterepo) : super(BaseState()) {
    on<GetCategories>(_onGetCategories);
  }

  FutureOr<void> _onGetCategories(
    GetCategories event,
    Emitter<BaseState<Group>> emit,
  ) async {
    if (state.items.isNotEmpty) return;
    emit(state.copyWith(status: Status.loading));
    final result = await _addadvertisminterepo.getgroup();
    result.fold(
      (left) => emit(
        state.copyWith(status: Status.failure, errorMessage: left.message),
      ),
      (right) => emit(state.copyWith(status: Status.success, items: right)),
    );
  }
}
