import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:status_saver_bloc/Services/Providers/status_provider.dart';

part 'save_status_event.dart';
part 'save_status_state.dart';

class SaveStatusBloc extends Bloc<SaveStatusEvent, SaveStatusState> {
  SaveStatusBloc() : super(SaveStatusInitial()) {
    on<SaveImage>((event, emit) async {
      try {
        emit(SaveStatusLoading());
        final response = await StatusProviders().downloadAndSaveImage(
          file: event.file,
        );
        emit(SaveStatusSuccess(isSaved: response));
      } catch (e) {
        emit(SaveStatusFailure(message: e.toString()));
      }
    });

    on<SaveVideo>((event, emit) async {
      try {
        emit(SaveStatusLoading());
        final response = await StatusProviders().downloadAndSaveVideo(
          file: event.file,
        );
        emit(SaveStatusSuccess(isSaved: response));
      } catch (e) {
        emit(SaveStatusFailure(message: e.toString()));
      }
    });
  }
}
