import '../../Data/model/categories.dart';


abstract class HomeState {}

class InitializeHome extends HomeState {}

class ChangeIndexBottom extends HomeState {}

class ChangeCategoryIndex1 extends HomeState {}

class HomeUpdatedState extends HomeState {
  final Map<String, dynamic> itemSalah;

  HomeUpdatedState(this.itemSalah);
}

class Categoryload extends HomeState {}

class Categorysuccful extends HomeState {
  final List<Categorygroups> categories;
  Categorysuccful({required this.categories});
}

class CategoryFailure extends HomeState {
  final String error;
  CategoryFailure(this.error);
}

