// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';

import '../../Services/Providers/status_provider.dart';
import '../../Utilities/Widgets/bottom_button.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Image",
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
                StatusProviders().shareStatus(file: widget.imagePath);
              },
              title: "Share",
              icon: Icons.share,
            ),
            const Spacer(),
            const Spacer(),
            BottomButton(
              function: () async {
                final isSaved = await StatusProviders()
                    .downloadAndSaveImage(file: widget.imagePath);
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
        child: Image.file(
          File(widget.imagePath),
          fit: BoxFit.fitWidth,
          filterQuality: FilterQuality.high,
          height: size.height * 0.4,
          width: size.width,
        ),
      ),
    );
  }
}
