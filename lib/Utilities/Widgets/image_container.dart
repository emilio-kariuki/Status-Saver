import 'dart:io';

import 'package:flutter/material.dart';

import '../../Views/Media/image_view.dart';

class StatusImageContainer extends StatelessWidget {
  const StatusImageContainer({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageView(
              imagePath: imagePath,
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 1,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      child: Image.file(
        File(imagePath),
        fit: BoxFit.fitHeight,
        filterQuality: FilterQuality.high,
        height: double.infinity,
      ),
    );
  }
}
