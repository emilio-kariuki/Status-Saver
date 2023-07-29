import 'dart:io';
import 'dart:typed_data';

import 'package:status_saver_bloc/Services/Repositories/status_repository.dart';
import 'package:video_player/video_player.dart';

class StatusProviders {
  //* fetch all status from the phone that have been saved

  Future<List<FileSystemEntity>> fetchStatus({required String ext}) async {
    final response = await StatusRepository().fetchStatus(ext: ext);
    return response;
  }

  //* save the status to the phone

  Future<bool> downloadAndSaveImage({required String file}) async {
    final response = await StatusRepository().downloadAndSaveImage(file: file);
    return response;
  }

  //* save the video to the phone

  Future<bool> downloadAndSaveVideo({required String file}) async {
    final response = await StatusRepository().downloadAndSaveVideo(file: file);
    return response;
  }

  //* share the status to other apps

  Future<void> shareStatus({required String file}) async {
    final response = await StatusRepository().shareStatus(file: file);
    return response;
  }

  //* show the video using the video_player package

   Future<VideoPlayerController> showVideo({required String file}) async {
    final response = await StatusRepository().showVideo(file: file);
    return response;
   }

  //* generate the thumbnail for the video

  static Future<Uint8List> generateThumbnail(String videoPath) async {
    final response = await StatusRepository().generateThumbnail(file: videoPath);
    return response;
  }
}
