part of 'save_status_bloc.dart';

abstract class SaveStatusEvent extends Equatable {
  const SaveStatusEvent();

  @override
  List<Object> get props => [];
}

class SaveImage extends SaveStatusEvent {
  final String file;
  const SaveImage({required this.file});

  @override
  List<Object> get props => [file];
}


class SaveVideo extends SaveStatusEvent {
  final String file;
  const SaveVideo({required this.file});

  @override
  List<Object> get props => [file];
}