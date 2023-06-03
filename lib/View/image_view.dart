import 'dart:io';

import 'package:flutter/material.dart';



class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      
      backgroundColor: Colors.black,
      
      body: Center(
          child: Container(
        height: height * 0.45,
        width: width ,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xff666666),
            width: 0.4,
          ),
          image: DecorationImage(
              fit: BoxFit.cover, image: FileImage(File(imagePath))),
        ),
      )),
    );
  }
}
