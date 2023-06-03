// ignore_for_file: avoid_print


import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class RepositoryServices {
  static Future<bool> downloadAndSave({required String file}) async {
    try {
      final status = await Permission.storage.request();
      if (status.isDenied) {
        Permission.storage.request();
        print("Permission Denied");
        return false;
      }
      if (status.isGranted) {
        final result = await GallerySaver.saveImage(file, albumName: "Status");
        print(result);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
  static Future<bool> downloadAndSaveVideo({required String file}) async {
    try {
      final status = await Permission.storage.request();
      if (status.isDenied) {
        Permission.storage.request();
        print("Permission Denied");
        return false;
      }
      if (status.isGranted) {
        final result = await GallerySaver.saveVideo(file, albumName: "Status");
        print(result);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
