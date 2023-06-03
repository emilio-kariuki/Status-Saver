import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_saver/Providers/fetch_status.dart';
import 'package:status_saver/Util/Widgets/status_video_container.dart';

class VideosTab extends StatefulWidget {
  const VideosTab({super.key});

  @override
  State<VideosTab> createState() => _VideosTabState();
}

class _VideosTabState extends State<VideosTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final statusVideos = Provider.of<Status>(context);
    final size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.9;
    final double itemWidth = size.width / 2;
    return RefreshIndicator(
      onRefresh: () {
         statusVideos.getStatus(".mp4");
         return Future.value();
        },
      child: Container(
        decoration:  BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(5)),
      
        child: Consumer<Status>(
          builder: (context, value, child) {
            if (statusVideos.getVideos.isEmpty) {
              statusVideos.getStatus(".mp4");
            }
      
            return GridView.builder(
              padding: const EdgeInsets.all(4),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing:8,
                childAspectRatio: (itemWidth / itemHeight),
              ),
              itemCount: statusVideos.getVideos.length,
              itemBuilder: (context, index) {
                return StatusVideoContainer(
                  imagePath: statusVideos.getVideos[index].path,
                );
              },
            );
          },
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
