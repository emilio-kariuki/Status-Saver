import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(VideoPlayerInitial());

  void play({required VideoPlayerController controller}) {
    controller.play();
    emit(VideoButtonState(controller: controller, isPlaying: true));
  }

  void pause({required VideoPlayerController controller}) {
    controller.pause();
    emit(VideoButtonState(controller: controller, isPlaying: false));
  }

  void dispose({required VideoPlayerController controller}) {
    controller.dispose();
    emit(VideoPlayerInitial());
  }
}
