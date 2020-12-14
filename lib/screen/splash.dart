import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/common/helper.dart';
import 'package:flutter_note_app/common/locale.dart';
import 'package:flutter_note_app/common/routes.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final router = Injector().get<Router>();
  final helper = Injector().get<Helper>();
  final locale = Injector().get<Locale>();

  @override
  void initState() {
    super.initState();
    initCache();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        child: Builder(
          builder: (context) => Container(
            color: Colors.white,
            child: Center(
              child: Text(
                locale.appname,style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ));
  }

  void initCache() async {
    await helper.load();
    await Future.delayed(Duration(seconds: 1));
    router.navigateTo(context, Routes.home, replace: true);
  }
}
