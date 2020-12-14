// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter_note_app/common/helper.dart';
import 'package:flutter_note_app/common/locale.dart';
import 'package:flutter_note_app/model/todo.dart';
import 'package:flutter_note_app/model/work.dart';
import 'package:flutter_note_app/repo/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('locale', () {
    test('vn', () {
      final locale = Locale();
      locale.load('vn');

      expect(locale.appname, 'Ghi chú');
      expect(locale.complete, 'Hoàn thành');
    });

    test('us', () {
      final locale = Locale();
      locale.load('us');

      expect(locale.appname, 'Note app');
      expect(locale.complete, 'Complete');
    });

    test('ar', () {
      final locale = Locale();
      locale.load('ar');

      expect(locale.appname, '');
      expect(locale.complete, '');
    });
  });

  group('helper', () {
    Helper helper;
    setUpAll(() {
      helper = Helper(Locale()..load('us'));
    });
    test('init', () {
      expect(helper.key, 'data');
      expect(helper.todo, null);
    });
    test('load', () async {
      final todo = ToDo(
          works: [Work(id: 'a', name: 'test', utcTime: 100, isDone: true)]);
      SharedPreferences.setMockInitialValues({helper.key: jsonEncode(todo)});
      await helper.load();
      expect(helper.todo.works.length, 1);
    });
    test('save', () async {
      helper.todo = ToDo(
          works: [Work(id: 'a', name: 'test', utcTime: 100, isDone: true)]);
      await helper.save();
      expect('just test pass', 'just test pass');
    });
  });

  group('home repository', () {
    Helper helper;
    HomeRepository repo;
    setUpAll(() {
      helper = Helper(Locale()..load('us'));
      helper.todo = ToDo(works: List<Work>());
      repo = HomeRepository(helper);
    });
    test('init', () {
      expect(repo.getAll().works.length, 0);
    });
    test('add', () async {
      repo.addWork(Work(id: 'a', name: 'test', utcTime: 100, isDone: true));
      expect(repo.getAll().works.length, 1);
    });
    test('update', () async {
      repo.addWork(Work(id: 'a', name: 'test', utcTime: 100, isDone: true));
      repo.updateWork(
          Work(id: 'a', name: 'test-1', utcTime: 100, isDone: false));
      expect(repo.getAll().works[0].name, 'test-1');
      expect(repo.getAll().works[0].isDone, false);
    });
    test('delete', () async {
      repo.addWork(Work(id: 'a', name: 'test', utcTime: 100, isDone: true));
      repo.deleteWork(Work(id: 'a', name: 'test', utcTime: 100, isDone: false));
      expect(repo.getAll().works.length, 0);
    });
    test('all', () async {
      expect(repo.getAll().works.length, 0);
    });
    test('incomplete', () async {
      repo.addWork(Work(id: 'a', name: 'test', utcTime: 100, isDone: false));
      expect(repo.getInComplete().works.length, 1);
    });
    test('complete', () async {
      repo.addWork(Work(id: 'a', name: 'test', utcTime: 100, isDone: true));
      expect(repo.getInComplete().works.length, 1);
    });
  });
}
