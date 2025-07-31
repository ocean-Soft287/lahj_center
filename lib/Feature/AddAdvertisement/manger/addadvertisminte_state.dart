part of 'addadvertisminte_cubit.dart';

abstract class AddadvertisminteState {}

class AddadvertisminteInitial extends AddadvertisminteState {}

class AddadvertisminteLoading extends AddadvertisminteState {}

class AddadvertisminteSuccess extends AddadvertisminteState {
  final List<dynamic> data;
  final bool fromCache;

  AddadvertisminteSuccess(this.data, {this.fromCache = false});
}

class AddadvertisminteFailure extends AddadvertisminteState {
  final String message;

  AddadvertisminteFailure(this.message);
}



class AddadvertisminteprocessSuccess extends AddadvertisminteState {
  final String data;


  AddadvertisminteprocessSuccess(this.data,);
}
