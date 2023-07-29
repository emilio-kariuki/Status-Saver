import 'package:go_router/go_router.dart';

import '../Views/home.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const Home(),
  ),
  
]);
