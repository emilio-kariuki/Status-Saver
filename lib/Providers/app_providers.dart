// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:status_saver/Repository/extension.dart';
import 'package:status_saver/Repository/services.dart';
import 'package:video_player/video_player.dart';

class AppProviders extends ChangeNotifier {
  bool isSaved = false;
  bool isPaused = false;

  saveImage({required String imagePath, required BuildContext context}) async {
    final isSaving = await RepositoryServices.downloadAndSave(file: imagePath);

    if (isSaving) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          duration: const  Duration(seconds: 2),
          
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xff204F46),
          content: const Row(
            children: [
              Icon((Icons.celebration_sharp), color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text("Image saved succesfuly"),
            ],
          )));
      isSaved = true;
      notifyListeners();

      Future.delayed(const Duration(seconds: 3), () {
        isSaved = false;
        notifyListeners();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          content: Text(" Saving failed ")));
    }
  }

  saveVideo({required String videoPath, required BuildContext context}) async {
    final isSaving =
        await RepositoryServices.downloadAndSaveVideo(file: videoPath);

    if (isSaving) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          duration: const  Duration(seconds: 2),
          
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xff204F46),
          content: const Row(
            children: [
              Icon((Icons.celebration_sharp), color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text("Video saved successfully"),
            ],
          )));
          
      isSaved = true;
      notifyListeners();

      Future.delayed(const Duration(seconds: 3), () {
        isSaved = false;
        notifyListeners();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          content: Text(" Saving failed ")));
    }
  }

  pauseVideo({required VideoPlayerController videoPlayerController}) {
    videoPlayerController.pause();
    isPaused = true;
    notifyListeners();
  }

  playVideo({required VideoPlayerController videoPlayerController}) {
    videoPlayerController.play();
    isPaused = false;
    notifyListeners();
  }
}
