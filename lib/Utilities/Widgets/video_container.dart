import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:status_saver_bloc/Services/Providers/status_provider.dart';

import '../../Views/Media/video_view.dart';

class StatusVideoContainer extends StatelessWidget {
  const StatusVideoContainer({super.key, required this.videoPath});

  final String videoPath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 1,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoView(
                  videoPath: videoPath,
                ),
              ),
            );
          },
          child: FutureBuilder<Uint8List>(
            future: StatusProviders.generateThumbnail(videoPath),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      image: MemoryImage(
                        snapshot.data!,
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoView(
                        videoPath: videoPath,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
