import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_saver/Providers/app_providers.dart';
import 'package:status_saver/Providers/fetch_status.dart';

import 'Util/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Status()),
        ChangeNotifierProvider(
            create: (
          _,
        ) =>
                AppProviders()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: ((settings) =>
            RouteGenerator.generateRoute(settings, context: context)),
      ),
    );
  }
}
