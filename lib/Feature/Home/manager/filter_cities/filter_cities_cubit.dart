import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/Home/Data/model/item_model.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/filter_by_city_data_repo.dart';

import '../../../../core/bloc/base_state.dart';

class FilterCitiesCubit extends Cubit<BaseState<Item>> {
  final FilterByCityDataRepo filterByCityDataRepo;
  FilterCitiesCubit(this.filterByCityDataRepo) : super(BaseState());

int currentPage = 1;
final int perPage = 10;
bool hasMoreData = true;
bool isLoadingMore = false;
  Future<void> fetchFirstPage(int governorateId) async {
    emit(state.copyWith(status: Status.loading));
    currentPage = 1;
    hasMoreData = true;

    final result = await filterByCityDataRepo.getCitiesByGovernorate(
      governorateId: governorateId,
      params: PaginationParams(page: currentPage, perPage: perPage),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(status: Status.failure, errorMessage: failure.message));
      },
      (items) {
        emit(state.copyWith(status: Status.success, items: items));
        if (items.length < perPage) {
          hasMoreData = false;
        }
      },
    );
  }
  Future<void> fetchNextPage(int governorateId) async {

    if (isLoadingMore || !hasMoreData) return;

    isLoadingMore = true;
    currentPage++;

    final result = await filterByCityDataRepo.getCitiesByGovernorate(
      governorateId: governorateId,
      params: PaginationParams(page: currentPage, perPage: perPage),
    );

    result.fold(
      (failure) {
        isLoadingMore = false;
        emit(state.copyWith(status: Status.failure, errorMessage: failure.message));
      },
      (items) {
        final updatedItems = List<Item>.from(state.items)..addAll(items);
        emit(state.copyWith(status: Status.success, items: updatedItems));
        isLoadingMore = false;
        if (items.length < perPage) {
          hasMoreData = false;
        }
      },
    );

  }
}
