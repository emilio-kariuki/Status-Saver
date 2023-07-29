part of 'video_player_cubit.dart';

abstract class VideoPlayerState extends Equatable {




  @override
  List<Object> get props => [];


}

class VideoPlayerInitial extends VideoPlayerState {
 
      
}

class VideoButtonState extends VideoPlayerState {
  final VideoPlayerController controller;
  final bool isPlaying;
   VideoButtonState({required this.controller, required this.isPlaying});

  @override
  List<Object> get props => [controller, isPlaying];
}
