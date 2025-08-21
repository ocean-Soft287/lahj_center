import 'package:bloc/bloc.dart';
import 'package:lahijcenter/Feature/Search/data/repo/search_repo.dart';
import '../../Home/Data/model/item_model.dart';

part 'search_state.dart';



class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchrepo) : super(SearchInitial());

  final Searchrepo searchrepo;

  List<Item> searchList = [];
  int currentPage = 1;
  int totalPages = 1;
  String currentSearchTerm = '';

  void resetSearch() {
    currentPage = 1;
    totalPages = 1;
    searchList.clear();
    emit(SearchInitial());
  }

  void searchByName(String name, {bool isNewSearch = false}) async {
    if ((currentPage > totalPages && !isNewSearch)) return;

    try {
      if (isNewSearch) {
        resetSearch();
        currentSearchTerm = name;
      }

      emit(SearchLoading());

      final response = await searchrepo.searchbyname(currentSearchTerm, currentPage);

      response.fold(
            (failure) {
          emit(SearchFailure("فشل في تحميل النتائج: ${failure.message}"));
        },
            (data) {
          if (data.items.isEmpty && currentPage == 1) {
            emit(SearchFailure("لا توجد نتائج مطابقة."));
          } else {
            searchList.addAll(data.items);
            totalPages = data.totalPages;
            currentPage++;

            emit(SearchSuccess(List.from(searchList)));
          }
        },
      );
    } catch (e) {
      emit(SearchFailure("خطأ في معالجة البيانات: ${e.toString()}"));
    }
  }

  void loadMore() {
    searchByName(currentSearchTerm);
  }
}
