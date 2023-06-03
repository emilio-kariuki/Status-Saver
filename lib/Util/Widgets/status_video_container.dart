import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:status_saver/Providers/app_providers.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class StatusVideoContainer extends StatefulWidget {
  const StatusVideoContainer({
    super.key,
    required this.imagePath,
  });
  final String imagePath;

  @override
  State<StatusVideoContainer> createState() => _StatusVideoContainerState();
}

class _StatusVideoContainerState extends State<StatusVideoContainer> {
  VideoPlayerController? _videoPlayerController;

  Future<Uint8List> generateThumbnail(String videoPath) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 100,
    );

    return uint8list!;
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(File(widget.imagePath), videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((_) {

      },
      
      );
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController!.pause();
    await _videoPlayerController!.dispose();
  }

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
          padding: const EdgeInsets.all(10.0),
          child: Dialog(
            insetPadding: const EdgeInsets.all(0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.58,
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
                            Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                  // padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      shape: BoxShape.circle),
                                  child: Consumer<AppProviders>(
                                      builder: (context, child, file) {
                                    return IconButton(
                                      onPressed: () async {
                                        appProvider.saveVideo(
                                            videoPath: widget.imagePath,
                                            context: context);
                                      },
                                      icon: Icon(
                                          appProvider.isSaved
                                              ? Icons.check
                                              : Icons.save,
                                          size: 22,
                                          color: Colors.white),
                                    );
                                  }),
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
                            ),
                            const SizedBox(
                              width: 5,
                            ),
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
                                              onPressed: () {
                                                _videoPlayerController!
                                                        .value.isPlaying
                                                    ? appProvider.pauseVideo(
                                                        videoPlayerController:
                                                            _videoPlayerController!)
                                                    : appProvider.playVideo(
                                                        videoPlayerController:
                                                            _videoPlayerController!);
                                              },
                                              icon: Icon(
                                                  appProvider.isPaused
                                                      ? Icons.play_arrow
                                                      : Icons.pause,
                                                  size: 22,
                                                  color: Colors.white),
                                            ),
                                  ),
                                  Text(
                                    appProvider.isPaused ? "Play" : "Pause",
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
                            const SizedBox(
                              width: 5,
                            ),
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
                                      FlutterNativeApi.shareImage(
                                          widget.imagePath);
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
                          },
                          // child: StatusVideo(
                          //   videoPlayerController: VideoPlayerController.file(
                          //       File(widget.imagePath)),
                          //   looping: false,
                          //   videoSrc: widget.imagePath,

                          // )
                          child: VideoPlayer(_videoPlayerController!)),
                    ),
                  )),
            ),
          ),
        );
      },
    ).then((value) {
      appProvider.pauseVideo(videoPlayerController: _videoPlayerController!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProviders>(context, listen: false);
    return ElevatedButton(
        onPressed: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => ImageView(
          //               imagePath: imagePath,
          //             )));
          appProvider.playVideo(videoPlayerController: _videoPlayerController!);
          _showImageDialog(context);
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
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
        child: FutureBuilder<Uint8List>(
            future: generateThumbnail(widget.imagePath),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xff666666),
                      width: 0.4,
                    ),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: MemoryImage(snapshot.data!)),
                  ),
                );
              } else {
                return Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xff666666),
                      width: 0.4,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}
