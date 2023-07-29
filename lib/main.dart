import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_saver_bloc/Blocs/change_theme/change_theme_bloc.dart';
import 'package:status_saver_bloc/Blocs/fetch_status/fetch_status_bloc.dart';
import 'package:status_saver_bloc/Services/Providers/app_provider.dart';
import 'Utilities/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppProviders().askPermissions();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChangeThemeBloc()..add(InitialTheme()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => FetchStatusBloc()..add(FetchStatusImages()),
        ),
       
      ],
      child: BlocBuilder<ChangeThemeBloc, ChangeThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Status Saver',
            theme: FlexThemeData.light(
              onBackground: const Color(0xffF6F6F6),
              colors: const FlexSchemeColor(
                primary: Color(0xff065808),
                primaryContainer: Color(0xff9ee29f),
                secondary: Color(0xff365b37),
                secondaryContainer: Color(0xffaebdaf),
                tertiary: Color(0xff2c7e2e),
                tertiaryContainer: Color(0xffb8e6b9),
                appBarColor: Color(0xffb8e6b9),
                error: Color(0xffb00020),
                
              ),
              surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
              blendLevel: 7,
              subThemesData: const FlexSubThemesData(
                blendOnLevel: 10,
                blendOnColors: false,
                useM2StyleDividerInM3: true,
                inputDecoratorBorderType: FlexInputBorderType.underline,
                inputDecoratorUnfocusedBorderIsColored: false,
              ),
              visualDensity: FlexColorScheme.comfortablePlatformDensity,
              useMaterial3: true,
              swapLegacyOnMaterial3: true,
              fontFamily: GoogleFonts.inter().fontFamily,
            ),
            darkTheme: FlexThemeData.dark(
              colors: const FlexSchemeColor(
                primary: Color(0xff629f80),
                primaryContainer: Color(0xff274033),
                secondary: Color(0xff81b39a),
                secondaryContainer: Color(0xff4d6b5c),
                tertiary: Color(0xff88c5a6),
                tertiaryContainer: Color(0xff356c50),
                appBarColor: Color(0xff356c50),
                error: Color(0xffcf6679),
              ),
              surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
              blendLevel: 30,
              bottomAppBarElevation: 1.5,
              subThemesData: const FlexSubThemesData(
                blendOnLevel: 20,
                useM2StyleDividerInM3: true,
                inputDecoratorBorderType: FlexInputBorderType.underline,
                inputDecoratorUnfocusedBorderIsColored: false,
              ),
              visualDensity: FlexColorScheme.comfortablePlatformDensity,
              useMaterial3: true,
              swapLegacyOnMaterial3: true,
              fontFamily: GoogleFonts.inter().fontFamily,
            ),
            routerConfig: router,
            // themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
