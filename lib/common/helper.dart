import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/common/locale.dart';
import 'package:flutter_note_app/model/todo.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  final Locale locale;

  Helper(this.locale);
  final key = 'data';
  ToDo todo;

  Future<void> load() async {
    final sp = await SharedPreferences.getInstance();
    final value = sp.get(key);
    if (value != null) {
      todo = ToDo.fromJson(jsonDecode(value));
    }else {
      todo  = ToDo(works: []);
    }
  }

  Future<void> save() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(key, jsonEncode(todo));
  }

  Future<void> clear() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(key);
    todo = null;
  }
}
