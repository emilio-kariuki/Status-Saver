part of 'fetch_status_bloc.dart';

abstract class FetchStatusEvent extends Equatable {
  const FetchStatusEvent();

  @override
  List<Object> get props => [];
}

class FetchStatusImages extends FetchStatusEvent {}

class FetchStatusVideos extends FetchStatusEvent {}
