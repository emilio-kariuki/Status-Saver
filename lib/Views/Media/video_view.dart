// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status_saver_bloc/Services/Providers/status_provider.dart';
import 'package:video_player/video_player.dart';

import '../../Blocs/video_player/video_player_cubit.dart';
import '../../Utilities/Widgets/bottom_button.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key, required this.videoPath});

  final String videoPath;

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController? controller;

  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<VideoPlayerCubit>(context).dispose(controller: controller!);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Video",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.5),
              width: 0.5,
            ),
          ),
        ),
        height: size.height * 0.08,
        width: size.width,
        child: Row(
          children: [
            BottomButton(
              function: () {
                StatusProviders().shareStatus(file: widget.videoPath);
              },
              title: "Share",
              icon: Icons.share,
            ),
            const Spacer(),
            const Spacer(),
            BottomButton(
              function: () async {
                final isSaved = await StatusProviders()
                    .downloadAndSaveVideo(file: widget.videoPath);
                if (isSaved) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Saved Successfully"),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Failed to save"),
                  ));
                }
              },
              title: "Save",
              icon: Icons.download_sharp,
            ),
          ],
        ),
      ),
      body: Center(
        child: SizedBox(
          child: FutureBuilder<VideoPlayerController>(
              future: StatusProviders().showVideo(file: widget.videoPath),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  controller = snapshot.data!;
                  return BlocProvider(
                    create: (context) => VideoPlayerCubit(),
                    child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
                      builder: (context, state) {
                        return Stack(
                          children: [
                            state is VideoButtonState
                                ? VideoPlayer(state.controller)
                                : VideoPlayer(controller!),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                    child: IconButton(
                                      padding: const EdgeInsets.all(3),
                                      onPressed: () {
                                        if (snapshot.data!.value.isPlaying) {
                                          BlocProvider.of<VideoPlayerCubit>(
                                                  context)
                                              .pause(controller: controller!);
                                        } else {
                                          BlocProvider.of<VideoPlayerCubit>(
                                                  context)
                                              .play(controller: controller!);
                                        }
                                      },
                                      icon: Icon(
                                        state is VideoButtonState &&
                                                state.isPlaying
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: SizedBox(
                      height: 15,
                      width: 15,
                      child: RepaintBoundary(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
