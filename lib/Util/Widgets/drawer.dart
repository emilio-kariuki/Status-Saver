import 'package:flutter/material.dart';

class Drawerz extends StatelessWidget {
  const Drawerz({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
             DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xff204F46),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: 
                    BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(100),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 0.9,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "lib/Assets/status.png",
                        height: 70,
                        width: 70,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text(
                    "Status Saver",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   
                  const Text(
                    "v1.0.0",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/");
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/settings");
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/about");
              },
            ),
          ],
        ),
      ),
    );
  }
}