import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Blocs/fetch_status/fetch_status_bloc.dart';
import '../../Utilities/Widgets/video_container.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidth = size.width / 2;
    return BlocProvider(
      create: (context) => FetchStatusBloc()..add(FetchStatusVideos()),
      child: BlocBuilder<FetchStatusBloc, FetchStatusState>(
        builder: (context, state) {
          return RefreshIndicator(
              onRefresh: () {
                BlocProvider.of<FetchStatusBloc>(context)
                    .add(FetchStatusVideos());
                return Future.value();
              },
              child: state is FetchStatusLoading
                  ? const Center(
                      child: SizedBox(
                        height: 15,
                        width: 15,
                        child: RepaintBoundary(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : state is FetchStatusSuccess
                      ? GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: (itemWidth / itemHeight),
                          ),
                          itemCount: state.statuses.length,
                          itemBuilder: (context, index) {
                            return StatusVideoContainer(
                              videoPath: state.statuses[index].path,
                            );
                          },
                        )
                      : const Center(
                          child: SizedBox(
                            height: 15,
                            width: 15,
                            child: RepaintBoundary(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ));
        },
      ),
    );
  }
}
