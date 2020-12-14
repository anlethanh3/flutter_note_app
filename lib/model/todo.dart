import 'dart:collection';
import 'dart:convert';

import 'package:flutter_note_app/model/work.dart';

class ToDo {
  final List<Work> works;

  ToDo({
    this.works,
  });

  ToDo.fromJson(Map<String, dynamic> json)
      : works = List<Work>.of((jsonDecode(json['works']) as List<dynamic>)
            .map((e) => Work.fromJson(e)));

  Map<String, dynamic> toJson() => {
        'works': jsonEncode(works),
      };
}
