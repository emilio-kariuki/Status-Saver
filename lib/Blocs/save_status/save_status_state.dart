part of 'save_status_bloc.dart';

abstract class SaveStatusState extends Equatable {
  const SaveStatusState();
  
  @override
  List<Object> get props => [];
}

class SaveStatusInitial extends SaveStatusState {}

class SaveStatusLoading extends SaveStatusState {}

class SaveStatusSuccess extends SaveStatusState {
  final bool isSaved;
  const SaveStatusSuccess({required this.isSaved});
  
  @override
  List<Object> get props => [isSaved];
}

class SaveStatusFailure extends SaveStatusState {
  final String message;
  const SaveStatusFailure({required this.message});
  
  @override
  List<Object> get props => [message];
}


