import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusDial extends StatelessWidget {
  const StatusDial({
    Key? key,
    required this.imagePath,
  }) : super(key: key);
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SpeedDial(
          overlayOpacity: 0.1,
          elevation: 0,
          backgroundColor: Colors.transparent,
          children: [
            SpeedDialChild(
              backgroundColor: const Color(0xff204F46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              elevation: 1,
              child: const Center(
                child: Icon(
                  Icons.save,
                  size: 23,
                  color: Colors.white,
                ),
              ),
              onTap: () async {},
              label: "Save",
              labelStyle: GoogleFonts.quicksand(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SpeedDialChild(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              backgroundColor: const Color(0xff204F46),
              child: const Center(
                child: Icon(
                  Icons.share,
                  size: 23,
                  color: Colors.white,
                ),
              ),
              onTap: () {},
              label: "Share",
              labelStyle: GoogleFonts.quicksand(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          child: Container(
            height: 49,
            width: 49,
            decoration: BoxDecoration(
              color: const Color(0xff204F46),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.add,
              size: 23,
              color: Colors.white,
            ),
          ));
    });
  }
}
