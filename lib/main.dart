import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qiita_app/components/scaffold_with_nav_bar.dart';
import 'package:qiita_app/routes/routes.dart';

Future<void> main() async {
  await dotenv.load();
  await Hive.initFlutter();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(routes: [
    ShellRoute(
      routes: $appRoutes,
      builder: (context, state, child) => ScaffoldWithNavBar(child: child),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Qiita',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Noto Sans JP",
      ),
      routerConfig: _router,
    );
  }
}
