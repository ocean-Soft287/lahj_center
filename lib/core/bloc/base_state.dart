import 'package:equatable/equatable.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

enum Status { initial, success, failure, loading, loadingMore, custom }
extension BaseStateExtensions<T> on BaseState<T> {
  bool get isInitial => status == Status.initial;
  bool get isLoading => status == Status.loading;
  bool get isSuccess => status == Status.success;
  bool get isFailure => status == Status.failure;
  bool get isLoadingMore => status == Status.loadingMore;
  bool get isCustom => status == Status.custom;
}

class BaseState<T> extends Equatable {
  final Status status;
  final T? data;
  final List<T> items;
  final String? errorMessage;
  final Failure? failure;
  final Map<String, dynamic> metadata;

  const BaseState({
    this.status = Status.initial,
    this.data,
    this.items = const [],
    this.errorMessage,
    this.failure,
    this.metadata = const {},
  });

  BaseState<T> copyWith({
    Status? status,
    T? data,
    List<T>? items,
    String? errorMessage,
    Failure? failure,
    Map<String, dynamic>? metadata,
  }) {
    return BaseState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
      failure: failure ?? this.failure,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
    status,
    data,
    items,
    errorMessage,
    failure,
    metadata,
  ];
}
