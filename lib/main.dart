import 'package:flutter/material.dart';

import 'app_state.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await AppState.load();
  runApp(TerrimapApp(app: app));
}

class TerrimapApp extends StatelessWidget {
  final AppState app;
  const TerrimapApp({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Master – Germany',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF2E7D32), useMaterial3: true),
      home: HomeScreen(app: app),
    );
  }
}
