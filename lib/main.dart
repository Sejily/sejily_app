import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sejily/core/routes/app_router.dart';
import 'package:sejily/core/services/secure_storage_service.dart';
import 'package:sejily/core/utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await StorageService.instance.init();
  runApp(const ProviderScope(child: SejilyApp()));
}

class SejilyApp extends ConsumerWidget {
  const SejilyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Sejily',
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'IBM_Plex_Sans_Arabic',
        scaffoldBackgroundColor: AppColors.whiteGray,
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
