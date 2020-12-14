import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/custom/add_note.dart';
import 'package:flutter_note_app/screen/splash.dart';
import 'package:flutter_note_app/screen/home.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String add = "/add";

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root,
        handler: Handler(
            handlerFunc: (context, params) => Splash(),
            type: HandlerType.route));
    router.define(home,
        handler: Handler(
            handlerFunc: (context, params) => Home(), type: HandlerType.route));
    router.define(add,
        handler: Handler(
            handlerFunc: (context, params) => AddNote(), type: HandlerType.route));
  }
}
