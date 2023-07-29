import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:status_saver_bloc/Utilities/global_constants.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class StatusRepository {
  //* fetch all status from the phone that have been saved

  Future<List<FileSystemEntity>> fetchStatus({required String ext}) async {
    try {
      var statuses = <FileSystemEntity>[];
      final Directory videoDir = Directory(STATUS_PATH);
      if (Directory(videoDir.path).existsSync()) {
        final items = videoDir.listSync().toList();
        items.sort(
            (a, b) => b.statSync().modified.compareTo(a.statSync().modified));
        statuses =
            items.where((element) => element.path.endsWith(ext)).toList();
      }
      return statuses;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  //* save the status to the phone

  Future<bool> downloadAndSaveImage({required String file}) async {
    try {
      final status = await Permission.storage.request();
      if (status.isDenied) {
        Permission.storage.request();
        debugPrint("Permission Denied");
        return false;
      }
      if (status.isGranted) {
        final result = await GallerySaver.saveImage(file, albumName: "Status Saver");
        debugPrint(result.toString());
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  //* save the video to the phone

  Future<bool> downloadAndSaveVideo({required String file}) async {
    try {
      final status = await Permission.storage.request();
      if (status.isDenied) {
        Permission.storage.request();
        debugPrint("Permission Denied");
        return false;
      }
      if (status.isGranted) {
        final result = await GallerySaver.saveVideo(file, albumName: "Status Saver");
        debugPrint(result.toString());
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  //* show the video using the video_player package

  Future<VideoPlayerController> showVideo({required String file}) async {
    try {
      final controller = VideoPlayerController.file(File(file));
      await controller.initialize();
      return controller;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  //* share the status to other apps

  Future<void> shareStatus({required String file}) async {
    try {
      final status = await Permission.storage.request();
      if (status.isDenied) {
        Permission.storage.request();
        debugPrint("Permission Denied");
        return;
      }
      if (status.isGranted) {
        await Share.shareFiles([file]);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  //* generate the thumbnail for the video

  Future<Uint8List> generateThumbnail({required String file}) async {
    try {
      final thumbnail = await VideoThumbnail.thumbnailData(
        video: file,
        imageFormat: ImageFormat.PNG,
        quality: 100,
        maxWidth: 100,
        maxHeight: 400,
      );
      return thumbnail!;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
