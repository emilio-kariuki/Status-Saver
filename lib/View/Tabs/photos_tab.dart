import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_saver/Providers/fetch_status.dart';
import 'package:status_saver/Util/Widgets/status_image_container.dart';

class PhotosTab extends StatelessWidget {
  const PhotosTab({super.key});

  @override
  Widget build(BuildContext context) {
    final statusImages = Provider.of<Status>(context);
    final size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidth = size.width / 2;
    return Container(
      decoration: const BoxDecoration(color: Colors.black87),
      child: RefreshIndicator(
        onRefresh: () {
          statusImages.getStatus(".jpg");
          return Future.value();
        },
        child: Consumer<Status>(
          builder: (context, value, child) {
            if (statusImages.getImages.isEmpty) {
              statusImages.getStatus(".jpg");
            }
            return statusImages.isFetching
                ? const Center(
                    child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing:8,
                      childAspectRatio: (itemWidth / itemHeight),
                    ),
                    itemCount: statusImages.getImages.length,
                    itemBuilder: (context, index) {
                      return StatusImageContainer(
                        imagePath: statusImages.getImages[index].path,
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
