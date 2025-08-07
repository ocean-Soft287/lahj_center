import 'package:equatable/equatable.dart';

abstract class GovernmentEvent extends Equatable {
  const GovernmentEvent();
  
  @override
  List<Object?> get props => [];
}

class GetGovernments extends GovernmentEvent {
  const GetGovernments();
  
  @override
  List<Object?> get props => [];
}
