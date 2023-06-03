import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_saver/Util/Widgets/drawer.dart';
import 'package:status_saver/View/Tabs/photos_tab.dart';
import 'package:status_saver/View/Tabs/videos_tab.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  // bool _isFetched = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: tabController!.length,
      child: Scaffold(
        key: _scaffoldKey,
        // drawer: const  Drawerz(),
        appBar: AppBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () {
             _scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Status Saver",
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          // toolbarHeight: 100,
          bottom: TabBar(
            // isScrollable: true,
            controller: tabController,
            indicatorColor: const Color(0xff204F46),
            tabs: [
              Tab(
                child: Text(
                  "Photos",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFF0ECEC),
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Videos",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFF0ECEC),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: tabController,
            children: const [
              PhotosTab(),
              VideosTab(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
