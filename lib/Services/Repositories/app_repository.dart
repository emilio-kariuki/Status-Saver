import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AppRepository {
  //* Ask for permissions from the user

  Future<void> askPermissions() async {
    try {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.camera,
        Permission.manageExternalStorage,
        Permission.mediaLibrary,
        Permission.photos,
      ].request();
      if (statuses[Permission.storage]!.isDenied ||
          statuses[Permission.storage]!.isPermanentlyDenied ||
          statuses[Permission.storage]!.isRestricted ||
          statuses[Permission.manageExternalStorage]!.isDenied ||
          statuses[Permission.manageExternalStorage]!.isPermanentlyDenied ||
          statuses[Permission.manageExternalStorage]!.isRestricted) {
        openAppSettings();
      } else {
        debugPrint("Permission Granted");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
