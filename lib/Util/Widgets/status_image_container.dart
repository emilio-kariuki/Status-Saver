import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:status_saver/Providers/app_providers.dart';
import 'package:status_saver/View/image_view.dart';


class StatusImageContainer extends StatelessWidget {
  const StatusImageContainer({super.key, required this.imagePath});
  final String imagePath;

  void _showImageDialog(
    BuildContext context,
  ) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final appProvider = Provider.of<AppProviders>(context, listen: false);
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.75),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(25.0),
          child: Dialog(
            insetPadding: const EdgeInsets.all(0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Scaffold(
                    bottomNavigationBar: Container(
                        height: height * 0.11,
                        width: width,
                        decoration: BoxDecoration(
                          border: const Border(
                              top: BorderSide(
                                  width: 0.4, color: Color(0xff666666))),
                          color: Colors.grey[900],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Consumer<AppProviders>(
                              builder: (context, value, child) {
                                return Column(
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.only(top: 10, bottom: 5),
                                    // padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                        onPressed: () async {
                                          appProvider.saveImage(
                                              imagePath: imagePath,
                                              context: context);
                                              Navigator.pop(context);
                                        },
                                        icon: Icon(
                                            appProvider.isSaved
                                                ? Icons.check
                                                : Icons.save,
                                            size: 22,
                                            color: Colors.white),
                                      ),
                                  ),
                                  Text(
                                   appProvider.isSaved ? "Saved" : "Save",
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              );
                              },
                            ),
                            const SizedBox(width: 5,),
                            
                            Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                  // padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                    onPressed: () {
                                      FlutterNativeApi.shareImage(imagePath);
                                    },
                                    icon: const Icon(Icons.share,
                                        size: 22, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  "Share",
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                    // floatingActionButton: StatusDial(
                    //   imagePath: imagePath,
                    // ),
                    backgroundColor: Colors.black,
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(40),
                      child: AppBar(
                        backgroundColor: Colors.grey[900],
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        title: Text(
                          "Status Saver",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    body: Semantics(
                      button: true,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(imagePath: imagePath)));
                          },
                          child: Container(
                              height: height * 0.5,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: FileImage(File(imagePath))),
                              ))),
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => ImageView(
          //               imagePath: imagePath,
          //             )));
          _showImageDialog(context);
        },
        style: ElevatedButton.styleFrom(
          elevation:1,
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          shadowColor: Colors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(
                color: Color(0xff666666),
                width: 0.4,
              )),
        ),
        child: Container(
            decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
              fit: BoxFit.fitHeight, image: FileImage(File(imagePath))),
        )));
  }
}
