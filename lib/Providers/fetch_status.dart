// ignore_for_file: avoid_print, unnecessary_string_interpolations

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Status extends ChangeNotifier {
  bool isFetching = false;
  List<FileSystemEntity> _getVideos = [];
  List<FileSystemEntity> _getImages = [];
  final Directory _videoDir = Directory(
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');

  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;

  bool _isWhatsappAvailable = false;

  bool get isWhatsappAvailable => _isWhatsappAvailable;

  void getStatus(String ext) async {
    isFetching = true;
    // notifyListeners();
    await Permission.manageExternalStorage.request();
    final status = await Permission.storage.request();

    if (status.isDenied) {
      Permission.storage.request();
      print("Permission Denied");
      return;
    }

    if (status.isGranted) {
      if (Directory('${_videoDir.path}').existsSync()) {
        final items = _videoDir.listSync();

        if (ext == ".mp4") {
          _getVideos =
              items.where((element) => element.path.endsWith(ext)).toList();

          isFetching = false;

          notifyListeners();
        } else {
          _getImages =
              items.where((element) => element.path.endsWith(ext)).toList();
          isFetching = false;

          notifyListeners();
        }

        _isWhatsappAvailable = true;
        notifyListeners();

      } else {
        isFetching = false;

        print("Not whatsapp found");
        _isWhatsappAvailable = false;
        notifyListeners();
      }
    }
  }
}
