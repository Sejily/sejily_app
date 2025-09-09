import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sejily/core/routes/app_router.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();

  runApp(const ProviderScope(child: SejilyApp()));
}

extension on HiveInterface {
  Future<void> initFlutter() async {}
}

class SejilyApp extends StatelessWidget {
  const SejilyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Sejily',
      routerConfig: AppRouter.router,
      theme: ThemeData(
        fontFamily: 'IBM_Plex_Sans_Arabic',
        scaffoldBackgroundColor: AppColors.white,
      ),

      //* Handling the localization and RTL support
      locale: const Locale('ar'),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [Locale('ar')],
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
    );
  }
}
