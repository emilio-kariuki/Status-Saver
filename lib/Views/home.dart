import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_saver_bloc/Blocs/change_theme/change_theme_bloc.dart';
import 'package:status_saver_bloc/Views/Home/photos_page.dart';
import 'package:status_saver_bloc/Views/Home/saved_page.dart';
import 'package:status_saver_bloc/Views/Home/videos_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Status Saver",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          BlocBuilder<ChangeThemeBloc, ChangeThemeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  BlocProvider.of<ChangeThemeBloc>(context).add(ChangeTheme());
                },
                icon: state.isDark
                    ? const Icon(Icons.dark_mode, size: 23,)
                    : const Icon(Icons.light_mode, size: 23,),
              );
            },
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.02,
          ),
        ],
        bottom: TabBar(controller: tabController, tabs: [
          Tab(
            child: Text(
              "Photos",
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Videos",
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Saved",
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ]),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: const [
            PhotosPage(),
            VideosPage(),
            SavedPage(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
