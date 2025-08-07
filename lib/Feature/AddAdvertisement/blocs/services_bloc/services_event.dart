import 'package:equatable/equatable.dart';

abstract interface class ServicesEvent extends Equatable{
  const ServicesEvent();
  @override
  List<Object?> get props => [];
}
class GetServices extends ServicesEvent{
   const GetServices();
  @override
  List<Object?> get props => [];
}