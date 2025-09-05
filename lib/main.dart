import 'package:flutter/material.dart';
import 'package:sejily/core/routes/app_router.dart';

void main() {
  runApp(const SejilyApp());
}

class SejilyApp extends StatelessWidget {
  const SejilyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sejily',
      routerConfig: AppRouter.router,
      theme: ThemeData(fontFamily: 'IBM_Plex_Sans_Arabic'),
    );
  }
}
