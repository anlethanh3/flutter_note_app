import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

import 'common/helper.dart';
import 'common/routes.dart';
import 'common/locale.dart';

void main() {
  final injector = Injector();
  final router = Router();
  final locale = Locale()..load('us');
  final helper = Helper(locale);
  Routes.configureRoutes(router);
  injector.map((injector) => helper, isSingleton: true);
  injector.map((injector) => router, isSingleton: true);
  injector.map((injector) => locale, isSingleton: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final router = Injector().get<Router>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Note App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Arsenal',
      ),
      onGenerateRoute: router.generator,
    );
  }
}
