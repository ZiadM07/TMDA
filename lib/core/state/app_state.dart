import 'package:equatable/equatable.dart';

enum StateStatus { initial, loading, loadingOverlay, success, error, none }

class AppState<T> extends Equatable {
  final StateStatus status;
  final T? data;
  final String? message;

  const AppState({this.status = StateStatus.initial, this.data, this.message});

  AppState<T> copyWith({StateStatus? status, T? data, String? message}) {
    return AppState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, data, message];
}
