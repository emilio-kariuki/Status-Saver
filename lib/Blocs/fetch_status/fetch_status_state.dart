part of 'fetch_status_bloc.dart';

abstract class FetchStatusState extends Equatable {
  const FetchStatusState();

  @override
  List<Object> get props => [];
}

class FetchStatusInitial extends FetchStatusState {}

class FetchStatusLoading extends FetchStatusState {}

class FetchStatusSuccess extends FetchStatusState {
  final List<FileSystemEntity> statuses;
  const FetchStatusSuccess({required this.statuses});

  @override
  List<Object> get props => [statuses];
}

class FetchStatusFailure extends FetchStatusState {
  final String message;
  const FetchStatusFailure({required this.message});

  @override
  List<Object> get props => [message];
}
